//
//  MenuViewController.swift
//  Wedding App
//
//  Created by Steven Watson on 2/4/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//

import UIKit
import CircleMenu


extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            red: 1.0 / 255.0 * CGFloat(red),
            green: 1.0 / 255.0 * CGFloat(green),
            blue: 1.0 / 255.0 * CGFloat(blue),
            alpha: CGFloat(alpha))
    }
}


class MenuViewController: UIViewController, CircleMenuDelegate {
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
        
}

    
    
     ////////////////////////// VARIABLES, OUTLETS AND CONSTANTS ////////////////////////////////
    
    //  let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
    let items: [(icon: String, color: UIColor)] = [
        ("camera", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("screen", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("placeholder", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("controller", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("home", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1)),
        ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let midY = self.view.frame.height / 2
        let midX = self.view.frame.width / 2
   
        
                let button = CircleMenu(
                    frame: CGRect(x: midX - 25, y: midY - 25, width: 50, height: 50),
                    normalIcon:"icon_menu",
                    selectedIcon:"icon_close",
                    buttonsCount: 5,
                    duration: 2,
                    distance: 120)
                button.backgroundColor = UIColor.white
                button.delegate = self
                button.layer.cornerRadius = button.frame.size.width * 0.25
                view.addSubview(button)
        
        
    }
    
     ////////////////////////////////////////////////////////////////////////////////////
    
    
    
    /////////// MARK: CIRCLE METHODS //////////////
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
       
        
    }
    
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        switch atIndex {
        case 0:
            print("Picture!")
            performSegue(withIdentifier: "Go", sender: self)
        case 1:
            performSegue(withIdentifier: "Go2", sender: self)
            print("Slide Show!")
        case 2:
            performSegue(withIdentifier: "Go3", sender: self)
            print("Map!")
        case 3:
            performSegue(withIdentifier: "Go4", sender: self)
            print("Quiz")
        case 4:
            openWeb()
            
        default:
            print("Keep Trying")
        }
        
        
        
       //////////////////////////////////////////////////////////////////////////////////////
        
    }
    
    func openWeb() {
     
        let urlString = "http://watsonscottunion.minted.us/"
        
    if let url = URL(string: urlString)
    {
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    }
    
    
}

