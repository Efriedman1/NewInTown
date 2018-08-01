//
//  SearchViewController.swift
//  NewInTown
//
//  Created by Eric Friedman on 7/25/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var businessesFetched: [BusinessModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
        
        if let businessesFetched = businessesFetched {
            print(businessesFetched)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businessesFetched {
            return businesses.count
        }
        return 0
    }
    
    func configure(cell: BusinessTableViewCell, atIndexPath indexPath: IndexPath) {
        guard let business = businessesFetched?[indexPath.row] else {return}
        
        cell.name.text = business.name
        cell.address.text = business.address
        cell.price.text = business.price
        
        cell.distance.text = business.distance
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displaySearch") as! BusinessTableViewCell
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
}

extension SearchViewController: BusinessTableViewCellDelegate {
    
}

