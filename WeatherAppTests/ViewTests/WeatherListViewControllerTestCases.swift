//
//  MovieListViewControllerTestCases.swift
//  WeatherAppTests
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import XCTest
@testable import WeatherApp

class WeatherListViewControllerTestCases: XCTestCase {
    
    var weatherListController: WeatherListViewController? =
        (AppDelegate.delegate()?.window?.rootViewController
            as? UINavigationController)?.viewControllers.first
        as? WeatherListViewController
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testTableViewDelegateConformance() {
        XCTAssertTrue(((weatherListController?.conforms(to: UITableViewDelegate.self)) != nil))
    }
    
    func testTableViewDataSourceConformance() {
        XCTAssertTrue(((weatherListController?.conforms(to: UITableViewDataSource.self)) != nil))
    }
    
    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(weatherListController?.navigationItem.title)
    }
    
    override func tearDownWithError() throws {
        weatherListController = nil
    }
    
}

class MockNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}
