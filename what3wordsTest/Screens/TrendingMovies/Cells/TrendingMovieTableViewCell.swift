//
//  TrendingMovieTableViewCell.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import UIKit
import SDWebImage

class TrendingMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieThumb: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieThumb.layer.cornerRadius = 10.0
        movieThumb.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func configCell(movie: Movie) {
        movieName.text = movie.originalTitle
        movieThumb.sd_setImage(with: URL(string: movie.thumb))
        movieYear.text = movie.releaseDate
        movieRating.text = "\(movie.voteAverage ?? 0)"
    }
}
