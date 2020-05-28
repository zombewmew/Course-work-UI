//
//  FeedTableViewController.swift
//  Course2FinalTask
//
//  Created by christina on 22.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedTableViewController: UITableViewController {
    
    let usersData = DataProviders.shared.usersDataProvider.currentUser()
    var postsData = DataProviders.shared.postsDataProvider.feed()
    var likesListTitle: String?
    var postId: Post.Identifier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed"
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
    }

    // MARK: - Segue to User List
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? UsersListViewController {
            if let textToPass = likesListTitle {
                destination.usersType = textToPass
                destination.postId = postId
            }
         }
     }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        
        cell.nicknameLabel.text = postsData[indexPath.row].authorUsername
        cell.postDate.text = formateTime(date: postsData[indexPath.row].createdTime)
        cell.userPhoto.image = postsData[indexPath.row].authorAvatar
        cell.postImage.image = postsData[indexPath.row].image
        cell.likesCount.text = String(postsData[indexPath.row].likedByCount)
        cell.postDescription.text = postsData[indexPath.row].description
        if postsData[indexPath.row].currentUserLikesThisPost {
            cell.likeButton.tintColor = UIColor.systemBlue
        }
        
        likesListTitle = cell.likeButton.titleLabel?.text ?? "Likes:"
        
        cell.goToLikesCallback = {
            self.postId = self.postsData[indexPath.row].id
            self.performSegue(withIdentifier: "toLikesList", sender: nil)
        }
        
        //cell.didDoubleTap()
        
        cell.onClickCallback = {
            if self.postsData[indexPath.row].currentUserLikesThisPost {
                print(DataProviders.shared.postsDataProvider.unlikePost(with: self.postsData[indexPath.row].id))
                //DataProviders.shared.usersDataProvider.
                self.postsData[indexPath.row].currentUserLikesThisPost = false
                cell.likeButton.tintColor = UIColor.lightGray
            } else {
                print(DataProviders.shared.postsDataProvider.likePost(with: self.postsData[indexPath.row].id))
                self.postsData[indexPath.row].currentUserLikesThisPost = true
                cell.likeButton.tintColor = UIColor.systemBlue
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Date Formatter
    
    func formateTime(date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }

}
