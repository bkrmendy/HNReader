//
//  HNAPI.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
// IN THIS FILE:
//  Everything that has anything to do with getting data from the web.
//  The HN API and the functions that communicate with it are defined here,
//

import Foundation

struct HNAPI {
    
    //HN story URLs
    static var URLs: Dictionary<String, URL> = {
        let StoryURLStrings = [
            "top": "https://hacker-news.firebaseio.com/v0/topstories.json",
            "new": "https://hacker-news.firebaseio.com/v0/newstories.json",
            "show": "https://hacker-news.firebaseio.com/v0/showstories.json",
            "best": "https://hacker-news.firebaseio.com/v0/beststories.json",
            "jobs": "https://hacker-news.firebaseio.com/v0/jobstories.json",
            "ask": "https://hacker-news.firebaseio.com/v0/askstories.json",
            ]
        var urls = Dictionary<String, URL>()
        for (key, value) in StoryURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
    
    //parses the JSON response of a HN post/item with a given ID to a [String: Any]
    static func getHNItemJSON(item id: Int) -> [String: Any]? {
        if let response = itemURL(post: String(id)){
            if let post = try? JSONSerialization.jsonObject(with: response, options: []) {
                if let dict = post as? [String: Any] {
                    return dict
                }
            }
        }
        return nil
    }
    
    //returns the response from a given HN item
    static func itemURL(post id: String) -> Data? {
        return try? Data(contentsOf: URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!)
    }
    
    //gets the list of post items for a given HN story type
    static func getPage(category id: String) -> [HNPost]? {
        var hnposts: [HNPost] = []
        if HNAPI.URLs.keys.contains(id) {
            if let response = try? Data(contentsOf: HNAPI.URLs[id]!) {
                if let posts = try? JSONSerialization.jsonObject(with: response, options: []) {
                    if let ans = posts as? [Int] {
                        let less = ans[0..<50]
                        for l in less {
                            hnposts.append(HNPost(json: l))
                        }
                        return hnposts
                    }
                }
            }
        }
        return nil
    }
}
