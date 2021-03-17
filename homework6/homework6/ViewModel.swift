//
//  ViewModel.swift
//  homework6
//
//  Created by leii on 2021/3/15.
//

import Foundation
import PromiseKit

class ViewModel: NSObject {
    func getModelCommodities(_ url : String) -> Promise<[ModelCommodity]>{
        return Promise<[ModelCommodity]> { seal -> Void in

            getAFResponseJSONArray(url).done { json in
                var modelCommodityList = [ModelCommodity]()
                for i in 0..<json.count{
                    
                    let modelCommodity = ModelCommodity()
                    modelCommodity.name = json[i]["name"].stringValue
                    modelCommodity.price = json[i]["price"].floatValue
                    modelCommodityList.append(modelCommodity)
                }
                seal.fulfill(modelCommodityList)
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
}
