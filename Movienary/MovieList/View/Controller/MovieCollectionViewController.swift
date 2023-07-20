//
//  MovieCollectionViewController.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit
import SkeletonView

class MovieCollectionViewController: BaseViewController, MovieCollectionViewInterface {
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: MovieCollectionPresenter!

    convenience init() {
        self.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.loadMovies()
    }

    private func setupView() {
        title = presenter.pageTitle
        collectionView.delegate = self
        collectionView.dataSource = self

        let flowLayout = ColumnFlowLayout(
            coloumn: presenter.coloumnCount,
            height: presenter.cellHeight
        )
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always

        let cellNib = UINib(nibName: MovieCollectionViewCell.name, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.name)
        collectionView.register(TitleCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionViewHeaderCell.name)
        collectionView.register(MovieCollectionLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MovieCollectionLoadingFooter.name)
    }

    func displayLoading() {
        collectionView.prepareSkeleton { [weak self] done in
            self?.collectionView.showShimmeringView()
        }
    }

    func hideLoading() {
        collectionView.stopShimmeringView()
    }

    func displayMovies() {
        collectionView.reloadData()
    }

    func displayAlert(type: AlertType, message: String) {
        let alert = UIAlertController(title: type.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: type.action, style: .default, handler: { [weak self] _ in
            self?.presenter.loadMovies()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieCollectionViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.skeletonCount
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MovieCollectionViewCell.name
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        switch supplementaryViewIdentifierOfKind {
        case UICollectionView.elementKindSectionHeader:
            return TitleCollectionViewHeaderCell.name
        case UICollectionView.elementKindSectionFooter:
            return MovieCollectionLoadingFooter.name
        default:
            return nil
        }
    }
}

extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movieCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.name, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let movie: Movie = presenter.item(at: indexPath.item) {
            cell.setContent(movie)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionViewHeaderCell.name, for: indexPath) as? TitleCollectionViewHeaderCell else {
                return UICollectionReusableView()
            }

            header.setContent(presenter.featureTitle)

            return header

        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieCollectionLoadingFooter.name, for: indexPath) as? MovieCollectionLoadingFooter else {
                return UICollectionReusableView()
            }

            footer.indicator.startAnimating()

            return footer

        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        return headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: presenter.loadingMoreHeight)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.endLessScroll(indexPath)
    }
}
