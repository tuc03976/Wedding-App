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


//// Things I need to add
//Storing image on firebase storage
//Storing image url on firebase database
//passing image to slideshowViewController


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController?
    
    var imageName = ""
    var image: UIImage?
    var users : [User] = []
    var downloadURL: String?
    let storage = Storage.storage().reference()
    let database = Database.database().reference()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
       
    
    }
    
    
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
        if imagePicker != nil {
            
            imagePicker!.sourceType = .photoLibrary
            
            present(imagePicker!, animated: true, completion: nil) }
        
    }
    
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        if imagePicker != nil {
            
            imagePicker!.sourceType = .camera
            
            present(imagePicker!, animated: true, completion: nil) }
        
        
    }
    
    
    

    
    
    
    
    
    @IBAction func folder(_ sender: Any) {
        
       // imageName = "\(NSUUID().uuidString).jpg"
        
        if imageName == "" {
            
            presentAlert(alert: "Choose or Take An Image First")
            print("save image first")
            
        } else {
            
      //  let coreDataStorage = CoreImages(context: self.context)
            
        let imagesFolder = Storage.storage().reference().child("images")
        
        let photoRef = Database.database().reference().child("photos").childByAutoId()

        let photoDictionary = ["image" : imageName]

        photoRef.setValue(photoDictionary)
            
            
        
        
        if let image = imageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                imagesFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        self.presentAlert(alert: error.localizedDescription)
                    } else {
                        
                        
                        if let downloadURL = metadata?.downloadURL()?.absoluteString {
                            print(downloadURL)
                            
                        }
                        print("Name of \(self.imageName)")
                        print("saved")
                        
                       // coreDataStorage.savedImages = imageData
                        
                        
                        self.performSegue(withIdentifier: "ToSlide", sender: self)                    }
                }
                )}
            
            
        }
        
        }
     }
    
    @IBAction func shareTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSlide" {
       
            if let selectVC = segue.destination as? SlideShowViewController {
                selectVC.imageName = imageName
                // saveCoreData()
            
                
            }
            
            
            
            
            
        }
    
    

    }
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)

        
        
    }
    
    
    func saveCoreData() {
        
        do {
            try context.save()
            print("saved")
        } catch {
            print("Error \(error)")
            
        }
        
    }

   

}
