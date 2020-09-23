//
//  ViewController.swift
//  User Notification using StoryBoard
//
//  Created by Md Khaled Hasan Manna on 9/1/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController,UNUserNotificationCenterDelegate {
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerSelector))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send Notification", style: .done, target: self, action: #selector(sendNotificationSelector))
      
        UNUserNotificationCenter.current().delegate = self
    }

    
    
    @objc func registerSelector(){
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
            
          
                if success{
                    print("Successfully Registered")
                  
                    
                }else{
                    print("Error in registration")
                }
            
            
        }
        
    }

    @objc func sendNotificationSelector(){
        
        registerCategory()
        
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.subtitle = "Notification subTitle"
        content.body = "This is body of the notification.This is body of the notification.This is body of the notification.This is body of the notification"
        content.sound = .default
        content.categoryIdentifier = "alarm"
        content.userInfo = ["name":"manna"]
        
        
        
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: timeTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            
            if error == nil{
            
                print("Success")
            }
        }
        
        
        
        
    }
    
    
    func registerCategory(){
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let actionLearneMore = UNNotificationAction(identifier: "action", title: "Learn More", options: .foreground)
        let dismiss = UNNotificationAction(identifier: "Dismiss", title: "Dismiss", options: .destructive)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [actionLearneMore,dismiss], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
        
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
       
        
        if ((userInfo["name"]) as? String) != nil{
            
            
            switch response.actionIdentifier {
                
            case UNNotificationDefaultActionIdentifier:
                 print("Hi dude")
                break
            case UNNotificationDismissActionIdentifier:
                print("Hi Baby")
                break
            case "action":
                print("Hello World")
                
                break
            case "dismiss":
                print("Dissmiss")
            default:
                break
            }
            
        }
      
        completionHandler()
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.badge,.sound])
        
    }
    
}

