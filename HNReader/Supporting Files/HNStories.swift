//
//  HNStories.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

struct HNStories {
    
    private static func getPage(category id: String) -> [HNPost]{
        var hnposts: [HNPost] = []
        DispatchQueue.global(qos: .userInitiated).async {
            if HNAPI.URLs.keys.contains(id) {
                if let response = try? Data(contentsOf: HNAPI.URLs[id]!) {
                    if let posts = try? JSONSerialization.jsonObject(with: response, options: []) {
                        if let ans = posts as? [Any] {
                            let less = ans[0..<10]
                            for l in less {
                                hnposts.append(HNPost(id: "\(l)"))
                            }
                        }
                    }
                }
            }
        }
        return hnposts
    }
    
    static func getTop() -> [HNPost] {
        return getPage(category: "top")
    }
    
    static func getAsk() -> [HNPost] {
        return getPage(category: "ask")
    }
    
    static func getNew() -> [HNPost] {
        return getPage(category: "new")
    }
    
    static func getBest() -> [HNPost] {
        return getPage(category: "best")
    }
    
    static func getShow() -> [HNPost] {
        return getPage(category: "show")
    }
    
    static func getJob() -> [HNPost] {
        return getPage(category: "job")
    }
}
