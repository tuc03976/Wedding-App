//
//  CustomTableViewCell.swift
//  Wedding App
//
//  Created by Steven Watson on 4/26/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//


import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var weddingimage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        weddingimage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
