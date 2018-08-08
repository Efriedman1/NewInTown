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
    
    
//    func configure(cell: RecentTableViewCell, atIndexPath indexPath: IndexPath) {
//        let cell = table.dequeueReusableCell(withIdentifier: "savedSearch", for: indexPath) as! RecentTableViewCell
//        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "savedSearch", for: indexPath) as! RecentTableViewCell
        let save = saved[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
        tableView.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        cell.backgroundColor = UIColor(red: 0.98823529, green: 0.98823529, blue: 0.98823529, alpha: 1.5)
        cell.name.text = save.name
        cell.address.text = save.address
        cell.price.text = save.price
        cell.categories.text = save.categories
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! RecentTableViewCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saved.count 
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bizToDelete = saved [indexPath.row]
            CoreDataHelper.delete(savedSearch: bizToDelete)
            saved = CoreDataHelper.retrieveBusinesses()
        }
    }
    
}
