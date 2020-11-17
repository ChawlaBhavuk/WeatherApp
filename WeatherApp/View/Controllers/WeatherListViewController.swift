//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var pins = [MapPin]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: LocationTableViewCell.self)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
    }
    
    func reloadData() {
        if pins.count > 0 {
            tableView.resetBackgroundView()
        } else {
            tableView.setEmptyView(title: AppLocalization.CommonStrings.noData,
                                   message: AppLocalization.CommonStrings.addData)
        }
        tableView.reloadData()
    }
    
    func weatherViewController(pin: MapPin) {
       guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
                                                                                    WeatherViewController.className
       ) as? WeatherViewController else {
               return
       }
        let viewModel = WeatherViewViewModel(pin: pin)
        newViewController.viewModel = viewModel
        self.present(newViewController, animated: true, completion: nil)
   }

    @IBAction func addLocationClicked(_ sender: UIBarButtonItem) {
        guard let newViewController = self.storyboard?.instantiateViewController(withIdentifier:
                                                                                    SelectLocationViewController
                                                                                    .className)
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
        self.reloadData()
    }
}

protocol LocationData: AnyObject {
    func getLocation(pin: MapPin)
}
