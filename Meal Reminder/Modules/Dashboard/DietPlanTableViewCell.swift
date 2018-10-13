//
//  DietPlanTableViewCell.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/12/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import UIKit

class DietPlanTableViewCell: UITableViewCell {

    @IBOutlet weak var dietTimingImageView: UIImageView!
    @IBOutlet weak var dietNameLabel: UILabel!
    @IBOutlet weak var dietTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDataforCell(day: Day) {
        
        //dietTimingImageView.image = getTimeImage(mealTime: day.mealTime!)
        dietNameLabel.text = day.food
        dietTimeLabel.text = day.mealTime
    }
    
    func setDataforCell(day: [String : Any]) {
        
        dietTimingImageView.image = getTimeImage(mealTime: (day[Keys.mealTime] as? String)!) ?? #imageLiteral(resourceName: "morning")
        dietNameLabel.text = (day[Keys.food] as? String)?.capitalizingFirstLetter()
        dietTimeLabel.text = day[Keys.mealTime] as? String
    }
    
    func getTimeImage(mealTime: String) -> UIImage? {
        
        var image: UIImage?
        
        //date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.HHmm
        let mealDate = dateFormatter.date(from: mealTime)
        
        //Times array
        let startTimes = ["23:55", //Morning
            "11:00", //Aftenoon
            "17:00", //Evening
            "20:00" //Nigth
        ]
        
        let morning = 0
        let afternoon = 1
        let evening = 2
        let night = 3
        
        var dateTimes = [Date]()
        
        //create an array with the desired times
        for i in 0..<startTimes.count{
            let dateTime = dateFormatter.date(from: startTimes[i])
            dateTimes.append(dateTime!)
        }
        
        if mealDate! < dateTimes[afternoon]   {
            image = #imageLiteral(resourceName: "morning")
        }
        else if mealDate! < dateTimes[evening]   {
            image = #imageLiteral(resourceName: "afternoon")
        }
        else if mealDate! < dateTimes[night]   {
            image = #imageLiteral(resourceName: "evening")
        } else if mealDate! < dateTimes[morning]   {
            image = #imageLiteral(resourceName: "moon")
        }
        
        return image
    }
}
