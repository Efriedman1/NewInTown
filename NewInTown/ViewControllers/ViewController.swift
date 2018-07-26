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


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let categories = ["Food", "Entertainment", "Gyms", "Coffee Shops", "Museums"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendCategoryRequest()
        
        table.dataSource = self
        table.delegate = self
        table.reloadData()
    
    }
    func categoryParams(){
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getBiz(sender : UIButton) {
       // created a button that calls this so taht u dont have to rerun the app evrytime to get a call and work w the json, just set break points in the bizrequest function at the print line to work w it and tap button everytime to execute
        sendBusinessRequest()
    }
}

