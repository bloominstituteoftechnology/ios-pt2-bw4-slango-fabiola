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
    
    var words: [WordList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackgroundColor()
        // Do any additional setup after loading the view.
        //TESTING
        words = WordList.createWords()
        tableView.delegate = self as! UITableViewDelegate
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delaysContentTouches = false
        
    }
    
    // MARK: - UI
    
    func setGradientBackgroundColor() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0, green: 0.3529411765, blue: 0.737254902, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.7573584914, blue: 1, alpha: 1).cgColor ]
        gradientLayer.shouldRasterize = true
        backgroundGradient.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = words[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell") as! WordTableViewCell
        cell.setWord(word: word)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
}
