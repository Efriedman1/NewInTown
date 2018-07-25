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
class ViewController: UIViewController {

    //let json = JSON(data: dataFromNetworking)
    
    @IBOutlet var CategoryLabels: [UIStackView]!
    @IBOutlet weak var categoryOne: UILabel!
    @IBOutlet weak var categoryTwo: UILabel!
    @IBOutlet weak var categoryThree: UILabel!
    @IBOutlet weak var categoryFour: UILabel!
    @IBOutlet weak var categoryFive: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //categories()
        //sendBusinessRequest()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getBiz(sender : UIButton) {
       // created a button that calls this so taht u dont have to rerun the app evrytime to get a call and work w the json, just set break points in the bizrequest function at the print line to work w it and tap button everytime to execute
        sendBusinessRequest()
    }



//    func getBusiness(){
//        let basedURL = "https://api.yelp.com/v3/businesses/search"
//        let url = URL(string: basedURL)
//    }
}

