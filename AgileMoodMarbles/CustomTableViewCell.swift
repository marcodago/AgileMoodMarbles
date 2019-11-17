//
//  CustomTableViewCell.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 17/11/2019.
//  Copyright © 2019 Marco D'Agostino. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var marble: UIImageView!
    @IBOutlet weak var feedback: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }

}
