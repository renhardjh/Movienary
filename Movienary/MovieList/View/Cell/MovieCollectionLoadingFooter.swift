//
//  MovieCollectionLoadingFooter.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

class MovieCollectionLoadingFooter: UICollectionReusableView {
    var indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup(){
        addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            indicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
