//
//  UINavigationContyroller+Ext.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/2.
//

import Foundation
import UIKit

extension UINavigationController {
    
    
    open override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
}
