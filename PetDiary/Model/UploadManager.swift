//
//  UploadManager.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import JGProgressHUD


enum Upload: Error {
    
    case uploadFail
}

class UploadManager {

    
    static var shared = UploadManager()
    
    private init(){}
    
    lazy var db = Firestore.firestore()
    
    var view: UIView {
        return AppDelegate.shared.window!.rootViewController!.view
    }
    

func uploadVet(vetName:String, vetPhone:String, vetAddress: String, vetLatitude: Double, vetLongitude:Double,completion:@escaping (Result <String, Error>) -> Void) {
    
    let data = VetDataToDB(vetName: vetName, vetPhone: vetPhone, vetAddress: vetAddress, vetLatitude: vetLatitude, vetLongitude: vetLongitude)
    
    db.collection("veterinary").document().setData(data.toDict) { error in
        
        if error != nil {
            
            completion(.failure(Upload.uploadFail))
        }
        
        completion(.success("Success"))
    }

}
    
   
    func uploadSuccess(text: String) {
        
        let hud = JGProgressHUD(style: .dark)
        
        hud.textLabel.text = text
        
        hud.show(in: view)
        
        hud.dismiss(afterDelay: 3.0)
        
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    }
    
    
    func uploadFail(text: String) {
        
        let hud = JGProgressHUD(style: .dark)
        
        hud.textLabel.text = text
        
        hud.show(in: view)
        
        hud.dismiss(afterDelay: 3.0)
        
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
    }
    
    
    
    
}
