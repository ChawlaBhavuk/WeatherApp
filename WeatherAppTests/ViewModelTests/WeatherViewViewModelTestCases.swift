//
//  MovieDetailViewModelTestCases.swift
//  WeatherAppTests
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import XCTest
import MapKit
@testable import WeatherApp

class WeatherViewViewModelTestCases: XCTestCase {
    
    var viewModel: WeatherViewViewModel!
    var mockNetworkManager: MockNetworkManager!
    override func setUp() {
        viewModel = WeatherViewViewModel(pin: MapPin(title: "test", locationName: "test",
                                                     coordinate: CLLocationCoordinate2DMake(0, 0), currentTime: "rf"))
        mockNetworkManager = MockNetworkManager()
        viewModel.networkManager = mockNetworkManager
        
    }
    
    /// For mocking data of Today ForeCasr
    func testFetchTodayForecast() {
        viewModel.items.removeAll()
        self.viewModel.fetchTodayForecast(params: viewModel.getParams())
        XCTAssertNotNil(viewModel.items[0] as? WeatherViewModelToday)
    }
    
    /// For mocking data of days data
    func testfetchFieDaysForecasta() {
        viewModel.items.removeAll()
        self.viewModel.fetchFieDaysForecast(params: viewModel.getParams())
        XCTAssertNotNil(viewModel.items[0] as? WeatherViewModelHourly)
        XCTAssertNotNil(viewModel.items[1] as? WeatherViewModelWeekly)
    }
    
}
