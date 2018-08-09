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
import NVActivityIndicatorView
import CoreData

class SearchViewController: UIViewController {
    
    let categories = ["Food", "Entertainment", "Gyms", "Coffee Shops", "Museums", "Shopping", "Parks"]
    let categoryImages: [UIImage] = [#imageLiteral(resourceName: "food"),#imageLiteral(resourceName: "entertainment"),#imageLiteral(resourceName: "gym"),#imageLiteral(resourceName: "coffee"),#imageLiteral(resourceName: "museum"),#imageLiteral(resourceName: "shopping"),#imageLiteral(resourceName: "tree")]
    
    @IBOutlet weak var backBttn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapsButton: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var generateNewListBttn: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var mapLabel = String()
    var cImage = UIImage()
    var cLabel = String()
    
    var imageUrl = "example.com"
 
    var selectedBusiness: BusinessModel?
    var businessesFetched: [BusinessModel]?
    
    var currentIndex = 0
    var counter = 0
    var previousBusinesses: [BusinessModel] = []
    
    var saved: SavedSearch?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapsButton.layer.cornerRadius = 10
        mapsButton.isEnabled = false
        navBar.title = "\(cLabel)"
        tableView.rowHeight = 110
        generateNewListBttn.showsTouchWhenHighlighted = false
        generateNewListBttn.layer.cornerRadius = 10
        //categoryImage.image = cImage
        //categoryLabel.text = cLabel
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        if businessesFetched != nil {
            print(businessesFetched)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func imageTapped(){
        print("image tapped: \(imageUrl)")
        UIApplication.shared.open(URL(string : imageUrl)!, options: [:], completionHandler: { (status) in
        })
    }
    
    //generate new list button
    @IBAction func generateBttnTapped(_ sender: UIButton) {
        if counter == 7 {

            let alert = UIAlertController(title: "Thats everything in your area", message: "Would you like to view another category?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes, back to list", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }

            let no = UIAlertAction(title: "No, view again", style: .default ) { (action) in
                self.counter = 0
                self.businessesFetched?.append(contentsOf: self.previousBusinesses)
                self.tableView.reloadData()
            }
            alert.addAction(yes)
            alert.addAction(no)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            if let businessesFetched = businessesFetched {
                for i in currentIndex..<(currentIndex + 6) {
                    previousBusinesses.append(businessesFetched[i])
                    self.businessesFetched?.remove(at: i)
                }
            }
            counter += 1
            self.tableView.reloadData()
        }
    }
    
    //back button
    @IBAction func backBttnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToVC1", sender: self)
        print([SavedSearch]())
        
    }

    //show in maps button
    @IBAction func mapsButtonTapped(_ sender: UIButton) {
        
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, latitude, longitude)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
     
        saveToCoreData()
        
        mapItem.name = mapLabel
        mapItem.openInMaps(launchOptions: options)
 
    }
    
    //core data function
    func saveToCoreData(){
        let saved = CoreDataHelper.newBusiness()
        saved.name = selectedBusiness!.name
        saved.address = selectedBusiness!.address
        saved.price = selectedBusiness!.price
        saved.reviews = Int32(selectedBusiness!.reviews)
        saved.categories = selectedBusiness!.categories
        saved.setTerm = cLabel
        saved.latitude = selectedBusiness!.latitude
        saved.longitude = selectedBusiness!.longitude
        saved.city = selectedBusiness!.city
        saved.state = selectedBusiness!.state
        saved.date = Date()
        CoreDataHelper.saveBusiness()
        print(saved)
    }
    
    //table animation
    func animateTable() {
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
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
    
    func configure(cell: BusinessTableViewCell, atIndexPath indexPath: IndexPath) {
        let businesses = businessesFetched!
        guard let business = businessesFetched?[indexPath.row] else {return}
        
        //distance meters to miles
        //let d = business.distance * (0.000621371)
       // let b = (d*100).rounded()/100

        
        cell.name.text = business.name
        cell.address.text = business.address
        cell.price.text = business.price
        cell.reviews.text = "\(business.reviews) Reviews"
        //cell.distance.text = "\(b) mi"
        cell.businessCategories.text = business.categories
        
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        
        cell.yelpImage.isUserInteractionEnabled = true
        cell.yelpImage.addGestureRecognizer(imageTapped)
        
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
}

extension SearchViewController: BusinessTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mapsButton.isEnabled = true
        guard let business = businessesFetched?[indexPath.row] else {return}
        let currentCell = tableView.cellForRow(at: indexPath) as! BusinessTableViewCell
        self.selectedBusiness = businessesFetched?[indexPath.row]
        //print("selected business: \(String(describing: selectedBusiness))")
        latitude = business.latitude
        longitude = business.longitude
        mapLabel = business.name
        imageUrl = business.url
      
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displaySearch") as! BusinessTableViewCell
        cell.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
        tableView.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businessesFetched {
            return 7
        }
        return 0
    }
}

