//
//  CustomTableViewCell.swift
//  Wedding App
//
//  Created by Steven Watson on 4/26/18.
//  Copyright © 2018 Steven Watson. All rights reserved.
//


import UIKit


//Add user tags in tableview
//Add make the interface pretty 



class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var weddingimage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        weddingimage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        weddingimage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        weddingimage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        weddingimage.bottomAnchor.constraint(equalTo: self.label.topAnchor).isActive = true
        
        weddingimage.contentMode = .scaleAspectFill
        
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
