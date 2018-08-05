//
//  ViewController.swift
//  NewInTown
//
//  Created by Eric Friedman on 7/25/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let categories = ["Food", "Entertainment", "Gyms", "Coffee Shops", "Museums", "Shopping", "Parks"]
    let categoryImages: [UIImage] = [#imageLiteral(resourceName: "food"),#imageLiteral(resourceName: "entertainment"),#imageLiteral(resourceName: "gym"),#imageLiteral(resourceName: "coffee"),#imageLiteral(resourceName: "museum"),#imageLiteral(resourceName: "shopping"),#imageLiteral(resourceName: "tree")]
    let locationManager = CLLocationManager()
    var setTerm: String?
    var categoryLabel = String()
    var categoryImage = UIImage()
    var currentLocation = CLLocation()
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var recentSearches: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBAction func unwindToVC1(segue: UIStoryboardSegue) { }
    
    var businessesFetched = [BusinessModel]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table?.allowsMultipleSelection = false
        table.dataSource = self
        table.delegate = self
        table.isScrollEnabled = false
        
        searchButton.layer.cornerRadius = 10
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.table.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        self.table.cellForRow(at: indexPath as IndexPath)?.tintColor = UIColor.red
        let currentCell = table.cellForRow(at: indexPath) as! UITableViewCell
        categoryLabel = categories[indexPath.row]
        categoryImage = categoryImages[indexPath.row]
        setTerm = currentCell.textLabel?.text
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.table.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        self.table.rowHeight = 50
        cell.textLabel?.text = categories[indexPath.row]
        cell.imageView?.image = categoryImages[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        table.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "toDisplay":
            var destinationViewController: SearchViewController = segue.destination as! SearchViewController
            let businesses = businessesFetched
            let destination = segue.destination as! SearchViewController
            destination.businessesFetched = businesses
            destinationViewController.cImage = categoryImage
            destinationViewController.cLabel = categoryLabel
        case "recentSearches":
             var destinationViewController: RecentSearchesViewController = segue.destination as! RecentSearchesViewController
        default:
            print("unexpected segue identifier")
            
        }
        
    }
    func animateTable() {
        table.reloadData()
        let cells = table.visibleCells
        
        let tableViewHeight = table.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }

    @IBAction func getBiz(sender : UIButton) {
        sendBusinessRequest(setTerm: setTerm!) { businesses in
            if let businesses = businesses {
                self.businessesFetched = businesses
                DispatchQueue.main.async {
                }
            } else {
                print("error: getBiz button")
            }
            self.performSegue(withIdentifier: "toDisplay", sender: self)
        }
    }
    
    @IBAction func recentSearchesTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "recentSearches", sender: self)
    }
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        currentLocation = location
        print("CurrentLocation: \(currentLocation)")
        let myLatitude = location.coordinate.latitude
        let myLongitude = location.coordinate.longitude
        print("Current Latitude: \(myLatitude), Current Longitude: \(myLongitude)")
    }
}

