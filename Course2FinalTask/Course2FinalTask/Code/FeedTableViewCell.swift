//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by christina on 22.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLink: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    //let postsData = DataProviders.shared.postsDataProvider.likePost(with: <#T##Post.Identifier#>)
    var onClickCallback: (() -> Void)?
    var goToLikesCallback: (() -> Void)?
    
    
    @IBAction func showLikesList(_ sender: Any) {
        goToLikesCallback?()
    }
    
    @IBAction func clickLike(_ sender: Any) {
        onClickCallback?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
