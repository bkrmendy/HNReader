//
//  HNPost.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE: data model of a HN post item, inherits from HNItem and only adds the post-specific fields.
//
//

import Foundation

class HNPost: HNItem, CustomStringConvertible {
    var url: String?
    var title: String?
    
    var description: String {
        return "HN Post: \(url!) \(title!) \(by!) \(age!) \(score!)"
    }
    
    init(json id: Int) {
        super.init()
        if let data = HNAPI.getHNItemJSON(item: id) {
            setup(json: data)
            self.url = data["url"] as? String
            self.title = data["title"] as? String
        }
    }
}

