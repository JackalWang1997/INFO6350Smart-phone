//
//  Services.swift
//  homework6
//
//  Created by leii on 2021/3/15.
//

import UIKit

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
            
            let jsonArray: [JSON] = JSON(response.data).arrayValue
            seal.fulfill(jsonArray)
        }
        
    }
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
    

