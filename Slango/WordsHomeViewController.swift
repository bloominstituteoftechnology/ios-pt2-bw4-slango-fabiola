//
//  WordsHomeViewController.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import UIKit

class WordsHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        // Do any additional setup after loading the view.
    }
    
    
    func gradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.007843137255, green: 0.2196078431, blue: 0.6274509804, alpha: 1).cgColor, UIColor(red: 10/255, green: 179/255, blue: 255/255, alpha: 1).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner
        gradientLayer.shouldRasterize = true
        self.view.layer.addSublayer(gradientLayer)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
