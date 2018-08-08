//
//  RecentSearches.swift
//  NewInTown
//
//  Created by Eric Friedman on 8/4/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import UIKit


class RecentSearchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var saved = [SavedSearch](){
        didSet {
            table.reloadData()
        }
    }
    
   
    
    //cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var backBttn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saved = CoreDataHelper.retrieveBusinesses()
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
        
        DispatchQueue.main.async {
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  animateTable()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func backBttnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToVC1", sender: self)
    }
    
//    func animateTable() {
//        //table.reloadData()
//        let cells = table.visibleCells
//
//        let tableViewHeight = table.bounds.size.height
//
//        for cell in cells {
//            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
//        }
//
//        var delayCounter = 0
//        for cell in cells {
//            UIView.animate(withDuration: 1.5, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                cell.transform = CGAffineTransform.identity
//            }, completion: nil)
//            delayCounter += 1
//        }
//    }
    
    func configure(cell: BusinessTableViewCell, atIndexPath indexPath: IndexPath) {
        if let data = UserDefaults.standard.object(forKey:"saved") as? Data {
            if let p = try? PropertyListDecoder().decode(RecentModel.self, from: data) {
                cell.name.text = p.name
                
            }
        }
//        let business = self.businessesFetched[indexPath.row]
//
//        var d = business.distance * (0.000621371)
//        var b = (d*100).rounded()/100
//        cell.name.text = business.name
        
//        cell.address.text = business.address
//        cell.price.text = business.price
//        cell.reviews.text = "\(business.reviews) Reviews"
//        cell.distance.text = "\(b) mi"
//        cell.businessCategories.text = business.categories
        
        //set star rating
//        if p.rating < 1 {
//            cell.starRating.image = UIImage(named: "small_0")
//        } else if p.rating >= 1.0 && business.rating < 1.5 {
//            cell.starRating.image = UIImage(named: "small_1")
//        } else if business.rating >= 1.5 && business.rating < 2.0 {
//            cell.starRating.image = UIImage(named: "small_1_half")
//        } else if business.rating >= 2.0 && business.rating < 2.5 {
//            cell.starRating.image = UIImage(named: "small_2")
//        } else if business.rating >= 2.5 && business.rating < 3.0 {
//            cell.starRating.image = UIImage(named: "small_2_half")
//        } else if business.rating >= 3.0 && business.rating < 3.5 {
//            cell.starRating.image = UIImage(named: "small_3")
//        } else if business.rating >= 3.5 && business.rating < 4.0 {
//            cell.starRating.image = UIImage(named: "small_3_half")
//        } else if business.rating >= 4.0 && business.rating < 4.5 {
//            cell.starRating.image = UIImage(named: "small_4")
//        } else if business.rating >= 4.5 && business.rating < 5.0 {
//            cell.starRating.image = UIImage(named: "small_4_half")
//        } else if business.rating == 5.0 {
//            cell.starRating.image = UIImage(named: "small_5")
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "savedSearch", for: indexPath) as! BusinessTableViewCell
        let save = saved[indexPath.row]
        
        cell.name.text = save.name
        cell.address.text = save.address
        cell.price.text = save.price
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! BusinessTableViewCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saved.count 
    }
    
}
