//
//  MyPetDetailCell.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/24.
//

import UIKit

class MyPetDetailCell: UITableViewCell {


    @IBOutlet weak var homePetImage: UIImageView!
    
    @IBOutlet weak var homePetName: UILabel!
    
    @IBOutlet weak var homePetMessageLabel: UILabel!
    
    
    func configureCell(homePetImage:UIImage,homePetName:String,homePetMessageLabel:String) {
        self.homePetImage.image = homePetImage
        self.homePetName.text = homePetName
        self.homePetMessageLabel.text = homePetMessageLabel
  
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
