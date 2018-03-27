//
//  PictureViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 3/11/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController?
    
    var imageName = "E7E6DC63-6339-4D9D-8513-FBACE6B7C3B4.jpg"
    // "\(NSUUID().uuidString).jpg"
    var users : [User] = []
    var snapDescription = "testing"
    var downloadURL = ""
    let storage = Storage.storage().reference()
    let database = Database.database().reference()
    
    
    
    
    
    
    
    
    @IBAction func post(_ sender: Any) {
        
        let reference = storage.child("images")
        let picRef = reference.child(imageName)
        
        picRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("\(error)")
            } else {
                // Data for "images/island.jpg" is returned
                self.imageView.image = UIImage(data: data!)
            }
        }
        
        
        
    }
    
    
    
    
    
    @IBAction func folder(_ sender: Any) {
        
        let imagesFolder = Storage.storage().reference().child("images")
        
        if let image = imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                imagesFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                     print(error.localizedDescription)
                    } else {
//                        database.child("users").child(user.uid).child("picture").setValue(imageName)
                        
                        print("success")
       
                    }
                }
            )}
            
        } }
    
    
    

    
  
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
