//
//  Word.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation

class Word: Codable {
    var id: String
    var word: String
    var definition: String
    var scenarios: [String]
    var hasBeenLearned: Bool
}

