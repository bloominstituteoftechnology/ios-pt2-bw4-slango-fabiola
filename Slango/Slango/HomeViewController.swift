//
//  HomeViewController.swift
//  Slango
//
//  Created by Fabiola S on 2/27/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var backgroundGradient: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private let wordController = WordController()
    private var words: [Word] = []
    var word: Word?
    var learningStarted: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        UNService.shared.authorize()
        NotificationCenter.default.addObserver(self, selector: #selector(handleAction(_:)), name: NSNotification.Name("internalNotification.handleAction"), object: nil)
        
        setGradientBackgroundColor()
        tableView.delaysContentTouches = false
        
        wordController.loadFromPersistentStore { words, error in
            if let error = error {
                print("Error loading words: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.words = words ?? []
                self.word = self.words.first
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UI
    func setGradientBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(named: "AppDarkBlue")!.cgColor, UIColor(named: "AppLightBlue")!.cgColor ]
        gradientLayer.shouldRasterize = true
        backgroundGradient.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        for word in words {
            triggerNotification(word: word)
            print(word)
            }
    }
    
    func triggerNotification(word: Word) {
        var components = DateComponents()
        components.second = 10
        UNService.shared.firstNotificationForNewWord(with: components, word: word)
        
    }
    
    func triggerScenarioNotification(word: Word, scenario: Int) {
        var components = DateComponents()
        components.second = 10
        switch scenario {
        case 1:
            UNService.shared.scenario1Notification(with: components, word: word, scenarioIndex: 0, scenarioTranslation: 1)
        case 2:
            UNService.shared.scenario2Notification(with: components, word: word, scenarioIndex: 2, scenarioTranslation: 3)
        case 3:
            UNService.shared.scenario3Notification(with: components, word: word, scenarioIndex: 4, scenarioTranslation: 5)
            
        default:
            UNService.shared.firstNotificationForNewWord(with: components, word: word)
        }
        
    }
    
    @objc func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionsID else { return }
        print(word)
        guard var word = word else { return }
        
        switch action {
        case .firstNotification: triggerScenarioNotification(word: word, scenario: 1)
        case .scenario1: triggerScenarioNotification(word: word, scenario: 2)
        case .scenario2: triggerScenarioNotification(word: word, scenario: 3)
        case .scenario3: word.hasBeenLearned = true
            
        
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WordDetailSegue" {
            if let wordDetailVC = segue.destination as? WordDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                wordDetailVC.wordController = wordController
                wordDetailVC.word = words[indexPath.row]
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordTableViewCell
        let word = words[indexPath.row]
        cell.word = word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
