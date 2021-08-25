//
//  TitleLabelCell.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/22.
//

import UIKit

class TitleLabelCell: UITableViewCell {

    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
