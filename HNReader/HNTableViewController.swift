//
//  HNTableViewController.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 13..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import UIKit

class HNTableViewController: UITableViewController {

    var HNposts = HNStories.getTop()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight 
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openLink" {
            if let webViewController = segue.destination as? WebViewController {
                let path = self.tableView.indexPathForSelectedRow
                let urlString = HNposts[(path?.row)!].url
                webViewController.url = urlString
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HNposts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HNCell", for: indexPath)
        let post = HNposts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.url
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            HNposts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)            
        }
    }
}
