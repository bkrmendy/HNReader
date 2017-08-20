//
//  HNItem.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 17..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE:   data model of a generic HN item (post or comment), largely corresponds to the fields in the JSON response
//                  Actually designed as an abstract class (I've considered using a protocol but I need the function implementations since most of them are the same between the Post and Comment classes)
//


import Foundation

class HNItem {
    var by: String?
    var score: Int?
    var type: String?
    var descendants: Int?
    
    private var created: DateComponents?
    
    //returns the age of the item calculated from the posting date (x hours/minutes ago)
    var age: String? {
        if let mins = created?.minute, let hrs = created?.hour {
            if mins > 0 {
                if hrs > 0 {
                    return "\(String(describing: hrs)) hours ago"
                }
                else {
                    return "\(String(describing: mins)) minutes ago"
                }
            }
            else {
                return "just now"
            }
        }
        return nil
    }
    
    init() { }
    
    //used instead of init() because of the stupid "init() not called on all branches" issue
    func setup(json data: [String: Any]){
        self.by = data["by"] as? String
        self.score = data["score"] as? Int
        self.type = data["type"] as? String
        let creation_time = data["time"] as! Double
        self.created = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: Date(timeIntervalSince1970: creation_time), to: Date())
        self.descendants = data["descendants"] as? Int
    }
    
}
