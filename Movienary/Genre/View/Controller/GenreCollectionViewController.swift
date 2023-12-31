//
//  ViewController.swift
//  Movienary
//
//  Created by RenhardJH on 18/07/23.
//

import UIKit
import SkeletonView

class GenreCollectionViewController: BaseViewController, GenreCollectionViewInterface {
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: GenreCollectionPresenter!

    convenience init() {
        self.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.loadGenres()
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

        let cellNib = UINib(nibName: GenreCollectionViewCell.name, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: GenreCollectionViewCell.name)
        collectionView.register(TitleCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionViewHeaderCell.name)
    }

    func displayLoading() {
        collectionView.prepareSkeleton { [weak self] done in
            self?.collectionView.showShimmeringView()
        }
    }

    func hideLoading() {
        collectionView.stopShimmeringView()
    }

    func displayGenres() {
        collectionView.reloadData()
    }

    func displayAlert(type: AlertType, message: String) {
        let alert = UIAlertController(title: type.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            self?.presenter.loadGenres()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension GenreCollectionViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.skeletonCount
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return GenreCollectionViewCell.name
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return TitleCollectionViewHeaderCell.name
    }
}

extension GenreCollectionViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.genreCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.name, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let genre: Genre = presenter.item(at: indexPath.item) {
            cell.setContent(genre)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionViewHeaderCell.name, for: indexPath) as? TitleCollectionViewHeaderCell else {
            return UICollectionReusableView()
        }

        header.setContent(presenter.featureTitle)

        return header
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let genre: Genre = presenter.item(at: indexPath.item) else { return }
        presenter.selectGenre(genre)
    }
}

