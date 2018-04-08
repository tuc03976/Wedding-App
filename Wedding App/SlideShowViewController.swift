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
    
    var imageName: String = ""
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print(imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSlides(_ sender: Any) {
        
        let ref = Storage.storage().reference().child("images")
        let picRef = ref.child(imageName)
        
        picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("\(error)")
            } else {
                
                self.imageView.image = UIImage(data: data!)
                print(self.imageName)
            }
        }
        
        
        
    }
    
 

}
