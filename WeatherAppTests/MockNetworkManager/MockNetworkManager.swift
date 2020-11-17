//
//  MockNetworkManager.swift
//  WeatherAppTests
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import Foundation
@testable import WeatherApp

class MockNetworkManager: NetworkRouter {
    func getDataFromApi<T>(type: T.Type, apiCall: ApiCall, postData: [String: Any]?,
                           completion: @escaping ServiceResponse<T>) where T: Decodable {
        if isError {
            completion(nil, "error")
        } else {
            switch apiCall {
            case .daysForecast:
                completion(self.createDailyData() as? T, nil)
            case .todayForecast:
                completion(self.createTodayForecastData() as? T, nil)
            }
        }
    }
    
    var isError = false
    var noMoreResults = false
    
    func createTodayForecastData() -> TodayForecast {
        let today = TodayForecast(coord: Coord(lon: 4, lat: 6),
                                  weather: [Weather(id: 3, main: "ew", weatherDescription: "d", icon: "d")],
                                  base: "d", main: Main(temp: 7, feelsLike: 7, tempMin: 7, tempMax: 7,
                                                        pressure: 7, humidity: 7), visibility: 7,
                                  wind: Wind(speed: 6, deg: 6),
                                  clouds: Clouds(all: 7), dt: 6, sys: Sys(type: 5, id: 5, country: "",
                                                                          sunrise: 6, sunset: 6),
                                  timezone: 7, id: 7, name: "d", cod: 7)
        return today
    }
    
    func createDailyData() -> DaysForecast {
        let daily = DaysForecast(lat: 7, lon: 7, timezone: "",
                                 current: Current(dt: 7, sunrise: 7, sunset: 7, temp: 7, feels_like: 7, pressure: 7,
                                                  humidity: 7, dew_point: 6, uvi: 6,
                                                  clouds: 6, wind_speed: 6, wind_deg: 6,
                                                  weather: [Weather(id: 3, main: "ew",
                                                                    weatherDescription: "d", icon: "d")]),
                                 hourly: [Hourly(dt: 7, temp: 7, feels_like: 7,
                                                 pressure: 7, humidity: 7, dew_point: 7,
                                                 clouds: 7, wind_speed: 7, wind_deg: 7,
                                                 weather: [Weather(id: 3, main: "ew",
                                                                   weatherDescription: "d", icon: "d")])],
                                 daily: [Daily(dt: 4, sunrise: 6, sunset: 6,
                                               temp: Temperature(day: 6, min: 6, max: 6, night: 6, eve: 6, morn: 6),
                                               feels_like: Feels_Like(day: 5, night: 4, eve: 5, morn: 5),
                                               pressure: 5, humidity: 5, dew_point: 5, wind_speed: 5,
                                               wind_deg: 5, weather: [Weather(id: 3, main: "ew",
                                                                              weatherDescription: "d", icon: "d")],
                                               clouds: 5, uvi: 5)])
        
        return daily
    }
}
