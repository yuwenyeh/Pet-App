//
//  HomCounter.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/11.
//

import Foundation
import UIKit

class HomCounter: NSObject {
    
    
    func homeCounter(str:String){
        NotificationCenter.default.post(name: CHANGE_BTNTITLE, object: str)
    }

    
    
}
