//
//  HNTableViewCell.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 13..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE:   the custom cell implementation
//                  does nothing really
//
//


import UIKit

class HNTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var children: [Int]?
    
    //used instead of init() (skill level too low as of now)
    func setup(post data: HNPost) {
        self.titleLabel.text = data.title
        self.posterLabel.text = "by: \(String(describing: data.by!))"
        self.ageLabel.text = data.age!
        self.scoreLabel.text = "score: \(String(describing: data.score!))"
        self.children = data.childrenIDs
    }
}
