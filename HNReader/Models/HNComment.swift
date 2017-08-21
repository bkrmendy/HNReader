//
//  HNComment.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 17..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE: data model of a HN comment item, inherits from HNItem and only adds the comment-specific fields.
//
//


import Foundation

class HNComment: HNItem, CustomStringConvertible {
    
    var description: String {
        if let _ = deleted {
            return "deleted HNComment with id \(String(describing: id!))"
        }
        return "HNComment \(String(describing: by)) \(String(describing: age)) \(text) \(String(describing: childrenIDs))"
    }
    
    var text: String?
    
    init(item id: Int) {
        super.init()
        if let json = HNAPI.getHNItemJSON(item: id) {
            setup(json: json)
            self.text = json["text"] as? String
        }
    }
    
    static func loadCommentChildren(item ids: [Int]) -> [HNComment] {
        var accumulator = [HNComment]()
        for i in ids {
            loadComment(accumulator: &accumulator, item: i)
        }
        return accumulator
    }
    
    private static func loadComment(accumulator list: inout [HNComment], item id: Int) {
        let thisComment = HNComment(item: id)
        list.append(thisComment)
        if let kids = thisComment.childrenIDs {
            for k in kids{
                loadComment(accumulator: &list, item: k)
            }
        }
    }
}
