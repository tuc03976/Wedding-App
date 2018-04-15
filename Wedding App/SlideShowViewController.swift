//
//  SlideShowViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 4/1/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit
import Firebase

class SlideShowViewController: UIViewController {
    
   
    
    var imageNameList: [String] = []
    
    var imageArray: [UIImage] = []
    
    var imageName: String = ""
    
    var firstImageView = UIImageView()
    
    var secondImageView = UIImageView()
    
    var currentImageindex = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray.append(UIImage(named: "icon_menu")!)
        imageArray.append(UIImage(named: "icon_close")!)
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         retrievePhotos()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        downloadImages()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstImageView.frame = view.frame
        secondImageView.frame = view.frame
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
                    //   self.imageView.image = UIImage(data: data!)
                    print(self.imageArray)
                    
                    
                }
            }
            
        }
        
    }
    
    
    //TODO: Create the retrieveMessages method here:
    
    func retrievePhotos() {
        
        let photoDB = Database.database().reference().child("photos")
        
        photoDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["image"]!
         
            self.imageNameList.append(text)
            print(self.imageNameList)
            
            
        }
        
        
    }
    
    func animateImageViews() {
        
        
        
        swap(&firstImageView, &secondImageView)
        secondImageView.image = imageArray[currentImageindex]
        currentImageindex = (currentImageindex + 1) % imageArray.count
        UIView.animate(withDuration: 3, animations: {
            self.firstImageView.alpha = 0
            self.secondImageView.alpha = 1
        }, completion: { _ in
            self.animateImageViews()
        })
    }
    
    
    
    
    
    @IBAction func startSlideShow(_ sender: Any) {
        
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        
        animateImageViews()
        
    }
    
    
 

}
