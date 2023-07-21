//
//  MovieDetailCell.swift
//  Movienary
//
//  Created by RenhardJH on 21/07/23.
//

import Foundation
import UIKit
import SDWebImage
import YouTubePlayer

class MovieDetailCell: UITableViewCell {
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbVoteAverage: UILabel!
    @IBOutlet weak var lbVoteCount: UILabel!
    @IBOutlet weak var btnPlayTrailer: UIButton!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!

    weak var delegate: MovieDetailDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        videoPlayer.delegate = self
    }

    func setContent(movie: MovieDetail?, trailer: MovieVideo?) {
        if let posterPath = movie?.backdropPath,
           let imageURL = URL(string: Network.Host.moviedbImage(type: .original, pathName: posterPath).value) {
            ivImage.showShimmeringView()
            ivImage.sd_setImage(with: imageURL) { [weak self] _,_,_,_ in
                self?.ivImage.stopShimmeringView()
            }
        }

        if let posterPath = movie?.posterPath,
           let imageURL = URL(string: Network.Host.moviedbImage(type: .preview, pathName: posterPath).value) {
            ivPoster.showShimmeringView()
            ivPoster.sd_setImage(with: imageURL) { [weak self] _,_,_,_ in
                self?.ivPoster.stopShimmeringView()
            }
        }

        let voteCount = movie?.voteCount ?? 0
        lbVoteCount.text = "(\(voteCount) votes)"
        if let releaseDate = movie?.releaseDate {
            let dateFormat = DateFormatHelper(date: releaseDate).getDate(format: "dd MMM yyyy")
            lbReleaseDate.text = "Release at \(dateFormat)"
        }

        lbTitle.text = movie?.title
        lbOverview.text = movie?.overview
        lbGenres.text = movie?.genres?.compactMap({ $0.name }).joined(separator: ", ")
        lbVoteAverage.text = String(format: "%.1f", movie?.voteAverage ?? 0)

        if let videoID = trailer?.key {
            videoPlayer.loadVideoID(videoID)
        }
    }

    func setExpanded() {
        let isExpanded = lbOverview.numberOfLines == 0
        lbOverview.numberOfLines = isExpanded ? 3 : 0
        lbOverview.sizeToFit()
    }

    @IBAction func didTapPlayTrailer(_ button: UIButton) {
        ivImage.isHidden = true
        button.isHidden = true
        delegate?.onLoadVideoTrailer()
    }
}

extension MovieDetailCell: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
    }
}

protocol MovieDetailDelegate: AnyObject {
    func onLoadVideoTrailer()
}
