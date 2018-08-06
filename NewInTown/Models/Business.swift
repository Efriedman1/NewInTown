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
    var distance: Double
    var price: String
    var isClosed: Bool
    var imageUrl: String
    var latitude: Double
    var longitude: Double
    var rating: Double
    var categoriesCount: Int
    var categories: String
    var url: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.address = json["location"]["address1"].stringValue
        self.reviews = json["review_count"].intValue
        self.distance = json["distance"].doubleValue
        self.price = json["price"].stringValue
        self.isClosed = json["is_closed"].boolValue
        self.imageUrl = json["image_url"].stringValue
        self.latitude = json["coordinates"]["latitude"].doubleValue
        self.longitude = json["coordinates"]["longitude"].doubleValue
        self.rating = json["rating"].doubleValue
        self.categories = json["categories"][0]["title"].stringValue
        self.categoriesCount = json["categories"].count
        self.url = json["url"].stringValue
    }
   
}
