//
//  NetworkRequest.swift
//  WeatherAppTests
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import Foundation
import XCTest
@testable import WeatherApp

class ServiceManagerTests: XCTestCase {
    
    let host = "api.openweathermap.org"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testValidMoviesResponse() {
        testMoviesListWithValidResponseForURL(host: host, fileName: "SuccessResponse.json")
    }
    
    func testInValidMoviesResponse() {
        testMoviesListWithInValidResponseForURL(host: host, fileName: "FailureResponse.json")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension ServiceManagerTests {
    
    func testMoviesListWithValidResponseForURL(host: String, fileName: String) {
        
        XCHttpStub.request(path: host, responseFile: fileName)
        let resultExpectation = expectation(description: "Invalid Json")
        
        let networkManager: NetworkRouter = NetworkManager()
        networkManager.getDataFromApi(type: TodayForecast.self,
                                      apiCall: .todayForecast, postData: nil) { (jsonData, _) in
            XCTAssertNotNil(jsonData?.weather)
            XCTAssert(jsonData?.weather.count ?? 0 > 0)
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTAssertNotNil(error, "Request timed out")
            }
        }
    }
    
    func testMoviesListWithInValidResponseForURL(host: String, fileName: String) {
        
        XCHttpStub.request(path: host, responseFile: fileName)
        let resultExpectation = expectation(description: "Expected Movies Items")
        
        let networkManager: NetworkRouter = NetworkManager()
        networkManager.getDataFromApi(type: TodayForecast.self,
                                      apiCall: .todayForecast, postData: nil) { (_, error) in
            XCTAssertNotNil(error, "Expectation fulfilled with error")
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTAssertNotNil(error, "Request timed out")
            }
        }
    }
}
