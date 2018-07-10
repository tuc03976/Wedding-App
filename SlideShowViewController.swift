//
//  SlideShowViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 4/1/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import SVProgressHUD

class SlideShowViewController: UIViewController {
    
    
    
    ///////////////////////////////////////// VARIABLES, OUTLETS AND CONSTANTS //////////////////////////////////////////
    
    @IBOutlet weak var displayImage: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard

    var coreDataArray: [UIImage] = []
    
    var coreImages = [CoreImages]()
    
    var numberOfPhotos: Int = 0
    
    var imageNameList: [String] = []
    
    var imageArray: [UIImage] = []
    
    var imageName: String = ""
    
    var firstImageView = UIImageView()
    
    var secondImageView = UIImageView()
    
    var currentImageindex = 0
    
    var imagesRetrieved: Bool = false
    
    var imagesAreDownloaded: Bool = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = false
        SVProgressHUD.show()
        retrievePhotos()
        
        let delayInSeconds = 2.0 // 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { // 2
            self.downloadImages()
            SVProgressHUD.dismiss()
            self.view.isUserInteractionEnabled = true
        }
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstImageView.frame = view.frame
        secondImageView.frame = view.frame
    }
    
    
    
    ////////////////////////// IMAGE METHODS ////////////////////////////////
    
    
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
                    self.numberOfPhotos = self.numberOfPhotos + 1
                    //self.defaults.set(self.numberOfPhotos, forKey: "numberOfPhotos")
                    print(self.numberOfPhotos)
                    
                    
                    
                    
                }
            }
            
        }
        
        if imageNameList.count == 0 {
            
            
            self.presentAlert(alert: "Need wifi connection")
           
        }
        
        
        
    }
    
    
    //TODO: Create the retrieveMessages method here:
    
    func retrievePhotos(){
        
        
        let photoDB = Database.database().reference().child("photos")
        
        photoDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["image"]!
         
            self.imageNameList.append(text)
            print(self.imageNameList)
            
            
        }
        
      
    }
    
    func animateImageViews() {
        
        if imageNameList.count == 0 {
            
            self.presentAlert(alert: "Need wifi connection")
            
        
        }  else {
            
        displayImage.isHidden = true
            
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
    
    
    
    
    
    @IBAction func startSlideShow(_ sender: Any) {
        
        if imageArray.count == 0 {
            print("error, images not downloaded")
            
        } else {
        
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        
            animateImageViews() }
        
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    //////////////////////////////////////////////////////// SEGUE //////////////////////////////////////////////////////////////////
    
    
    @IBAction func toFeed(_ sender: Any) {
        
        self.view.isUserInteractionEnabled = false
        
        SVProgressHUD.show()
        
        if imageArray.count == 0 {
            
            SVProgressHUD.dismiss()

            presentAlert(alert: "Images are not loaded")
            
            } else {
            
            self.view.isUserInteractionEnabled = true

            SVProgressHUD.dismiss()
            
            performSegue(withIdentifier: "toTable", sender: self)
            
            
            
        }
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTable" {
            
            if let selectVC = segue.destination as? TableViewController {
                selectVC.imageArray = imageArray
                // saveCoreData()
                
                
            }
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    //////////////////////////////////////////////////////////
    
    
    
    ////////////////////////// REFRESH ////////////////////////////////
    
    
    
    @IBAction func refresh(_ sender: Any) {
        
        self.view.isUserInteractionEnabled = false
        
        numberOfPhotos = 0
        imageNameList.removeAll()
        imageArray.removeAll()
        
        
        
        let delayInSeconds = 2.0 // 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { // 2

            SVProgressHUD.show()
            self.retrievePhotos()
            
            let delayInSeconds = 2.0 // 1
            DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { // 2
                self.downloadImages()
                SVProgressHUD.dismiss()
                self.view.isUserInteractionEnabled = true
            
        }
        
        
        
        } }
    
    
    
    ///////////////////////////////////////////////////////////////////////////////
    
    
    
    
    //////////////////////////////// ALERT /////////////////////////////////////////
    
    
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
        
        
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /////////////////////////////////////////// SAVE CORE METHODS /////////////////////////////////////////////////////
    
    
    
    
    func saveCoreData() {
        
        do {
            try context.save()
            print("saved")
        } catch {
            print("Error \(error)")
            
        }
        
    }
    
    func fetchCoreData() {
    
    let request : NSFetchRequest<CoreImages> = CoreImages.fetchRequest()
    
    do {  coreImages = try context.fetch(request)
    print("fetch success")
    } catch {
    
    print("error fetching data from context")
    }
 
    }
    
    
    func loadCoreData()  {
        
        for item in coreImages {
        
        let test = item
        
        if let data = test.savedImages {
        
            self.coreDataArray.append(UIImage(data: data)!)
            print("Core Data is in imageArray")
            
            
            
        } else {
            
            print("did not save into imageview")
            
            
        }
        
        
        }
        
        
    }
    
    
        ///////////////////////////////////////////////////////////////////////////////////////////////
    
}
