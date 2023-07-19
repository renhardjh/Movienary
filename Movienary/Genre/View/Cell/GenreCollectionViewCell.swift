//
//  GenreCollectionViewCell.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbName: UILabel!

    func setContent(_ genre: Genre) {
        cardView.backgroundColor = .random()
        lbName.text = genre.name
    }
}
