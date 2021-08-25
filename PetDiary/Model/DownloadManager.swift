//
//  DownloadManager.swift
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

enum Download: Error {
    case downloadFail
}

class DownloadManager {
    
    static var shared = DownloadManager()
    
    private init(){}
    
    lazy var db = Firestore.firestore()
    
    var vetPlacemark = [VetDataToDB]()
    
    
    func downloadVetPlacemark(completion: @escaping (Result<[VetDataToDB], Error>)->Void){
        
        vetPlacemark = []
        
        db.collection("veterinary").getDocuments { (querySnapshot, error) in
             
            if error == nil {
                for document in querySnapshot!.documents {
                    
                    do {
                        if let downloadVetData = try document.data(as: VetDataToDB.self,decoder: Firestore.Decoder()) {
                            
                            self.vetPlacemark.append(downloadVetData)
                        }
                    }catch {
                        completion(.failure(Download.downloadFail))
                    }
                }
                completion(.success(self.vetPlacemark))
            }
        }
        
    }
    
    
    
    
    
    
}
