//
//  CellView.swift
//  Slango
//
//  Created by Fabiola S on 2/28/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation
import UIKit

class CellView: UIView {
    
    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform:  nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 15
        
        layer.cornerRadius = 15
    }
}

