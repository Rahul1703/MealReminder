//
//  DietModel.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/11/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation

struct DietModel: Codable {
    let dietDuration: Int?
    let weekDietData: WeekDietData?
    
    enum CodingKeys: String, CodingKey {
        case dietDuration = "diet_duration"
        case weekDietData = "week_diet_data"
    }
}

struct WeekDietData: Codable {
    let thursday, wednesday, monday: [Day]?
}

struct Day: Codable {
    let food, mealTime: String?
    
    enum CodingKeys: String, CodingKey {
        case food
        case mealTime = "meal_time"
    }
}
