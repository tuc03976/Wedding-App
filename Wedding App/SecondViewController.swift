//
//  SecondViewController.swift
//  Quizzler
//
//  Created by Jean Santiuste on 5/28/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
  
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
//        let list = [" \(scoreKey) : \(score) "]
//
//        return(list.count)
//
       return(scoreKey.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        assert(self.scoreKey.count == self.score.count)
        var dict = [String:Int]()
        for i in 0..<self.score.count {
            let key = self.scoreKey[i]
            let value = self.score[i]
            dict[key] = value
        }
        

       // let list = [" \(scoreKey) : \(score) "]
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = "\(scoreKey[indexPath.row]) : \(score[indexPath.row])"
        
        
        return(cell)
        
    }
    
    
    
    
    // Initialization of variables
    
    var score : [Int] = []
    var scoreKey : [String] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(scoreKey)
        print(score)
        
        //let list = ["\(scoreKey):\(score)"]
        
        //print("\(scoreKey)'s high score is: \(score)")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToHome", sender: self)
        
        }

    

}
