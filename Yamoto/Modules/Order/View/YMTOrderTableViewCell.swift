//
//  YMTOrderTableViewCell.swift
//  Yamoto
//
//  Created by pactera on 2020/10/29.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
