//
//  Constant.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/12/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation

struct URLS {
    
    static let url = "https://naviadoctors.com/dummy/"
}

struct Keys {
    
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    static let mealTime = "meal_time"
    static let food = "food"
    static let notificationIdentifier = "notificationIdentifier"
    static let notificationIdentifierAfterFood = "notificationIdentifierAfterFood"
}

struct Message {
    
    static let itsTimeForMeal = "Please take your meal."
    static let enjoyedYourMeal = "I hope you enjoyed your food."
}

struct DateFormat {
    
    static let HHmm = "HH:mm"
}

struct CellIdentifier {
    
    static let headerCell = "headerCell"
    static let cell = "cell"
}
