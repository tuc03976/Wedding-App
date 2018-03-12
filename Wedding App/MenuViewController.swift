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

    //  let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1)),
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midY = self.view.frame.height / 2
        let midX = self.view.frame.width / 2
   
        
                let button = CircleMenu(
                    frame: CGRect(x: midX - 25, y: midY - 25, width: 50, height: 50),
                    normalIcon:"icon_menu",
                    selectedIcon:"icon_close",
                    buttonsCount: 4,
                    duration: 2,
                    distance: 120)
                button.backgroundColor = UIColor.white
                button.delegate = self
                button.layer.cornerRadius = button.frame.size.width * 0.25
                view.addSubview(button)
    }
    
    // MARK: <CircleMenuDelegate>
    
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
            performSegue(withIdentifier: "Go", sender: self)
            print("Slide Show!")
        default:
            print("Keep Trying")
        }
        
        
        
        
        
    }
}

