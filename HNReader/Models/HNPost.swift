//
//  HNPost.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

class HNPost: HNItem, CustomStringConvertible {
    var description: String {
        return "HN Post: \(url!) \(title!) \(by!) \(age!) \(score!)"
    }
    
    var url: String?
    var title: String?
    
    init(id: String) {
        super.init()
        if let response = HNAPI.itemURL(post: id){
            if let post = try? JSONSerialization.jsonObject(with: response, options: []) {
                if let dict = post as? [String: Any] {
                    setup(json: dict)
                    self.url = dict["url"] as? String
                    self.title = dict["title"] as? String
                }
            }
        }
    }
}
