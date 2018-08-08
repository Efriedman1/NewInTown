//
//  RecentModel.swift
//  NewInTown
//
//  Created by Eric Friedman on 8/6/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import SwiftyJSON


struct RecentModel: Codable {
    
    var name: String
    var address: String
    var reviews: Int
    var price: String
    var rating: Double
    var categories: String
    
    init(name: String, address: String, reviews: Int, price: String, rating: Double, categories: String) {
        self.name = name
        self.address = address
        self.reviews = reviews
        self.price = price
        self.rating = rating
        self.categories = categories
        
    }
}
