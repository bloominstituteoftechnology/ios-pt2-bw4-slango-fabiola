//
//  WordDetailViewController.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import UIKit

class WordDetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var backgroundGradient: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definitionTextView: UITextView!
    
    // MARK: Properties
    var wordController: WordController?
    var word: Word? {
        didSet {
            updateViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackgroundColor()
        updateViews()
    }
    
    // MARK: - UI
    
    func setGradientBackgroundColor() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(named: "AppLightBlue")!.cgColor, UIColor(named: "AppDarkBlue")!.cgColor ]
        gradientLayer.shouldRasterize = true
        backgroundGradient.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        wordLabel.text = word?.word
        definitionTextView.text = word?.definition
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
