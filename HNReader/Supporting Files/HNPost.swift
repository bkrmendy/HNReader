//
//  HNPost.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 14..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

class HNPost: CustomStringConvertible {
    var url: String?
    var title: String = ""
    
    public var description: String {
        return "HNPost by \(by): \(title), created \(age) ago, URL: \((url != nil ? url! : "non-url")), score: \(score)\n"
    }
    
    public var detailString: String {
        return "posted by \(by) \(age) ago"
    }
    
    private var score: Int = 0
    private var created: DateComponents = DateComponents()
    private var by: String = ""
    private var age: String {
        if created.minute! > 1 {
            if created.hour! > 1 {
                return "\(String(describing: created.hour!)) hours ago"
            }
            return "\(String(describing: created.minute!)) minutes ago"
        }
        else {
            return "just now"
        }
    }
    
    init(id: String) {
        if let response = try? Data(contentsOf: HNAPI.postURL(post: id)){
            if let post = try? JSONSerialization.jsonObject(with: response, options: []) {
                if let dict = post as? [String: Any] {
                    self.by = dict["by"] as! String
                    self.url = dict["url"] as? String
                    self.title = dict["title"] as! String
                    self.score = dict["score"] as! Int
                    let creation_time = dict["time"] as! Double
                    self.created = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: Date(timeIntervalSince1970: creation_time), to: Date())
                }
            }
        }
    }
}
