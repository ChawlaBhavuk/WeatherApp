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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .singleLine
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: LocationTableViewCell.self)
            
        }
    }
    
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
    
    func weatherViewController(pin: MapPin) {
       guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
                                                                                    WeatherViewController.className
       ) as? WeatherViewController else {
               return
       }
       self.navigationController?.pushViewController(newViewController, animated: true)
   }

    @IBAction func addLocationClicked(_ sender: UIBarButtonItem) {
        guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
                                                                                    SelectLocationViewController.className
        )
                as? SelectLocationViewController else {
            return
        }
        newViewController.delegate = self
        self.present(newViewController, animated: true, completion: nil)
    }
}

// MARK: Tableview implementation
extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationTableViewCell = tableView.dequeue(cellClass:
                                                                LocationTableViewCell.self, forIndexPath: indexPath)
        cell.item = pins[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.weatherViewController(pin: pins[indexPath.row])
    }
    
}

extension WeatherListViewController: LocationData {
    func getLocation(pin: MapPin) {
        pins.append(pin)
        tableView.reloadData()
    }
}

protocol LocationData: AnyObject {
    func getLocation(pin: MapPin)
}
