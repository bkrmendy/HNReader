//
//  HNStories.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

struct HNStories {
    static func getPage(category id: String) -> [HNPost]{
        var hnposts: [HNPost] = []
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
        return hnposts
    }
}
