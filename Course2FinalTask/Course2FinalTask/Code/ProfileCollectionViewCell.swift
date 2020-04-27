//
//  ProfileCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by christina on 23.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
    
    // MARK: - Public
    
    func set(with photo: UIImage) {
        postImage.image = photo
    }
}
