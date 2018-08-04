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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mapsButton: UIButton!
    @IBOutlet weak var generateBttn: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var generateNewListBttn: UIButton!
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var mapLabel = String()
    var cImage = UIImage()
    var cLabel = String()
    
    var businessesFetched: [BusinessModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNewListBttn.layer.cornerRadius = 10
        categoryImage.image = cImage
        categoryLabel.text = cLabel
        mapsButton.layer.cornerRadius = 10
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        if let businessesFetched = businessesFetched {
            print(businessesFetched)
        }
    }
    
    @IBAction func generateBttnTapped(_ sender: UIButton) {
        self.tableView.reloadData()
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
         performSegue(withIdentifier: "unwindToVC1", sender: self)
    }
    
    @IBAction func mapsButtonTapped(_ sender: UIButton) {
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, latitude, longitude)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = mapLabel
        mapItem.openInMaps(launchOptions: options)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businessesFetched {
            return 7
        }
        return 0
    }
    
    func configure(cell: BusinessTableViewCell, atIndexPath indexPath: IndexPath) {
        let businesses = businessesFetched!
        let seven = Int(arc4random_uniform(UInt32(businesses.count)))
      
        guard let business = businessesFetched?[seven] else {return}
     
        cell.name.text = business.name
        cell.address.text = business.address
        cell.price.text = business.price
        cell.reviews.text = "\(business.reviews) Reviews"
        
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
        cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let business = businessesFetched?[indexPath.row] else {return}
        let currentCell = tableView.cellForRow(at: indexPath) as! BusinessTableViewCell
        latitude = business.latitude
        longitude = business.longitude
        mapLabel = business.name
        //print("*+*lat: \(latitude)*+*long: \(longitude)*+*")
    }
    
}

extension SearchViewController: BusinessTableViewCellDelegate {
    
}

