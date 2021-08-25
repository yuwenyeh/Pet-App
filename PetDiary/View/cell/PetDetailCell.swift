//
//  PetDetailCell.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/22.
//

import UIKit

class PetDetailCell: UITableViewCell {

    
    @IBOutlet weak var background: UIView!
   
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
 
   
    
    @IBAction func cameraBtn(_ sender: Any) {
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }

}
