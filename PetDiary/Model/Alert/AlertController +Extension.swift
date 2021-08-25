//
//  AlertController +Extension.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func getCurrentVC() ->UIViewController?{
        var result:UIViewController?
        var window = UIApplication.shared.windows.filter{ $0.isKeyWindow}.first
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for tmpWin in windows{
                if tmpWin.windowLevel == UIWindow.Level.normal{
                    window = tmpWin
                    break
                }
            }
        }
        let fromView = window?.subviews[0]
        if let nextRespnder = fromView?.next{
            if nextRespnder.isKind(of:UIViewController.self){
                result = nextRespnder as? UIViewController
            }else{
                result = window?.rootViewController
            }
        }
        return result
    }
}



extension UIAlertController{
    class func showAlertController(title:String,msg:String,style:UIAlertController.Style,actions:[UIAlertAction]){
        let VC = UIViewController.getCurrentVC()
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: style)
        for action in actions{
            alertController.addAction(action)
        }
        VC?.present(alertController, animated: true, completion: nil)
        
    }
}


extension UIAlertAction{
    class func addAction(title:String,style:UIAlertAction.Style,handler:((UIAlertAction) -> Void)?) -> UIAlertAction{
        let alertAction = UIAlertAction(title: title, style: style, handler: handler);
        return alertAction
    }
    
    
    
    //輸入文字框
    class func Alert(target:UIViewController,title:String,message:String){
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action) in
            print(alertController.textFields![0].text!)
        }
        alertController.addAction(okAction)
        target.present(alertController, animated: true, completion: nil)
    }
}

