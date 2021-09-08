//
//  CardView.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/8.
//

import Foundation
import UIKit


//@IBDesignable
class CardView:UIView {
    
    //@IBInspectable var cornerRadius: CGFloat = 40
    //@IBInspectable var shadowOffset: CGSize = CGSize(width: 1,height: 3)
    //@IBInspectable var shadowOffsetWidth: Int = 0
   // @IBInspectable var shadowOffsetHeight: Int = 3
    //@IBInspectable var shadowColor: UIColor? = #colorLiteral(red: 0.8941428065, green: 0.00786671415, blue: 0.3137122989, alpha: 1)
    //@IBInspectable var shadowOpacity: Float = 0.5

    override func layoutSubviews() {
        
        //layer.cornerRadius = cornerRadius
        layer.cornerRadius = 40
       // let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = true
        layer.borderColor = #colorLiteral(red: 0.8941428065, green: 0.00786671415, blue: 0.3137122989, alpha: 1)
        layer.borderWidth = 1
        //layer.shadowColor = shadowColor?.cgColor
        //layer.shadowOffset = shadowOffset
        //layer.shadowOpacity = shadowOpacity
       // layer.shadowPath = shadowPath.cgPath
        

    }
    
    
    
    
}
