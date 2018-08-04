//
//  BusinessTableView.swift
//  NewInTown
//
//  Created by Eric Friedman on 7/27/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import UIKit

protocol BusinessTableViewCellDelegate: class {
    
}

class BusinessTableViewCell: UITableViewCell {
    
    weak var delegate: BusinessTableViewCellDelegate?
    //create function to download image from url
    
    @IBOutlet weak var businessImage: UIImageView!
    
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var businessCategories: UILabel!
    @IBOutlet weak var starRating: UIImageView!
    @IBOutlet weak var yelpImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
