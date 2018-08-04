//
//  RecentSearches.swift
//  NewInTown
//
//  Created by Eric Friedman on 8/4/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import UIKit

class RecentSearchesViewController: UIViewController {
    
    //cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
    
    @IBOutlet weak var backBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBttnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToVC1", sender: self)
    }
    
}
