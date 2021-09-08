//
//  HomesCell.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/8.
//

import UIKit

class HomesCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var HomeImage: UIImageView!
    {
        didSet{
            HomeImage.layer.masksToBounds = true
            HomeImage.layer.borderColor = #colorLiteral(red: 0.8941428065, green: 0.00786671415, blue: 0.3137122989, alpha: 1)
            HomeImage.layer.borderWidth = 1
            HomeImage.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var birLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    @IBOutlet weak var enterBtn: UIButton!
    {
        didSet{
            enterBtn.layer.masksToBounds = true
            enterBtn.layer.borderColor = #colorLiteral(red: 0.8941428065, green: 0.00786671415, blue: 0.3137122989, alpha: 1)
            enterBtn.layer.borderWidth = 1
            enterBtn.layer.cornerRadius = 40
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func hideSpearator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
    }
    
    
    
}
