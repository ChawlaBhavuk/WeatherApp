//
//  SelectLocationViewController.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit
import MapKit

class SelectLocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    weak var delegate: LocationData?
    private var pin: MapPin?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
    }
    
    func setUpMapView() {
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let location = gestureRecognizer.location(in: mapView)
        
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        self.setPinUsingMKAnnotation(location: coordinate)
    }
    
    @IBAction private func confirmClicked(_ sender: UIButton) {
        guard let pin = pin else {
            return
        }
        self.mapView.removeFromSuperview()
        delegate?.getLocation(pin: pin)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getLocationName(location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, _) in
            var locationName = ""
            guard let placemarksArray = placemarksArray, placemarksArray.count > 0 else {
                completion("Device Location")
                return
            }
            let placemark = placemarksArray.first
            locationName =  placemark?.administrativeArea ?? "Device Location"
            
            completion(locationName)
        }
    }
    
     func time() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour): \(minutes)"
    }
    
}

extension SelectLocationViewController: MKMapViewDelegate {
    
    func setPinUsingMKAnnotation(location: CLLocationCoordinate2D) {
        self.getLocationName(location: CLLocation(latitude: location.latitude,
                                                  longitude: location.longitude)) { [weak self]  (locationName) in
            let pin1 = MapPin(title: locationName, locationName: locationName,
                              coordinate: location, currentTime: self?.time() ?? "")
            self?.pin = pin1
            let coordinateRegion = MKCoordinateRegion(center: pin1.coordinate,
                                                      latitudinalMeters: 800, longitudinalMeters: 800)
            self?.mapView.setRegion(coordinateRegion, animated: true)
            self?.mapView.addAnnotations([pin1])
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "Pin"
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ??
            MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        annotationView.canShowCallout = true
        if #available(iOS 11.0, *) {
            annotationView.clusteringIdentifier = "PinCluster"
        } else {
            // Fallback on earlier versions
        }
        
        if annotation is MKUserLocation {
            return nil
        } else if annotation is MapPin {
            annotationView.image =  UIImage(imageLiteralResourceName: "pin")
            return annotationView
        } else {
            return nil
        }
    }
}
