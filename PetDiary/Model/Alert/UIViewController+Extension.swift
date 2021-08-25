//
//  UIViewController+Extension.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    func alert(message:String,title:String = ""){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
  
    
    
}
