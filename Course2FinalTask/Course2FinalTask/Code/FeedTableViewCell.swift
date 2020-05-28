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
    //var doubleTapped: (() -> Void)?
    
    @IBAction func showLikesList(_ sender: Any) {
        goToLikesCallback?()
    }
    
    @IBAction func clickLike(_ sender: Any) {
        onClickCallback?()
    }

    
    @IBOutlet weak var bigLike: UIImageView!
    
    lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        
        tapRecognizer.numberOfTapsRequired = 2
        
        return tapRecognizer
    }()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(doubleTapRecognizer)
        
    }
    
    @objc
    func didDoubleTap() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
           self.bigLike.alpha = 1.0
        }, completion: {_ in
           UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveEaseOut], animations: {
               self.bigLike.alpha = 0
           }, completion: nil)
        })
    }
    
}
