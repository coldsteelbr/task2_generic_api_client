//
//  FavoriteCell.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 30.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

import UIKit

class FavoriteCell: UITableViewCell {
    @IBOutlet var employerLogo: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    /// controlling activity spinner and logo-image
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            employerLogo.image = imageToDisplay
        } else {
            spinner.startAnimating()
            employerLogo.image = nil
        }
    }
    
    /// on cell creation
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    /// on cell reusing
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
}
