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
    
    var categoryImage: UIImageView? = nil
    var categoryLabel: UILabel? = nil
    
    
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
        table.reloadData()
        
        searchButton.layer.cornerRadius = 10
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.table.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        let currentCell = table.cellForRow(at: indexPath) as! UITableViewCell
        categoryLabel?.text = categories[indexPath.row]
        categoryImage?.image = categoryImages[indexPath.row]
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
        cell.selectionStyle = UITableViewCellSelectionStyle.blue
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
            let businesses = businessesFetched
            let destination = segue.destination as! SearchViewController
            destination.businessesFetched = businesses
            destination.categoryImage = categoryImage
            destination.categoryLabel = categoryLabel
        default:
            print("unexpected segue identifier")
            
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
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let myLatitude = location.coordinate.latitude
        let myLongitude = location.coordinate.longitude
        print("Current Latitude: \(myLatitude), Current Longitude: \(myLongitude)")
    }
}

