//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit

class WeatherListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var networkManager: NetworkRouter = NetworkManager()
        // Do any additional setup after loading the view.
        
        
        networkManager.getDataFromApi(type: String.self,
                                           apiCall: .weatherList, postData: nil) { [weak self] (jsonData, error) in
            
        }
    }


}

