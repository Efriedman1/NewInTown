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

func sendCategoryRequest() {
    /**
     Category
     get https://api.yelp.com/v3/categories
     */
    
    // Add Headers
    let headers = [
        "Authorization":"Bearer CTfczk-bwFjYUwc90qlTyhITFvb4ZVic5RIdthiQ2CbUqsFXZ4mVuql3L6RqjGMf1wlVR1c03gtCLPksOVGgv8B8IsmfcGUKApj9LLlXXGIrCTqZLIOlpfQsF8VYW3Yx",
        ]
    
    // Fetch Request
    Alamofire.request("https://api.yelp.com/v3/categories", method: .get, headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            if (response.result.error == nil) {
                debugPrint("HTTP Response Body: \(response.data)")
            }
            else {
                debugPrint("HTTP Request failed: \(response.result.error)")
            }
    }
}

func categories(){
    
}

func sendBusinessRequest() {
    /**
     Business
     get https://api.yelp.com/v3/businesses/search
     */
    
    // Add Headers
    let headers = [
        "Authorization":"Bearer CTfczk-bwFjYUwc90qlTyhITFvb4ZVic5RIdthiQ2CbUqsFXZ4mVuql3L6RqjGMf1wlVR1c03gtCLPksOVGgv8B8IsmfcGUKApj9LLlXXGIrCTqZLIOlpfQsF8VYW3Yx",
        ]
    
    // Add URL parameters
    let urlParams = [
        "term":"food",
        "location":"94102",
        ]
    
    // Fetch Request
    Alamofire.request("https://api.yelp.com/v3/businesses/search", method: .get, parameters: urlParams, headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            if (response.result.error == nil) {
                debugPrint("HTTP Response Body: \(response.data)")
            }
            else {
                debugPrint("HTTP Request failed: \(response.result.error)")
            }
    }
}

func businesses(){
    
}

