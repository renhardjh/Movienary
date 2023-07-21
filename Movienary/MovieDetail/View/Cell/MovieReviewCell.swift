//
//  MovieReviewCell.swift
//  Movienary
//
//  Created by RenhardJH on 21/07/23.
//

import UIKit
import Cosmos

class MovieReviewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbAuthorName: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var ratingView: CosmosView!

    func setContent( _ review: MovieReview) {
        if let avatarPath = review.authorDetails?.avatarPath,
           let imageURL = URL(string: Network.Host.moviedbImage(type: .original, pathName: avatarPath).value) {
            ivAvatar.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "ic_no_image"))
        }

        lbAuthorName.text = review.author
        lbContent.text = review.content
        ratingView.rating = Double(review.authorDetails?.rating ?? 0) / 2
        if let updatedAt = review.updatedAt {
            lbDate.text = DateFormatHelper(date: updatedAt).getDate(format: "dd MMM yyyy HH:mm")
        }

        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.white.cgColor
    }

    func setExpanded() {
        let isExpanded = lbContent.numberOfLines == 0
        lbContent.numberOfLines = isExpanded ? 3 : 0
        lbContent.sizeToFit()
    }
}
