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


class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var topButton: UIButton!
    
    
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    @IBAction func topTapped(_ sender: Any) {
        
        
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if signupMode {
                    // Sign up
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            
                            self.presentAlert(alert: error.localizedDescription)
                            
                        } else {
                            
                            
                            if let user = user {
                                
                                Database.database().reference().child("users").child(user.uid).child("email").setValue(user.email)
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
                            
                            
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                            
                        }
                        
                    })
                }
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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    
    
}

