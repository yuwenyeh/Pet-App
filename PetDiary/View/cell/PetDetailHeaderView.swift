//
//  PetDetailHeaderView.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/2.
//

import UIKit

class PetDetailHeaderView: UIView {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel :UILabel!{
        didSet{
            typeLabel.numberOfLines = 0
            typeLabel.layer.cornerRadius = 5.0
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var HeatImageView: UIImageView! {
        didSet{
            HeatImageView.image = UIImage(named: "cake")?.withRenderingMode(.alwaysTemplate)
            HeatImageView.tintColor = .white
        }
    }

}
