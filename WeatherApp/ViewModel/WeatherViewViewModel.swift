//
//  WeatherViewViewModel.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import Foundation

class WeatherViewViewModel {
    var reloadData:(() -> Void)?
    var showLoader:(() -> Void)?
    var removeLoader:(() -> Void)?
    var showErrorAlert: ((String, ApiCall) -> Void)?
    
    var items = [WeatherViewModelItem]()
    var current: Current?
    let pin: MapPin
    var networkManager: NetworkRouter = NetworkManager()
    private let queue = DispatchQueue.global(qos: .background)
    let semaphore = DispatchSemaphore(value: 1)
    init(pin: MapPin) {
        self.pin = pin
    }
    
    func fetchWeatherData() {
        self.showLoader?()
        self.queue.async {
            self.semaphore.wait()
            self.fetchTodayForecast(params: self.getParams())
            self.semaphore.wait()
            self.fetchFieDaysForecast(params: self.getParams())
        }
    }
    
    func getParams() -> [String: String] {
        let params = [AppKeys.lat: String(self.pin.coordinate.latitude),
                      AppKeys.lon: String(self.pin.coordinate.longitude)]
        return params
    }
    
    func fetchTodayForecast(params: [String: String]?) {
        
        networkManager.getDataFromApi(type: TodayForecast.self,
                                      apiCall: .todayForecast,
                                      postData: params) { [weak self] (jsonData, error) in
            guard error == nil || jsonData != nil else {
                self?.removeLoader?()
                self?.showErrorAlert?(AppLocalization.AlertStrings.errorMessage, .todayForecast)
                return
            }
            
            guard let jsonData = jsonData, jsonData.weather.count > 0 else {
                self?.semaphore.signal()
                return
            }
            self?.items.append(WeatherViewModelToday(weather: jsonData.weather[0]))
            self?.semaphore.signal()
        }
    }
    
    func fetchFieDaysForecast(params: [String: String]?) {
        networkManager.getDataFromApi(type: DaysForecast.self,
                                      apiCall: .daysForecast,
                                      postData: params) { [weak self] (jsonData, error) in
            guard error == nil || jsonData != nil else {
                self?.removeLoader?()
                self?.showErrorAlert?(AppLocalization.AlertStrings.errorMessage, .daysForecast)
                return
            }
            guard let jsonData = jsonData else {
                return
            }
            self?.items.append(WeatherViewModelHourly(hourly: jsonData.hourly))
            self?.items.append(WeatherViewModelWeekly(days: jsonData.daily))
            self?.semaphore.signal()
            self?.removeLoader?()
            self?.reloadData?()
        }
    }
}
