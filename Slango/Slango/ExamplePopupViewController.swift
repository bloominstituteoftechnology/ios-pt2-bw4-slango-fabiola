//
//  ExamplePopupViewController.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import UIKit

class ExamplePopupViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var wordExampleTextView: UITextView!
    @IBOutlet weak var exampleTranslationTextView: UITextView!
    
    // MARK: Properties
    var wordController: WordController?
    var word: Word?
    var index: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: UI
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        switch index {
        case 0:
            wordExampleTextView.text = word?.scenarios[0]
            exampleTranslationTextView.text = word?.scenarios[1]
        case 1:
            wordExampleTextView.text = word?.scenarios[2]
            exampleTranslationTextView.text = word?.scenarios[3]
        case 2:
            wordExampleTextView.text = word?.scenarios[4]
            exampleTranslationTextView.text = word?.scenarios[5 - 1]
        default:
            wordExampleTextView.text = ""
            exampleTranslationTextView.text = ""
        }
    }
    
}
