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
import MapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mapsButton: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
         performSegue(withIdentifier: "unwindToVC1", sender: self)
    }
    
    @IBAction func mapsButtonTapped(_ sender: UIButton) {
        
//        let latitude: CLLocationDegrees = 39.2342
//        let longitude: CLLocationDegrees = -120.234534
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, latitude, longitude)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "placeholder"
        mapItem.openInMaps(launchOptions: options)
    }
    
    var businessesFetched: [BusinessModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapsButton.layer.cornerRadius = 10
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        if let businessesFetched = businessesFetched {
            print(businessesFetched)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businessesFetched {
            return 7
        }
        return 0
    }
    
    func configure(cell: BusinessTableViewCell, atIndexPath indexPath: IndexPath) {
        guard let business = businessesFetched?[indexPath.row] else {return}
        
        cell.name.text = business.name
        cell.address.text = business.address
        cell.price.text = business.price
        cell.reviews.text = "\(business.reviews) Reviews"
        
        //currentCell.textLabel?.text
        latitude = business.latitude
        longitude = business.longitude
        
        //cell.distance.text = business.distance
        
        
        //set star rating
                if business.rating < 1 {
                    cell.starRating.image = UIImage(named: "small_0")
                } else if business.rating >= 1.0 && business.rating < 1.5 {
                    cell.starRating.image = UIImage(named: "small_1")
                } else if business.rating >= 1.5 && business.rating < 2.0 {
                    cell.starRating.image = UIImage(named: "small_1_half")
                } else if business.rating >= 2.0 && business.rating < 2.5 {
                    cell.starRating.image = UIImage(named: "small_2")
                } else if business.rating >= 2.5 && business.rating < 3.0 {
                    cell.starRating.image = UIImage(named: "small_2_half")
                } else if business.rating >= 3.0 && business.rating < 3.5 {
                    cell.starRating.image = UIImage(named: "small_3")
                } else if business.rating >= 3.5 && business.rating < 4.0 {
                    cell.starRating.image = UIImage(named: "small_3_half")
                } else if business.rating >= 4.0 && business.rating < 4.5 {
                    cell.starRating.image = UIImage(named: "small_4")
                } else if business.rating >= 4.5 && business.rating < 5.0 {
                    cell.starRating.image = UIImage(named: "small_4_half")
                } else if business.rating == 5.0 {
                    cell.starRating.image = UIImage(named: "small_5")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displaySearch") as! BusinessTableViewCell
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! BusinessTableViewCell
         //currentCell.textLabel?.text
        //latitude = currentCell
    }
    
}

extension SearchViewController: BusinessTableViewCellDelegate {
    
}

