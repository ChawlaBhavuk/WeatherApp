//
//  WeatherViewModelItemType.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 17/11/2020.
//
import Foundation

enum WeatherViewModelItemType {
    case today
    case hourly
    case weekly
}

protocol WeatherViewModelItem {
    var type: WeatherViewModelItemType { get }
    var rowCount: Int { get }
}

extension WeatherViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class WeatherViewModelToday: WeatherViewModelItem {
    var type: WeatherViewModelItemType {
        return .today
    }
    
    var weather: Weather
    init(weather: Weather) {
        self.weather = weather
    }
}

class WeatherViewModelHourly: WeatherViewModelItem {
    var type: WeatherViewModelItemType {
        return .hourly
    }
    
    var hourly: [Hourly]
    init(hourly: [Hourly]) {
        self.hourly = hourly
    }
}

class WeatherViewModelWeekly: WeatherViewModelItem {
    var type: WeatherViewModelItemType {
        return .weekly
    }
    var days: [Daily]
    init(days: [Daily]) {
        self.days = days
    }
}
