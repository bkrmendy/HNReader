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
import CoreData

class HNTableViewController: UITableViewController {
    
    var HNposts: [HNPost]?
    var category: String = "top"
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    
    private func updateDataBase(saved post: HNPost) {
        container?.performBackgroundTask({ context in
            _ = try? HNSavedItem.findOrCreateItem(matching: post.id!, in: context)
            try? context.save()
        })
        printDBStats()
        let alert = UIAlertController(title: "", message: "Post saved!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func printDBStats() {
        if let context = container?.viewContext {
            if let postCount = try? context.count(for: HNSavedItem.fetchRequest()){
                print("\(postCount) posts")
            }
        }
    }
    
    override func viewDidLoad() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        super.viewDidLoad()
        switch category {
        case "saved":
            if let context = container?.viewContext {
                let request: NSFetchRequest = HNSavedItem.fetchRequest()
                if let posts = try? context.fetch(request)  {
                    HNposts = [HNPost]()
                    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                        for p in posts {
                            let id: Int = Int(p.id!)!
                            self?.HNposts?.append(HNPost(json: id))
                        }
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
            break
        default:
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let posts = HNAPI.getPage(category: (self?.category)!)
                DispatchQueue.main.async {
                    self?.HNposts = posts!
                    self?.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
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
        
        let save = UITableViewRowAction(style: .default, title: "Save") { [weak self] action, index in
            let post = self?.HNposts?[indexPath.row]
            self?.updateDataBase(saved: post!)
        }
        save.backgroundColor = .orange
        save.isAccessibilityElement = true
        save.accessibilityLabel = "Save"
        save.accessibilityHint = "Save post for later viewing"
        
        return [comments, save]
    }
}
