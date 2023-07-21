//
//  TitleTableViewHeader.swift
//  Movienary
//
//  Created by RenhardJH on 21/07/23.
//

import UIKit
import SkeletonView

class TitleTableViewHeader: UITableViewHeaderFooterView {
    private lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
