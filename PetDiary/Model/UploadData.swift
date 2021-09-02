//
//  UploadData.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/25.
//

import Foundation


struct PetData: Codable{
    
    var PetID:String //uuid
    var Petnames:String?//姓名
    var PetsImage:String?//圖片
    var PetDay:String?//生日
    var PetType:String?//寵物種類
    var Petmessage:String?//訊息
    
//    var toDict: [String : Any]{
//        return [
//            "PetID": PetID
//        ]
//    }
    
//    init(PetID:String){
//        self.PetID = UUID().uuidString
//    }
    
    enum CoodingKeys: String, CodingKey {
        
        case PetID = "Pet ID"
        case Petnames = "Pet name"
        case PetsImage = "Pet image"
        case PetDay = "Pet Day"
        case PetType = "Pet Type"
        case Petmessage = "Pet message"
        
    }
    
    var toDict :[String : Any] {
        return [
            "Pet ID" : PetID,
            "Pet name": Petnames as Any,
            "Pet image": PetsImage as Any,
            "Pet Day": PetDay as Any,
            "Pet Type": PetType as Any,
            "Pet message": Petmessage as Any
        ]
    }
}









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
    let vetLongitude: Double
    
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
