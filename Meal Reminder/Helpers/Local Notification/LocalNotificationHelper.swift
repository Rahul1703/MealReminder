//
//  LocalNotificationHelper.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/13/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation
import UserNotifications

enum Weekdays: String {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

class LocalNotificationHelper: NSObject {
    
    static let shared = LocalNotificationHelper()
    
    func scheduleNotification(dictionary: [String : Any], dietDuration: Int) {
        
        for (key) in (dictionary.keys) {
            if let array = dictionary[key] as? [[String : Any]] {
                for (foodObject) in (array) {
                    
                    fireNotification(weekDay: key, time: foodObject[Keys.mealTime] as! String, food: foodObject[Keys.food] as! String, dietDuration: dietDuration)
                }
            }
        }
    }
    
    func fireNotification(weekDay: String, time: String, food: String, dietDuration: Int) {
        
        let content = UNMutableNotificationContent()
        content.title = Keys.appName
        content.subtitle = food
        content.body = Message.itsTimeForMeal
        
        let afterFoodContent = UNMutableNotificationContent()
        afterFoodContent.title = Keys.appName
        afterFoodContent.subtitle = food
        afterFoodContent.body = Message.enjoyedYourMeal

        var components: DateComponents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: getTime(time: time)!)
        components.weekday = getWeekday(weekDay: weekDay)
        
        var afterFoodComponents = components
        afterFoodComponents.minute = afterFoodComponents.minute! + dietDuration
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let afterFoodTrigger = UNCalendarNotificationTrigger(dateMatching: afterFoodComponents, repeats: false)
        
        let requestIdentifier = (Keys.notificationIdentifier + food.replacingOccurrences(of: " ", with: ""))
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)

        let afterFoodRequestIdentifier = (Keys.notificationIdentifierAfterFood + food.replacingOccurrences(of: " ", with: ""))
        let afterFoodRequest = UNNotificationRequest(identifier: afterFoodRequestIdentifier, content: afterFoodContent, trigger: afterFoodTrigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        UNUserNotificationCenter.current().add(afterFoodRequest, withCompletionHandler: nil)
    }
    
    func getWeekday(weekDay: String) -> Int {
        
        switch weekDay.lowercased() {
        case Weekdays.sunday.rawValue:
            return 1
        case Weekdays.monday.rawValue:
            return 2
        case Weekdays.tuesday.rawValue:
            return 3
        case Weekdays.wednesday.rawValue:
            return 4
        case Weekdays.thursday.rawValue:
            return 5
        case Weekdays.saturday.rawValue:
            return 6
        case Weekdays.sunday.rawValue:
            return 7
        default:
            return 0
        }
    }
    
    func getTime(time: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.HHmm
        return dateFormatter.date(from: time)
    }
}

