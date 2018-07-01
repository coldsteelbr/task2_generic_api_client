//
//  VacancyCell.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class VacancyCell: UITableViewCell {
    //
    //  Cell
    //
    @IBOutlet var employerLogoImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var spinner:UIActivityIndicatorView!
    
    let noLogoImage = UIImage(named: "no-logo")
    
    /// controlling activity spinner and logo-image
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            employerLogoImage.image = imageToDisplay
        } else {
            spinner.startAnimating()
            employerLogoImage.image = nil
        }
    }
    
    /// desables spinner and sets no-logo placeholder
    func updateNoLogo() {
        employerLogoImage.image = noLogoImage
        spinner.stopAnimating()
    }
    
    /// on cell creation
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    // on cell reusing
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
    
}
