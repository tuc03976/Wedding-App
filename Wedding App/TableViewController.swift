//
//  TableViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 4/26/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//



import UIKit
import Firebase


class TableViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    var imageArray: [UIImage] = []
    
    var imageNameList: [String] = []
    
    
    let cellSpacingHeight: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    

        imageArray.append(UIImage(named: "icon_close")!)
    
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.separatorStyle = .none
      
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
       
        
       
        
    }
    

    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 400
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        cell.weddingimage.image = imageArray[indexPath.row]
        
        //shape of photos
        
        cell.weddingimage.layer.cornerRadius = cell.weddingimage.frame.height / 2
        
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.imageView?.image = imageArray[indexPath.row]
//
         cell.clipsToBounds = true
//
        
        return cell
    }
    
    
    
    func configureTableView() {
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func downloadImages() {
        
        
        for item in imageNameList {
            
            let ref = Storage.storage().reference().child("images")
            let picRef = ref.child(item)
            
            picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    
                    // Uh-oh, an error occurred!
                    print("\(error)")
                    
                    
                    
                } else {
                    
                    self.imageArray.append(UIImage(data: data!)!)
                    print(self.imageArray)
                 
                   
                    
                }
            }
            
        }
        
        if imageNameList.count == 0 {
            
            self.presentAlert(alert: "Need wifi connection")
            
        } else {
            
            // self.tableview.reloadData()
        }
        
    }
    
    
    func retrievePhotos() {
        
        let photoDB = Database.database().reference().child("photos")
        
        photoDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["image"]!
            
            self.imageNameList.append(text)
            print(self.imageNameList)
            
            
            
        }
        
        
    }
    
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
        
        
    }
    
    
    
}
