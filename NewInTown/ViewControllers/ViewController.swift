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

    let categories = ["Food", "Entertainment", "Gyms", "Coffee Shops", "Museums", "Sports"]
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var table: UITableView!
    
    var businessesFetched = [BusinessModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendBusinessRequest() { businesses in
            if let businesses = businesses {
                self.businessesFetched = businesses
            } else {
                // todo
            }
        }
        
        table?.allowsMultipleSelection = true
        table.dataSource = self
        table.delegate = self
        table.reloadData()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.table.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        
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
        cell.selectionStyle = UITableViewCellSelectionStyle.blue
        return cell
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getBiz(sender : UIButton) {
        self.performSegue(withIdentifier: "displaySearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        
        case "displaySearch":
            let businesses = businessesFetched
            let destination = segue.destination as! SearchViewController
            destination.businessesFetched = businesses
        
        default:
            print("unexpected segue identifier")
            
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print(location)
    }
}

