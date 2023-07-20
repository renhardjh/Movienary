//
//  TitleCollectionViewHeaderCell.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit
import SkeletonView

class TitleCollectionViewHeaderCell: UICollectionReusableView {
    private lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        isSkeletonable = true
        addSubview(lbTitle)
        NSLayoutConstraint.activate([
            lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lbTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lbTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            lbTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    func setContent(_ title: String) {
        lbTitle.text = title
    }
}
