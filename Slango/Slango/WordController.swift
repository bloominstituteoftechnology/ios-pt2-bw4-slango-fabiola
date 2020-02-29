//
//  WordController.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation

class WordController {
    
    // MARK: Properties
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "words", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    // MARK: Functions
    func loadFromPersistentStore(completion: @escaping ([Word]?, Error?) -> Void) {
        let bgQueue = DispatchQueue(label: "wordQueue", attributes: .concurrent)
        
        bgQueue.async {
            let fm = FileManager.default
            guard let url = self.persistentFileURL, fm.fileExists(atPath: url.path) else {
                completion(nil, nil)
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let words = try decoder.decode([Word].self, from: data)
                completion(words, nil)
            } catch {
                print("Error loading student data: \(error)")
                completion(nil, error)
            }
        }
    }
}
