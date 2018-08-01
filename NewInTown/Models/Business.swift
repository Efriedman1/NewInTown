//
//  Business.swift
//  NewInTown
//
//  Created by Eric Friedman on 7/25/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BusinessModel {
    var name: String
    var address: String
    var rating: Double
    var distance: String
    var price: String
    var isClosed: Bool
    var imageUrl: String
    //var sortBy: String
    
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.address = json["location"]["address1"].stringValue
        self.rating = json["rating"].doubleValue
        self.distance = json["distance"].stringValue
        self.price = json["price"].stringValue
        self.isClosed = json["is_closed"].boolValue
        self.imageUrl = json["image_url"].stringValue
        //self.sortBy = json["Root"]["businesses"][0]["name"].stringValue
    
    }
}
