//
//  SelectLocationViewControllerTestCases.swift
//  WeatherAppTests
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import XCTest
import MapKit
@testable import WeatherApp

class SelectLocationViewControllerTestCases: XCTestCase {
    var weatherViewController: SelectLocationViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        weatherViewController = storyboard.instantiateViewController(withIdentifier:
                                                                        SelectLocationViewController.className)
            as? SelectLocationViewController
        weatherViewController.loadViewIfNeeded()
    }
    
    func testMapConformance() {
        XCTAssertTrue(weatherViewController.conforms(to: MKMapViewDelegate.self))
    }
    
    func testdate() {
        XCTAssertNotNil(weatherViewController.time())
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
