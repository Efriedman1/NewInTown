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
    var location: String
    var price: String
    var isClosed: Bool
    //var sortBy: String
    var rating: Double
    
    init(json: JSON) {
        self.name = json["Root"]["businesses"][0]["name"].stringValue
        self.location = json["Root"]["businesses"][0]["location"]["address1"].stringValue
        self.price = json["Root"]["businesses"][0]["price"].stringValue
        self.isClosed = json["Root"]["businesses"][0]["is_closed"].boolValue
        //self.sortBy = json["Root"]["businesses"][0]["name"].stringValue
        self.rating = json["Root"]["businesses"][0]["rating"].doubleValue
    }
}
