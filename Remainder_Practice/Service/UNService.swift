//
//  UNService.swift
//  Remainder_Practice
//
//  Created by Ravikumar on 01/03/22.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    //... This private
    private override init() {}
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No UN Auth error")
            
            guard granted else {
                print("User Denied Access")
                return
            }
            self.configure()
        }
    }
    
    
    func configure() {
        unCenter.delegate = self
        self.setupActinsAndCategories()
    }
    
    func setupActinsAndCategories() {
        
        let timerAction = UNNotificationAction(identifier: NotificatinActionsID.timer.rawValue,
                                               title: "Run Timer",
                                               options: [.authenticationRequired])
        
        let dateAction = UNNotificationAction(identifier: NotificatinActionsID.date.rawValue,
                                              title: "Run Date",
                                              options: [.foreground])
        
        let locationAction = UNNotificationAction(identifier: NotificatinActionsID.location.rawValue,
                                                  title: "Run Location",
                                                  options: [.destructive])
        
        let timerCategory = UNNotificationCategory(identifier: NotificationCategory.timer.rawValue, actions: [timerAction], intentIdentifiers: [])

        let dateCategory = UNNotificationCategory(identifier: NotificationCategory.date.rawValue, actions: [dateAction], intentIdentifiers: [])

        let locationCategory = UNNotificationCategory(identifier: NotificationCategory.location.rawValue, actions: [locationAction], intentIdentifiers: [])
        unCenter.setNotificationCategories([timerCategory,dateCategory,locationCategory])
    }
    
    
    func  timerRequest(with interval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "Time Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.timer.rawValue
        if let attchment = getAttachment(for: .timer) {
            content.attachments = [attchment]
        }

        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request  = UNNotificationRequest(identifier: "usernotificatin.timer",
                                             content: content,
                                             trigger: trigger)
        unCenter.add(request)
    }
    
    func  dateRequest(with components: DateComponents) {
           
           let content = UNMutableNotificationContent()
           content.title = "Date Finished"
           content.body = "Your Date is all done. YAY!"
           content.sound = .default
           content.badge = 1
        content.categoryIdentifier = NotificationCategory.date.rawValue

        if let attchment = getAttachment(for: .date) {
            content.attachments = [attchment]
        }

           let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
           let request  = UNNotificationRequest(identifier: "usernotificatin.date",
                                                content: content,
                                                trigger: trigger)
           unCenter.add(request)
       }
    
    func locationRequest() {
        let content = UNMutableNotificationContent()
        content.title = "Location"
        content.body = "Back same location"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.location.rawValue

        if let attchment = getAttachment(for: .location) {
            content.attachments = [attchment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        unCenter.add(request)
        
    }
    
    func getAttachment(for id: NotificationAttachmentID) -> UNNotificationAttachment? {
        
        var imageName:String
        
        switch id {
        case .timer:
            imageName = "timer"
        case .date:
            imageName = "Calendar"
        case .location:
            imageName = "location"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: ".png")
        else { return nil}
        do {
          let attachment =  try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
        } catch  {
            return nil
        }
    }
}

extension UNService:UNUserNotificationCenterDelegate {
    
    //... This is when User wants to interact with Notificatins.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        if let action = NotificatinActionsID(rawValue: response.actionIdentifier) {
            NotificationCenter.default.post(name: NSNotification.Name("internalNotification.handler"), object: action)
        }
        completionHandler()
    }
    
    //... This will when app in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("UN will present")
        let options:UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}

























































































