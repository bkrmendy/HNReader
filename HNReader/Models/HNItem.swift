//
//  HNItem.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 17..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

class HNItem {
    var by: String?
    var score: Int?
    var type: String?
    var descendants: Int?
    
    private var created: DateComponents?
    
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
    
    func setup(json data: [String: Any]){
        self.by = data["by"] as? String
        self.score = data["score"] as? Int
        self.type = data["type"] as? String
        let creation_time = data["time"] as! Double
        self.created = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: Date(timeIntervalSince1970: creation_time), to: Date())
        self.descendants = data["descendants"] as? Int
    }
    
}
