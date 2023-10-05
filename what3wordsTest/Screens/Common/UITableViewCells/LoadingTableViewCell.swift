//
//  LoadingTableViewCell.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func startLoadingAnimation() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        loadingIndicator.stopAnimating()
    }
}
