//
//  HNStoriesTableViewController.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 15..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE:   static "Stories" tabel view controller
//                  Features: segue that controls which story feed should be loaded into the tableview
//                  Needs better design
//
//

import UIKit

class HNStoriesTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stories"
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navcon = segue.destination as? UINavigationController {
            if let storiesViewController = navcon.visibleViewController as? HNTableViewController {
                storiesViewController.category = segue.identifier!
                switch segue.identifier! {
                case "top":
                    storiesViewController.title = "Top Stories"
                case "best":
                    storiesViewController.title = "Best Stories"
                case "new":
                    storiesViewController.title = "New Stories"
                case "ask":
                    storiesViewController.title = "Ask HN"
                case "show":
                    storiesViewController.title = "Show HN"
                case "jobs":
                    storiesViewController.title = "Job Postings"
                default:
                    break
                }
            }
        }
    }
}
