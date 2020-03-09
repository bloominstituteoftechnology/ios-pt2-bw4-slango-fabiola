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
        setupActionsAndCategories()
    }
    
    func setupActionsAndCategories() {
        let firstWordAction = UNNotificationAction(identifier: NotificationActionsID.firstNotification.rawValue, title: "Got it!", options: [.authenticationRequired])
        let scenario1Action = UNNotificationAction(identifier: NotificationActionsID.scenario1.rawValue, title: "Ok cool!", options: [.authenticationRequired])
        let scenario2Action = UNNotificationAction(identifier: NotificationActionsID.scenario2.rawValue, title: "Thanks! I got it", options: [.authenticationRequired])
        let scenario3Action = UNNotificationAction(identifier: NotificationActionsID.scenario3.rawValue, title: "All done", options: [.authenticationRequired])
        
        let firstWordCategory = UNNotificationCategory(identifier: NotificationCategory.firstNotification.rawValue, actions: [firstWordAction], intentIdentifiers: [])
        let scenario1Category = UNNotificationCategory(identifier: NotificationCategory.scenario1.rawValue, actions: [scenario1Action], intentIdentifiers: [])
        let scenario2Category = UNNotificationCategory(identifier: NotificationCategory.scenario2.rawValue, actions: [scenario2Action], intentIdentifiers: [])
        let scenario3Category = UNNotificationCategory(identifier: NotificationCategory.scenario3.rawValue, actions: [scenario3Action], intentIdentifiers: [])
        
        unCenter.setNotificationCategories([firstWordCategory, scenario1Category, scenario2Category, scenario3Category])
    }
    
    func firstNotificationForNewWord(with components: DateComponents, word: Word) {
        let content = UNMutableNotificationContent()
        
        content.title = "Let's learn: \(word.word)"
        content.body = "Definition:\n\(word.definition)"
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.firstNotification.rawValue
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.date", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    // Separated each notification into a function because it was causing bugs when handling each action
    func scenario1Notification(with components: DateComponents, word: Word, scenarioIndex: Int, scenarioTranslation: Int) {
        let content = UNMutableNotificationContent()
        
        content.title = "Pst! Remember: \(word.word)?"
        content.body = "Example:\n\(word.scenarios[scenarioIndex])\n\nTranslation:\n\(word.scenarios[scenarioTranslation])"
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.scenario1.rawValue
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.firstScenario", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func scenario2Notification(with components: DateComponents, word: Word, scenarioIndex: Int, scenarioTranslation: Int) {
        let content = UNMutableNotificationContent()
        
        content.title = "What was that word again? \(word.word)?"
        content.body = "Example:\n\(word.scenarios[scenarioIndex])\n\nTranslation:\n\(word.scenarios[scenarioTranslation])"
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.scenario2.rawValue
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.secondScenario", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func scenario3Notification(with components: DateComponents, word: Word, scenarioIndex: Int, scenarioTranslation: Int) {
        let content = UNMutableNotificationContent()
        
        content.title = "Hello! Is it \(word.word) you're looking for?"
        content.body = "Example:\n\(word.scenarios[scenarioIndex])\n\nTranslation:\n\(word.scenarios[scenarioTranslation])"
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.scenario3.rawValue
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.thirdScenario", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
     
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        if let action = NotificationActionsID(rawValue: response.actionIdentifier) {
            NotificationCenter.default.post(name: NSNotification.Name("internalNotification.handleAction"), object: action)
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
