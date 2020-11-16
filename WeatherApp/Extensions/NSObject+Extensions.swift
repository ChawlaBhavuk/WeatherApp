//
//  NSObject+Extensions.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//


import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
