//
//  AppEndPoint.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit

struct EndPointType {
    var baseURL: URL
    var httpMethod: HTTPMethod
    var params: Data?
    
    init(baseURL: URL, httpMethod: HTTPMethod = .get, params: [String: Any]? = nil) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        if let params = params {
            self.params = try? JSONSerialization.data(withJSONObject: params)
        } else {
            self.params = nil
        }
        
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "Delete"
}

struct APIEndPoint {
    static let baseUrl = "http://api.openweathermap.org/"
    static let apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    static let image = "https://image.tmdb.org/t/p/"
}
