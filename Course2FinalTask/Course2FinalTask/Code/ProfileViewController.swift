//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by christina on 23.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var postsCollection: UICollectionView!
    
    var userData = DataProviders.shared.usersDataProvider.currentUser()
    lazy var postsData = DataProviders.shared.postsDataProvider.findPosts(by: userData.id)
    
    var followButton: String?
    var idUser: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let receivedId = idUser {
            postsData = DataProviders.shared.postsDataProvider.findPosts(by: receivedId as! User.Identifier)
            userData = DataProviders.shared.usersDataProvider.user(with: receivedId as! User.Identifier) ?? DataProviders.shared.usersDataProvider.currentUser()
        }
        
        self.title = userData.username
        navigationController?.title = "Profile"
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.image = userData.avatar!
        profileName.text = userData.fullName
        followersCount.text = String(userData.followedByCount)
        followingCount.text = String(userData.followsCount)
        
        postsCollection.delegate = self
        postsCollection.dataSource = self
        
    }
    
    @IBAction func toUsersList(_ sender: UIButton) {
        followButton = sender.titleLabel?.text
        idUser = userData.id
        performSegue(withIdentifier: "toUsersList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? UsersListViewController {
            if let textToPass = followButton{
                destination.usersType = textToPass
                destination.userId = userData.id
             }
         }
     }
}

// MARK: - CollectionViewController methods

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = postsCollection.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath as IndexPath) as! ProfileCollectionViewCell
        cell.set(with: postsData![indexPath.item].image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        flowLayout.minimumInteritemSpacing = 0.5
        flowLayout.minimumLineSpacing = 1.0
        
        let size = Int((collectionView.bounds.width - 2) / 3)
        
        return CGSize(width: size, height: size)
    }
    
    
}
