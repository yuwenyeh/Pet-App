//
//  ImageCell.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/22.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
