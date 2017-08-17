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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
