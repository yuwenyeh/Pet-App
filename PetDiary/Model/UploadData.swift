//
//  UploadData.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/25.
//

import Foundation


struct VetData:Codable{
    
    let vetName:String
    let vetPhone:String
    let vetAddress:String
    
    enum CodingKeys:String,CodingKey{
        
        case vetName = "機構名稱"
        case vetPhone = "機構電話"
        case vetAddress = "機構地址"
    }

}

//轉換成座標
struct VetDataToDB: Codable {
    
    let vetName: String
    let vetPhone: String
    let vetAddress: String
    let vetLatitude: Double
    var vetLongitude: Double
    
    var toDict: [String: Any] {
        
        return [
        
            "vetName": vetName,
            "vetPhone": vetPhone,
            "vetAddress": vetAddress,
            "vetLatitude": vetLatitude,
            "vetLongitude": vetLongitude
        ]
    }
  
}

struct VetPlacemarkData: Codable {
    let results: [ResultData]
}

struct ResultData: Codable {
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat, lng: Double
}
