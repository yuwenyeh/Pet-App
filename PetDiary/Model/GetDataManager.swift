//
//  GetDataManager.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/25.
//

import Foundation

class GetDataManager {
    
    func getData(urlString:String,completion:@escaping(Result<[VetData],Error >) -> Void){
        
        var request = URLRequest(url: URL(string: urlString)!)
        
        request.httpMethod = "Get"
        
        URLSession.shared.dataTask(with:request){ (data, response,error) in
            
            guard error == nil else{
                print(error!)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Downcast HTTPURLResponse fail")
                return
            }
            
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300, let data = data else{
                print("Status Failed! \(httpResponse.statusCode)")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode([VetData].self, from: data)
                completion(.success(result))
                
            }catch{
                print(error)
            }
        }.resume()
    }
    
    func getVetPlacemark(addressStr:String,completion: @escaping(Result<VetPlacemarkData,Error>)->Void){
        
        var urlComponent = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")!
        
        //URLQueryItem 用URL查詢部分單位名稱Value
//        let encodurlString = addressStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        urlComponent.queryItems = [
            URLQueryItem(name: "address", value: addressStr),
            URLQueryItem(name: "key", value: "AIzaSyAkuWKHvaRUjTFzv3F7FlkS865vcinsvKw")
        ]
        
        var request = URLRequest(url: urlComponent.url!)
        
        request.httpMethod = "Get"
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            //let content = String(data: data!, encoding: String.Encoding.utf8)
           //print(content as Any)
            
            guard error == nil else {
                print(error!)
                return
        }
            
            guard let httpResponse = response as? HTTPURLResponse else{
                print("Downcast HTTPURLResponse fail")
                return
            }
            
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 ,let data = data else{
                print("Status Failed! \(httpResponse.statusCode)")
                return
            }
            
            do{
                
                let decoder = JSONDecoder()
                
                let result = try decoder.decode(VetPlacemarkData.self, from: data)
                completion(.success(result))
                
            }catch {
                print(error)
            }
        }.resume()
    }
}
