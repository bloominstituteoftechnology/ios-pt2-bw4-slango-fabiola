//
//  WordTableViewCell.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definition: UITextView!
    
    var word: Word? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let word = word else { return }
        wordLabel.text = word.word
        definition.text = word.definition
    }

}
