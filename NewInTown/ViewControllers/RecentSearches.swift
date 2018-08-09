//
//  RecentSearches.swift
//  NewInTown
//
//  Created by Eric Friedman on 8/4/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class RecentSearchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var saved = [SavedSearch](){
        didSet {
            table.reloadData()
        }
    }
    let categories = ["Food", "Entertainment", "Gyms", "Coffee Shops", "Museums", "Shopping", "Parks"]
    let categoryImages: [UIImage] = [#imageLiteral(resourceName: "food"),#imageLiteral(resourceName: "entertainment"),#imageLiteral(resourceName: "gym"),#imageLiteral(resourceName: "coffee"),#imageLiteral(resourceName: "museum"),#imageLiteral(resourceName: "shopping"),#imageLiteral(resourceName: "tree")]
    let date = Date()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var mapLabel = String()
    //cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)

    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var backBttn: UIBarButtonItem!
    
    @IBOutlet weak var mapsBttn: UIButton!
    
    override func viewDidLoad() {
        print(date)
        super.viewDidLoad()
        saved = CoreDataHelper.retrieveBusinesses()
        table.delegate = self
        table.dataSource = self
        mapsBttn.layer.cornerRadius = 10
        //table.transform = CGAffineTransform(scaleX: 1, y: -1)
//        let oldContentHeight: CGFloat = table.contentSize.height
//        let oldOffsetY: CGFloat = table.contentOffset.y
        table.reloadData()
//        let newContentHeight: CGFloat = table.contentSize.height
//        table.contentOffset.y = oldOffsetY + (newContentHeight - oldContentHeight)
//        let lastIndex = NSIndexPath(row: saved.count - 1, section: 0)
//        table.scrollToRow(at: lastIndex as IndexPath, at: UITableViewScrollPosition.bottom, animated: false)
        table.rowHeight = 90
        DispatchQueue.main.async {
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
    
    @IBAction func backBttnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToVC1", sender: self)
    }
    
    
    @IBAction func mapsBttnTapped(_ sender: UIButton) {
        
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, latitude, longitude)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = mapLabel
        mapItem.openInMaps(launchOptions: options)
    }
    
    func configure(cell: RecentTableViewCell, atIndexPath indexPath: IndexPath) {
        let cell = table.dequeueReusableCell(withIdentifier: "savedSearch", for: indexPath) as! RecentTableViewCell
        //cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saved.count
    }
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        let category = self.categories
//        return category
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "savedSearch", for: indexPath) as! RecentTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
       // cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        let save = saved[indexPath.row]
        table.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        latitude = save.latitude
        longitude = save.longitude
        mapLabel = save.name!
        cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        cell.name.text = save.name
        cell.address.text = "\(save.city!), \(save.state!)"
        cell.categories.text = "\(save.categories!)"
        cell.date.text = save.date?.convertToString()
        if save.setTerm! == "Food" {
            cell.categoryImage.image = categoryImages[0]
        } else if save.setTerm! == "Entertainment" {
            cell.categoryImage.image = categoryImages[1]
        } else if save.setTerm! == "Gyms" {
            cell.categoryImage.image = categoryImages[2]
        } else if save.setTerm! == "Coffee Shops" {
            cell.categoryImage.image = categoryImages[3]
        } else if save.setTerm! == "Museums" {
            cell.categoryImage.image = categoryImages[4]
        } else if save.setTerm! == "Shopping" {
            cell.categoryImage.image = categoryImages[5]
        } else if save.setTerm! == "Parks" {
            cell.categoryImage.image = categoryImages[6]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.table.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        self.table.cellForRow(at: indexPath as IndexPath)?.tintColor = UIColor.red
        let currentCell = tableView.cellForRow(at: indexPath) as! RecentTableViewCell
        let save = saved[indexPath.row]
        latitude = save.latitude
        longitude = save.longitude
        if let name = save.name {
        mapLabel = name
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          self.table.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bizToDelete = saved [indexPath.row]
            CoreDataHelper.delete(savedSearch: bizToDelete)
            saved = CoreDataHelper.retrieveBusinesses()
        }
    }
    
}
