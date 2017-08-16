//
//  HNStoriesTableViewController.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 15..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import UIKit

class HNStoriesTableViewController: UITableViewController {
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let storiesViewController = segue.destination as? HNTableViewController {
            switch segue.identifier! {
            case "top":
                storiesViewController.HNposts = HNStories.getTop()
                storiesViewController.title = "Top Stories"
            case "best":
                storiesViewController.HNposts = HNStories.getBest()
                storiesViewController.title = "Best Stories"
            case "new":
                storiesViewController.HNposts = HNStories.getNew()
                storiesViewController.title = "New Stories"
            case "ask":
                storiesViewController.HNposts = HNStories.getAsk()
                storiesViewController.title = "Ask HN"
            case "show":
                storiesViewController.HNposts = HNStories.getShow()
                storiesViewController.title = "Show HN"
            case "jobs":
                storiesViewController.HNposts = HNStories.getJob()
                storiesViewController.title = "Job Postings"
            default:
                break
            }
        }
    }
}
