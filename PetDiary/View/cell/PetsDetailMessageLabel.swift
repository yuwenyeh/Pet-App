//
//  PetsDetailMessageLabel.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/2.
//

import UIKit

class PetsDetailMessageLabel: UITableViewCell {
    
    @IBOutlet var messageLabel : UILabel! {
        didSet{
            messageLabel.numberOfLines = 0
        }
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
