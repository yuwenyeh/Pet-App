//
//  HomeCell.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/7.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var DetailLabel : UILabel!
    @IBOutlet var imageCell: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

   
    }

}
