//
//  UNService.swift
//  Slango
//
//  Created by Fabiola S on 3/4/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    // MARK: Properties
    private override init() {}
    static let shared = UNService()
    var wordController = WordController()
    
    
    let unCenter = UNUserNotificationCenter.current()
    
    // MARK: Functions
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No Authorization Error")
            guard granted else {
                // Add logic to handle not having authorization
                print("USER DENIED ACCESS")
                return
            }
            
            self.configure()
        }
    }
    
    func configure() {
        unCenter.delegate = self
    }
    
    func dateRequest(with components: DateComponents, word: Word) {
        let content = UNMutableNotificationContent()
        
        content.title = "Let's learn: \(word.word)"
        content.body = "Definition:\n\(word.scenarios[0])\n\nTranslation:\n\(word.scenarios[1])"
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "userNotification.date", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    
    
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
