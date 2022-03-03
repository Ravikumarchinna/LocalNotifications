//
//  ShadowView.swift
//  Remainder_Practice
//
//  Created by Ravikumar on 01/03/22.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        
        layer.shadowPath = CGPath(rect: layer.bounds, transform: nil)
        layer.shadowColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 4
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.cornerRadius = 5
    }
    
}




























































