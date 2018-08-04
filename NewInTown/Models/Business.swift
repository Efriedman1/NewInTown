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
    var reviews: Int
    var distance: String
    var price: String
    var isClosed: Bool
    var imageUrl: String
    var latitude: Double
    var longitude: Double
    var rating: Double
    
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.address = json["location"]["address1"].stringValue
        self.reviews = json["review_count"].intValue
        self.distance = json["distance"].stringValue
        self.price = json["price"].stringValue
        self.isClosed = json["is_closed"].boolValue
        self.imageUrl = json["image_url"].stringValue
        self.latitude = json["coordinates"]["latitude"].doubleValue
        self.longitude = json["coordinates"]["longitude"].doubleValue
        self.rating = json["rating"].doubleValue
    }
}
