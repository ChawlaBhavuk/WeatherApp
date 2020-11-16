//
//  MapPin.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let currentTime: String
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, currentTime: String) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.currentTime = currentTime
    }
}
