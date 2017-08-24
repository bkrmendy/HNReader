//
//  HNTableViewController.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 13..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE:   the custom table view controller implementation
//                  Features:   delete action
//                              segue to webview
//                              no sections
//

import UIKit

class HNTableViewController: UITableViewController {
    
    var HNposts: [HNPost]?
    var category: String = "top"
    
    override func viewDidLoad() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let posts = HNAPI.getPage(category: (self?.category)!)
            DispatchQueue.main.async {
                self?.HNposts = posts!
                self?.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        tableView.estimatedRowHeight = tableView.rowHeight 
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "openLink":
            if let navcon = segue.destination as? UINavigationController {
                if let webViewController = navcon.visibleViewController as? WebViewController {
                    let path = self.tableView.indexPathForSelectedRow
                    let urlString = HNposts?[(path?.row)!].url
                    webViewController.url = urlString
                }
            }
        case "openComments":
            if let navcon = segue.destination as? UINavigationController {
                if let commentsTable = navcon.visibleViewController as? CommentsTableViewController {
                    let index = sender as! Int
                    let post = HNposts?[index]
                    commentsTable.comments = HNComment.loadCommentChildren(item: (post?.childrenIDs)!)
                }
            }
        default:
            break
        }
    }
    
    //no sections (yet)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HNposts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HNCell", for: indexPath) as? HNTableViewCell
        if let post = HNposts?[indexPath.row] {
            cell?.setup(post: post)            
        }
        return cell!
    }
    
    //allows delete operation
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //defines delete operation
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            HNposts?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)            
        }
    }
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let comments = UITableViewRowAction(style: .default, title: "Comments") { [weak self] action, index in
            self?.performSegue(withIdentifier: "openComments", sender: indexPath.row)
        }
        comments.backgroundColor = .blue
        comments.isAccessibilityElement = true
        comments.accessibilityLabel = "Comments"
        comments.accessibilityLabel = "Opens post comments"
        
        let save = UITableViewRowAction(style: .default, title: "Save") { action, index in
            print("save, \(indexPath.row)")
        }
        save.backgroundColor = .orange
        save.isAccessibilityElement = true
        save.accessibilityLabel = "Save"
        save.accessibilityHint = "Save post for later viewing"
        
        return [comments, save]
    }
}
