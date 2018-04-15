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
    
    //// Things I need to add
    //Upload Images from firebase storage
    //Put images in a sort of slideshow or feed
    //Refresh images after all images was displyed
    
    //Next
    //Create a array of imageNames and store in firebase database
    
    var imageNameList: [String] = []
    
    var imageArray: [UIImage] = []
    
    var imageName: String = ""
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray.append(UIImage(named: "icon_menu")!)
        imageArray.append(UIImage(named: "icon_close")!)
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         retrievePhotos()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSlides(_ sender: Any) {
        
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
    
    

    var firstImageView = UIImageView()
    var secondImageView = UIImageView()
    var currentImageindex = 0
    
    
//    override func viewDidLoad() {
//        view.addSubview(firstImageView)
//        view.addSubview(secondImageView)
//        images.append(UIImage(named: "1.png")!)
//        images.append(UIImage(named: "icon_close")!)
//        firstImageView.image = imageArray[0]
//        secondImageView.image = imageArray[1]
//    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstImageView.frame = view.frame
        secondImageView.frame = view.frame
    }

//    override func viewDidAppear(_ animated: Bool) {
//        animateImageViews()
//    }
//
    
    @IBAction func startSlideShow(_ sender: Any) {
        
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        
        animateImageViews()
        
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


    
    
    
 

}
