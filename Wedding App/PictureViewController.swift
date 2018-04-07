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
import AVKit
import AVFoundation
import Social
import MobileCoreServices
import SDWebImage


//// Things I need to add
//Storing image on firebase storage
//Storing image url on firebase database
//passing image to slideshowViewController


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController?
    
    var imageName = "\(NSUUID().uuidString).jpg"
    var users : [User] = []
    var downloadURL = ""
    let storage = Storage.storage().reference()
    let database = Database.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        print(imageName)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = image
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func selectPhotoTapped(_ sender: Any) {
        if imagePicker != nil {
            
            imagePicker!.sourceType = .photoLibrary
            
            present(imagePicker!, animated: true, completion: nil) }
        
    }
    
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        if imagePicker != nil {
            
            imagePicker!.sourceType = .camera
            
            present(imagePicker!, animated: true, completion: nil) }
        
        
    }
    
    
    
    @IBAction func post(_ sender: Any) {
        
        
        
        
        
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
    
    
    
    
    
    @IBAction func folder(_ sender: Any) {
        
        //Save photo and send to slideshowviewcontroller
        
        let imagesFolder = Storage.storage().reference().child("images")
        
        if let image = imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                imagesFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                     print(error.localizedDescription)
                    } else {
                        

        if let downloadURL = metadata?.downloadURL()?.absoluteString {
                            print(downloadURL)
            
            
            
                        }
                    
                        
                        print("saved")
       
                    }
                }
            )}
            
        } }
    
    @IBAction func shareTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
        
        
        
    }

 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
