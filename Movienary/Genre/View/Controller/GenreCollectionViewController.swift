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
        title = "Movienary"
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
        collectionView.prepareSkeleton { [weak self] done in
            self?.collectionView.showShimmeringView()
        }
    }

    func displayGenres() {
        collectionView.stopShimmeringView()
        collectionView.reloadData()
    }

    func displayError(message: String) {

    }
}

extension GenreCollectionViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.skeletonCount
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return GenreCollectionViewCell.name
    }

//    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
//        return presenter.cellID
//    }
}

extension GenreCollectionViewController {
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

        if let genre: Genre = presenter.item(at: indexPath.row) {
            cell.setContent(genre)
        }

        return cell
    }
}

