//
//  Services.swift
//  WorldWeather
//
//  Created by Ashish Ashish on 10/03/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit


func getAFResponseJSONArray(_ url : String ) -> Promise<[JSON]>{
    
    return Promise< [JSON] > { seal ->Void in
        
        AF.request(url).responseJSON { response in
            
            // If there was an error we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            // get the JSON array and fulfill the promise
            
            let jsonArray: [JSON] = JSON(response.data).arrayValue
            seal.fulfill(jsonArray)
        }
        
    }
}
func convertToJsonData(dict:Any) -> String {
    if (dict is NSDictionary) == false &&  (dict is NSArray) == false{
        return "{\"error\":\"json格式错误\"}"
    }
    //var dict = ["name":"wujilei ","age":"29"]
    var jsonData = Data()
    do{
        try  jsonData = JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
    }catch{
        print(error)
        return "{\"error\":\"json格式错误\"}"
    }
    var jsonString =  String(data: jsonData, encoding: String.Encoding.utf8) ?? "{\"error\":\"json格式错误\"}"
    jsonString = jsonString.replacingOccurrences(of: " ", with: "", options: String.CompareOptions.literal, range: jsonString.startIndex..<jsonString.endIndex)
    jsonString = jsonString.replacingOccurrences(of: "\n", with: "", options: String.CompareOptions.literal, range: jsonString.startIndex..<jsonString.endIndex)
    return jsonString
}

func getAFResponseJSON(_ url : String) -> Promise<JSON>{
    
    return Promise<JSON> { seal -> Void in
        
        AF.request(url).responseJSON { response in
            // If there was an error we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
                print("error=\(response.error!)")
            }
            
            // get the JSON array and fulfill the promise
            let json: JSON = JSON(response.data)
            seal.fulfill(json)
        }
    }
    
}
    
