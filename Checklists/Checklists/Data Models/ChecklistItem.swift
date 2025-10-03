//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Tina  on 5.08.25.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false 
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
    }
    
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            print("We should schedule a notofocation")
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = text
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled:\(request) for itemID: \(itemID)")
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    deinit {
        removeNotification()
    }
}
