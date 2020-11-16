//
//  UItableViewCell+Extension.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
