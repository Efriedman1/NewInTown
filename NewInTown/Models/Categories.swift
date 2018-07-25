//
//  Categories.swift
//  NewInTown
//
//  Created by Eric Friedman on 7/25/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CategoriesModel {
    var title: String
    var alias: String
    var parent: String
    
    init(json: JSON) {
        self.title = json["Root"]["categories"][0]["title"].stringValue
        self.alias = json["Root"]["categories"][0]["alias"].stringValue
        self.parent = json["Root"]["categories"][0]["parent_aliases"][0].stringValue
    }
}
