//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by christina on 22.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLink: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    @IBAction func clickLike(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
