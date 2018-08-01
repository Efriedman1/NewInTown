//
//  ConfigureJSON.swift
//  NewInTown
//
//  Created by Eric Friedman on 7/25/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire




func sendBusinessRequest(completion: @escaping ([BusinessModel]?) -> Void) {
    /**
     Business
     get https://api.yelp.com/v3/businesses/search
     */
    
    var businesses = [BusinessModel]()
    
    // Add Headers
    let headers = [
        "Authorization":"Bearer CTfczk-bwFjYUwc90qlTyhITFvb4ZVic5RIdthiQ2CbUqsFXZ4mVuql3L6RqjGMf1wlVR1c03gtCLPksOVGgv8B8IsmfcGUKApj9LLlXXGIrCTqZLIOlpfQsF8VYW3Yx",
        ]
    
    // Add URL parameters
    let urlParams = [
        "term":"restaurant",
        "location":"94102"
        ]
    
    // Fetch Request
    Alamofire.request("https://api.yelp.com/v3/businesses/search", method: .get, parameters: urlParams, headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            if (response.result.error == nil) {
                //retrieve data as JSON, check first to make sure there is data being retrieved
                if let value = response.result.value {
                    
                    let jsonBusinessData = JSON(value)
                    let json = jsonBusinessData["businesses"].arrayValue
                    for business in json {
                       businesses.append(BusinessModel.init(json: business))
                    }
                    //print(businesses)
                }
                completion(businesses)
            }
            else {
                debugPrint("HTTP Request failed: \(response.result.error)")
                completion([])
        }
    }
}

