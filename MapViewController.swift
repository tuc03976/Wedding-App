//
//  MapViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 6/4/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit

class MapViewController: UITableViewController {
    
    
    /////////////////////////////////////////// VARIABLES, OUTLETS AND CONSTANTS ////////////////////////////////////////////////
    
    
    let placeArray: [String] = ["Cityhall", "New York"]
    
    
    let urlArray: [String] = ["https://www.google.com/maps/place/Philadelphia+City+Hall/@39.9515206,-75.1655665,17z/data=!4m5!3m4!1s0x89c6a1a0d0bbbfc9:0x9b6b64e3977584e5!8m2!3d39.9523789!4d-75.1635996"]
    
    
    let appArray: [String] =  ["comgooglemaps://?center=39.9515206,-75.1655665&zoom=14&views=traffic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        presentAlert(alert: "Select a place you need directions to")
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /////////////////////////////////////////////////        TABLEVIEWS        ///////////////////////////////////////////////////////////////
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = placeArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        cell.textLabel?.font = UIFont(name:"Avenir", size:22)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let urlString = self.urlArray[indexPath.row]
        
        
        
        //  let url = URL(string: urlString)
        
        
        //        if let url = URL(string: urlString)
        //        {
        //
        //            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //        }
        //    }
        
        
        // Tries to open app and if unsuccessful opens website
        
        
        let appUrl = URL(string: self.appArray[indexPath.row])
        
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            
            UIApplication.shared.open(appUrl!, options: [:], completionHandler: nil)
        } else { print("cant open app")
            
            if let url = URL(string: urlString)
            {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        
    }
    
    
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
      ////////////////////////////////////////////////        ALERT         /////////////////////////////////////////////////////////////////////////
    
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Wedding Locations", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
        
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
}
    
    
    
    
    
    
    

