//
//  HNAPI.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

struct HNAPI {
    static var URLs: Dictionary<String, URL> = {
        let StoryURLStrings = [
            "top": "https://hacker-news.firebaseio.com/v0/topstories.json",
            "new": "https://hacker-news.firebaseio.com/v0/newstories.json",
            "show": "https://hacker-news.firebaseio.com/v0/showstories.json",
            "best": "https://hacker-news.firebaseio.com/v0/beststories.json",
            "job": "https://hacker-news.firebaseio.com/v0/jobstories.json",
            "ask": "https://hacker-news.firebaseio.com/v0/askstories.json",
            ]
        var urls = Dictionary<String, URL>()
        for (key, value) in StoryURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
    
    static func postURL(post id: String) -> URL {
        return URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
    }
}
