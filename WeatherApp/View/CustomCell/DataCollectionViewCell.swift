//
//  DataCollectionViewCell.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var image: CustomImage!
    @IBOutlet weak var topLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateHours(hourly: Hourly) {
        let date = Date(timeIntervalSince1970: Double(hourly.dt))
        let hourString = self.getHourFrom(date: date)
        let weatherIconName = hourly.weather[0].icon
        let weatherTemperature = hourly.temp
        
        topLabel.text = hourString
        image.image = UIImage(named: weatherIconName)
        bottomLabel.text = "\(Int(weatherTemperature.rounded()))°F"
        
    }
    
    func updateDays(daily: Daily) {
        let date = Date(timeIntervalSince1970: Double(daily.dt))
        let dayString = self.getDayOfWeekFrom(date: date)
        let weatherIconName = daily.weather[0].icon
        let weatherTemperature = daily.temp.day
        
        topLabel.text = dayString
        image.image = UIImage(named: weatherIconName)
        bottomLabel.text = "\(Int(weatherTemperature.rounded()))°F"
    }
    
    func getHourFrom(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        var string = dateFormatter.string(from: date)
        if string.last == "M" {
            string = String(string.prefix(string.count - 3))
        }
        return string
    }
    
    func getDayOfWeekFrom(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        var string = dateFormatter.string(from: date)
        if let index = string.firstIndex(of: ",") {
            string = String(string.prefix(upTo: index))
            return string
        }
        return "error"
    }
    
}
