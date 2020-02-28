//
//  CardView.swift
//  Slango
//
//  Created by Fabiola S on 2/28/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    
    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform:  nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 9, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 35
        
        layer.cornerRadius = 35
    }
}
