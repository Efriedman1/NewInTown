//
//  RecentTableView.swift
//  NewInTown
//
//  Created by Eric Friedman on 8/8/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import UIKit

protocol RecentTableViewCellDelegate: class {
    
}

class RecentTableViewCell: UITableViewCell {
    weak var delegate: RecentTableViewCellDelegate?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
