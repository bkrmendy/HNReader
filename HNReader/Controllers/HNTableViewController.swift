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

class HNTableViewController: UITableViewController, CellDelegator {
    
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
                    if let IDs = sender as? [Int] {
                        commentsTable.comments = HNComment.loadCommentChildren(item: IDs)
                    }
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
        cell?.delegate = self
        if let post = HNposts?[indexPath.row] {
            cell?.setup(post: post)
            cell?.isAccessibilityElement = true

            cell?.commentsButton.isAccessibilityElement = true
            cell?.commentsButton.accessibilityLabel = "Comments"
            cell?.commentsButton.accessibilityHint = "Open link comments"
            
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
    
    func callSegueFromCell(data object: Any?) {
        self.performSegue(withIdentifier: "openComments", sender: object)
    }
}
