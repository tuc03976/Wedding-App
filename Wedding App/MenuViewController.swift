//
//  MenuViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 2/4/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
        
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
