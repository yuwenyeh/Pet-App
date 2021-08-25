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


enum Upload: Error {
    
    case uploadFail
}

class UploadManager {

    
    static var shared = UploadManager()
    
    private init(){}
    
    lazy var db = Firestore.firestore()
    
    

func uploadVet(vetName:String, vetPhone:String, vetAddress: String, vetLatitude: Double, vetLongitude:Double,completion:@escaping (Result <String, Error>) -> Void) {
    
    let data = VetDataToDB(vetName: vetName, vetPhone: vetPhone, vetAddress: vetAddress, vetLatitude: vetLatitude, vetLongitude: vetLongitude)
    
    db.collection("veterinary").document().setData(data.toDict) { error in
        
        if error != nil {
            
            completion(.failure(Upload.uploadFail))
        }
        
        completion(.success("Success"))
    }
    
    
    
}
}
