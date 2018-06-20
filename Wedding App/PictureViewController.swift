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
import CoreData
import SVProgressHUD


//// Things I need to add
//Storing image on firebase storage
//Storing image url on firebase database
//passing image to slideshowViewController


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    ////////////////////////// VARIABLES, OUTLETS AND CONSTANTS ////////////////////////////////
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController?
    
    var imageName = ""
    var image: UIImage?
    var users : [User] = []
    var downloadURL: String?
    let storage = Storage.storage().reference()
    let database = Database.database().reference()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var uid = ""
    var email = ""
    var name = ""
    var score = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            uid = user.uid
            let scoreDB = Database.database().reference().child("users").child(user.uid).child("score")
            scoreDB.setValue("100")
            
            
        
            // ...
        }
        
        
        
        
       
    
    }
    
    ///////////////////////////////////////////////////////////
    
    
    ////////////////////////// PHOTO FUNCTIONS ////////////////////////////////
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageName = "\(NSUUID().uuidString).jpg"
            imageView.image = image
           
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func selectPhotoTapped(_ sender: Any) {
        SVProgressHUD.show()
        
        if imagePicker != nil {
            
            SVProgressHUD.dismiss()
            
            imagePicker!.sourceType = .photoLibrary
            
            present(imagePicker!, animated: true, completion: nil) } else {
            
            SVProgressHUD.dismiss()
            
            self.presentAlert(alert: "Photo Library Error") }
            
    }
    
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        SVProgressHUD.show()
        
        if imagePicker != nil {
            
            SVProgressHUD.dismiss()
            
            imagePicker!.sourceType = .camera
            
            present(imagePicker!, animated: true, completion: nil) } else {
            
            SVProgressHUD.dismiss()
            
            self.presentAlert(alert: "Camera feature not working")
            
            
        }
        
        
    }
    
    
    

    
    
    
    
    
    @IBAction func folder(_ sender: Any) {
        
        //This func is used in post button
        
       // imageName = "\(NSUUID().uuidString).jpg"
        
        
        SVProgressHUD.show()
        
        if imageName == "" {
            
            SVProgressHUD.dismiss()
            presentAlert(alert: "Choose or Take An Image First")
            print("save image first")
            
        } else {
            
      // Saves image on Firebase and goes to Slideshow
            
        let imagesFolder = Storage.storage().reference().child("images")
        
        let photoRef = Database.database().reference().child("photos").childByAutoId().child("image")
        
            
        photoRef.setValue(imageName)
        //let userRef = Database.database().reference().child("users").child(uid).child("photos")

       // let photoDictionary = ["image" : imageName]
            
       // userRef.setValue(imageName)
            
            
        
        
        if let image = imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                imagesFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        SVProgressHUD.dismiss()
                        self.presentAlert(alert: error.localizedDescription)
                    } else {
                        
                        
                        if let downloadURL = metadata?.downloadURL()?.absoluteString {
                            print(downloadURL)
                            
                        }
                        print("Name of \(self.imageName)")
                        print("saved")
                        
                
                        
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: "ToSlide", sender: self)                    }
                }
                )}
            
            
        }
        
        }
     }
    
    @IBAction func shareTapped(_ sender: Any) {
        
        SVProgressHUD.show()
        
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
        SVProgressHUD.dismiss()
        
    }
    
    
    
    
      /////////////////////////////////////   SEGUE   /////////////////////////////////////////
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSlide" {
       
            if let selectVC = segue.destination as? SlideShowViewController {
                selectVC.imageName = imageName
              
            }
         
        }
    
    }
    
    /////////////////////////////////////////////////

      ////////// ALERT  /////////////
    
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)

        
        
    }
    
      /////////////////////////////////////////
    

   

}
