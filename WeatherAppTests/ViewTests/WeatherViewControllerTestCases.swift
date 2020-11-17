//
//  MovieDetailViewControllerTestCases.swift
//  WeatherAppTests
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import XCTest
@testable import WeatherApp

class WeatherViewControllerTestCases: XCTestCase {
    var weatherViewController: WeatherViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        weatherViewController = storyboard.instantiateViewController(withIdentifier:
                                                                            WeatherViewController.className)
            as? WeatherViewController
        weatherViewController.loadViewIfNeeded()
    }
    
    func testTableViewDelegateConformance() {
        XCTAssertTrue(weatherViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewDataSourceConformance() {
        XCTAssertTrue(weatherViewController.conforms(to: UITableViewDataSource.self))
    }
    
    override func tearDownWithError() throws {
        weatherViewController = nil
    }
}
