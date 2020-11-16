//
//  UITableViewHeader+Extension.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//


import Foundation
import UIKit

extension UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
