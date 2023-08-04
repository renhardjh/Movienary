//
//  MovieDetailViewController.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit
import SkeletonView

class MovieDetailViewController: BaseViewController, MovieDetailViewInterface {
    @IBOutlet weak var tableView: UITableView!

    var presenter: MovieDetailPresenter!

    convenience init() {
        self.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.loadMovieDetail()
    }

    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }

        let nibCellDetail = UINib(nibName: MovieDetailCell.name, bundle: nil)
        let nibCellReview = UINib(nibName: MovieReviewCell.name, bundle: nil)
        tableView.register(nibCellDetail, forCellReuseIdentifier: MovieDetailCell.name)
        tableView.register(nibCellReview, forCellReuseIdentifier: MovieReviewCell.name)
        tableView.register(TitleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeader.name)
    }

    func displayLoading() {
        tableView.showShimmeringView()
    }

    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.tableView.stopShimmeringView()
        })
    }

    func displayMovieDetail() {
        tableView.reloadData()
    }

    func displayAlert(type: AlertType, message: String) {
        let alert = UIAlertController(title: type.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: type.action, style: .default, handler: { [weak self] _ in
            self?.presenter.loadMovieDetail()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return presenter.sectionCount
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MoviewDetailSection(rawValue: section) {
        case .detail:
            return presenter.detailCount
        case .review:
            return presenter.skeletonCount
        default:
            return 0
        }
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch MoviewDetailSection(rawValue: indexPath.section) {
        case .detail:
            return MovieDetailCell.name
        default:
            return MovieReviewCell.name
        }
    }
}

extension MovieDetailViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sectionCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MoviewDetailSection(rawValue: section) {
        case .detail:
            return presenter.detailCount
        case .review:
            return presenter.reviewCount
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MoviewDetailSection(rawValue: indexPath.section) {
        case .detail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.name, for: indexPath) as? MovieDetailCell else {
                return UITableViewCell()
            }

            cell.delegate = self
            cell.setContent(movie: presenter.movieDetail, trailer: presenter.movieTrailer)

            return cell
        case .review:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewCell.name, for: indexPath) as? MovieReviewCell else {
                return UITableViewCell()
            }

            if let review: MovieReview = presenter.item(at: indexPath.item) {
                cell.setContent(review)
            }

            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == MoviewDetailSection.review.rawValue,
           let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeader.name) as? TitleTableViewHeader,
           presenter.reviewCount > 0 {
            headerView.setContent(presenter.headerReviewTitle)
            
            return headerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == MoviewDetailSection.review.rawValue {
            return UITableView.automaticDimension
        }
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch MoviewDetailSection(rawValue: indexPath.section) {
        case .detail:
            break
        case .review:
            if let cell = tableView.cellForRow(at: indexPath) as? MovieReviewCell {
                tableView.beginUpdates()
                cell.setExpanded()
                tableView.endUpdates()
            }
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.endLessScroll(indexPath)
    }

    @IBAction func didTapButtonTest(_ button: UIButton) {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .fullScreen
        self.present(testVC, animated: true)
    }
}

extension MovieDetailViewController: MovieDetailDelegate {
    func onLoadVideoTrailer() {
        presenter.loadMovieVideo()
    }
}
