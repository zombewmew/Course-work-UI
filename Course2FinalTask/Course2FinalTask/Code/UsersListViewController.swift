//
//  UsersListViewController.swift
//  Course2FinalTask
//
//  Created by christina on 24.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class UsersListViewController: UITableViewController {
    @IBOutlet var UsersTableView: UITableView!
    
    var usersType: String?
    var userId: Any?
    var followInfo: [User]?
    var postId: Post.Identifier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let receivedText = usersType {
            let title = receivedText.dropLast()
            self.title = String(title)
        }
        
        switch usersType {
        case "Following:":
            followInfo = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: userId as! User.Identifier)
        case "Followers:":
            followInfo = DataProviders.shared.usersDataProvider.usersFollowingUser(with: userId as! User.Identifier)
        case "Likes:":
            for id in DataProviders.shared.postsDataProvider.usersLikedPost(with: postId as! Post.Identifier)! {
                if (followInfo?.append(DataProviders.shared.usersDataProvider.user(with: id)!)) == nil {
                    
                    followInfo = [DataProviders.shared.usersDataProvider.user(with: id)!]
                }
            }
        default:
            print("User's list mistake")
        }
        
        UsersTableView.delegate = self
        UsersTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? ProfileViewController {
            if let idToPass = userId {
                destination.idUser = idToPass
            }
         }
     }

    
    //override func viewDidLayoutSubviews() {
    //    photoTableView.frame = view.frame
    //}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followInfo!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UsersTableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
    
        cell.imageView?.image = followInfo![indexPath.row].avatar
        cell.textLabel?.text = followInfo![indexPath.row].username
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userId = followInfo![indexPath.row].id
        performSegue(withIdentifier: "toUserProfile", sender: nil)
    }
    
}
