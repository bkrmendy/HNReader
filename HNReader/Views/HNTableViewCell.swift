//
//  HNTableViewCell.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 13..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import UIKit

class HNTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBAction func viewComments(_ sender: UIButton) {
        
    }
    
    func setup(post data: HNPost) {
        self.titleLabel.text = data.title
        self.posterLabel.text = "by: \(String(describing: data.by!))"
        self.ageLabel.text = data.age!
        self.scoreLabel.text = "score: \(String(describing: data.score!))"
    }
}
