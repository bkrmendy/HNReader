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
import UIKit

class HNComment: HNItem, CustomStringConvertible {
    
    var description: String {
        if let _ = deleted {
            return "deleted HNComment with id \(String(describing: id!))"
        }
        return "HNComment \(String(describing: by)) \(String(describing: age)) \(text) \(String(describing: childrenIDs))"
    }
    
    var text: String?
    var level: Int?
    
    init(item id: Int, level: Int) {
        super.init()
        self.level = level
        if let json = HNAPI.getHNItemJSON(item: id) {
            setup(json: json)
            if let text = json["text"] as? String {
                let string = text.data(using: .utf8)
                let options: [String: Any] = [
                    NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                    NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
                ]
                
                let attributedString = try? NSAttributedString(data: string!, options: options, documentAttributes: nil)
                self.text = attributedString?.string.replacingOccurrences(of: "<p>", with: "\n\n")
            }
        }
    }
    
    static func loadCommentChildren(item ids: [Int]) -> [HNComment] {
        var accumulator = [HNComment]()
        var startingIndent = 0
        for i in ids {
            loadComment(accumulator: &accumulator, item: i, indent: &startingIndent)
        }
        return accumulator
    }
    
    private static func loadComment(accumulator list: inout [HNComment], item id: Int, indent level: inout Int) {
        let thisComment = HNComment(item: id, level: level)
        list.append(thisComment)
        var incIndent = level + 1
        if let kids = thisComment.childrenIDs {
            for k in kids{
                loadComment(accumulator: &list, item: k, indent: &incIndent)
            }
        }
    }
}
