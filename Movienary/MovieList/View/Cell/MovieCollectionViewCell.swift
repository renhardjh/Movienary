//
//  MovieCollectionViewCell.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit
import SDWebImage
import SkeletonView

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbReleasedDate: UILabel!
    @IBOutlet weak var ivImage: UIImageView!

    func setContent(_ movie: Movie) {
        let dateFormat = "dd MMM yyyy"
        ivImage.isSkeletonable = true
        let releaseDate = movie.releaseDate ?? ""
        let posterPath = movie.posterPath ?? ""
        
        lbTitle.text = movie.title
        lbReleasedDate.text = DateFormatHelper(date: releaseDate).getDate(format: dateFormat)
        if let imageURL = URL(string: Network.Host.moviedbImage(type: .preview, pathName: posterPath).value) {
            ivImage.sd_setImage(with: imageURL)
        }
    }
}
