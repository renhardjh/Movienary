//
//  ColumnFlowLayout.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {

    let coloumnCount: Int
    let itemHeight: CGFloat?

    init(coloumn: Int, height: CGFloat? = nil, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
        self.coloumnCount = coloumn
        self.itemHeight = height
        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(coloumnCount - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(coloumnCount)).rounded(.down)
        if let height = itemHeight {
            itemSize = CGSize(width: itemWidth, height: height)
        } else {
            itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

}
