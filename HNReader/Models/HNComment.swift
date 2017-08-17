//
//  HNComment.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 17..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

class HNComment: HNItem, CustomStringConvertible {
    var description: String {
        return "HNComment \(by!) \(age!) \(text!) \(children)"
    }
    
    var text: String?
    var children: [HNComment]?
    
    init(item id: Int) {
        super.init()
        if let json = HNAPI.getHNItemJSON(item: id) {
            setup(json: json)
            self.text = json["text"] as? String
            if let kids = json["kids"] as? [Any] {
                children = [HNComment]()
                for kid in kids {
                    let kidID = kid as? Int
                    children?.append(HNComment(item: kidID!))
                }
            }
        }
    }
}
