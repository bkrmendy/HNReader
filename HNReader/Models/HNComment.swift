//
//  HNComment.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 17..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import Foundation

class HNComment: HNItem {
    var text: String?
    var children: [HNComment]?
    
    init(item json: [String: Any]?) {
        
    }
}
