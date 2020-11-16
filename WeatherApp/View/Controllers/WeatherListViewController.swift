//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var pins = [MapPin]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var networkManager: NetworkRouter = NetworkManager()
        //         Do any additional setup after loading the view.
        //
        //
        //        networkManager.getDataFromApi(type: String.self,
        //                                           apiCall: .weatherList, postData: nil) { [weak self] (jsonData, error) in
        //
        //        }
        
    }
    
    
    
    @IBAction func addLocationClicked(_ sender: UIBarButtonItem) {
        guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
                                                                                    SelectLocationViewController.className)
                as? SelectLocationViewController else {
            return
        }
        newViewController.delegate = self
        self.present(newViewController, animated: true, completion: nil)
    }
}

extension WeatherListViewController: LocationData {
    func getLocation(pin: MapPin) {
        pins.append(pin)
    }
}

protocol LocationData: AnyObject {
    func getLocation(pin: MapPin)
}

