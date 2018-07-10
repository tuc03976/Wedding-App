//
//  ViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 2/4/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class ViewController: UIViewController, UITextFieldDelegate {
    
    //////////////////// VARIABLES, OUTLETS AND CONSTANTS ///////////////////
    
    
    var interger: [Int] = []
    var names: [String] = []
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    //////////////////////////////////////////////
    
    ////////// SIGN IN AND OFF /////////////
    
    @IBAction func topTapped(_ sender: Any) {
        
        
        if let username = usernameTextField.text {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                
                   SVProgressHUD.show()
                
                if signupMode {
                    // Sign up
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                             SVProgressHUD.dismiss()
                             self.presentAlert(alert: error.localizedDescription)
                            
                        } else {
                            
                            
                            if let user = user {
                                
                              //  Database.database().reference().child("users").child(user.uid).child("email").setValue(user.email)
                                
                                
                              //  Database.database().reference().child("users").child(user.uid).child("score").setValue(100)
                                
                                
                                let dictionary = ["email": user.email, "score":"50", "name": username, "password": password, "uid": user.uid, "photos": ""] as [String : Any]
                                
                                
                                Database.database().reference().child("users").child(user.uid).setValue(dictionary)
                                
                                
                                 SVProgressHUD.dismiss()
                                self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                            }
                        }
                    })
                    
                } else {
                    
                    // Log In
                    
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            
                            self.presentAlert(alert: error.localizedDescription) } else {
                            print("Log In was successful :)")
                            
                             SVProgressHUD.dismiss()
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                            
                        }
                        
                    })
                }
            }
        }
        
        }
        
        
        
        
    }
    
    
    
    @IBAction func bottomTapped(_ sender: Any) {
        
        if signupMode {
            // switch to Log In
            signupMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
        } else {
            // Switch to Sign up
            signupMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)        }
    }
    
    ///////////////////////////////////////////////////////////////////////////
    
    
    
    ////////// ALERT  /////////////
    
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in alertVC.dismiss(animated: true, completion: nil)
            
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
        
    }
    
  ///////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        fetchData()
        
        
    }
    
    /////////////////////// UITextField Delegates/////////////////////////////////
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called\(textField.text!)")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    
    
      ///////////////////////////////////////////////////////////////////////////
    
    
    
    
    func fetchData() {
      
        
        let rootRef = Database.database().reference()
        let query = rootRef.child("users").queryOrdered(byChild: "score")
        query.observeSingleEvent(of: .value) {
            (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let score = value?["score"] as? String ?? ""
                
             //   print(name)
             //   print(score)
                if let a = Int(score)  {
                    self.interger.append(a)
               //     print(self.interger)
                    
                }
                
                if let b = name as String? {
                    self.names.append(b)
                //    print(self.names)
                    
                }
                
                assert(self.names.count == self.interger.count)
                var dict = [String:Int]()
                for i in 0..<self.interger.count {
                    let key = self.names[i]
                    let value = self.interger[i]
                    dict[key] = value
                }
                
            //   (Array(dict).sorted{$0.1 < $1.1}).forEach{(k,v) in print("\(k):\(v)")}
                
                
                
                dict = [String : Int](uniqueKeysWithValues: dict.sorted{ $0.key < $1.key })
                print(dict)
                
              
            }
        
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}

