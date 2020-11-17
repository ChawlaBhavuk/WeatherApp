//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import UIKit
import SVProgressHUD

class WeatherViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: DetailsTableViewCell.self)
            tableView.register(cellClass: WeatherReportTableViewCell.self)
        }
    }
    
    var viewModel: WeatherViewViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.responseHandlerFromViewModal()
        viewModel?.fetchWeatherData()
    }
    
    // MARK: Data handler from view model
    /// handling responses from view model
    private func responseHandlerFromViewModal() {
        
        self.viewModel?.showLoader = {
            SVProgressHUD.show(withStatus: AppLocalization.CommonStrings.loading)
        }
        
        self.viewModel?.removeLoader = {
            SVProgressHUD.dismiss()
        }
        
        viewModel?.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.showErrorAlert = { [weak self] message, apicall in
            DispatchQueue.main.async {
                self?.showErrorAlert(error: message, apicall: apicall)
            }
        }
        
    }
    
    /// showing alert on error
    ///
    /// - Parameter error: title for error
    private func showErrorAlert(error: String, apicall: ApiCall) {
        let alert = UIAlertController(title: AppLocalization.AlertStrings.warning,
                                      message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppLocalization.AlertStrings.retry,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        switch apicall {
                                        case .todayForecast:
                                            self.viewModel?.showLoader?()
                                            self.viewModel?.fetchTodayForecast(params: self.viewModel?.getParams())
                                        case .daysForecast:
                                            self.viewModel?.showLoader?()
                                            self.viewModel?.fetchFieDaysForecast(params: self.viewModel?.getParams())
                                        }
                                      }))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: Tableview implementation
extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        switch viewModel.items[indexPath.row].type {
        case .today:
            if let item = viewModel.items[indexPath.row] as? WeatherViewModelToday {
                let cell: DetailsTableViewCell = tableView.dequeue(cellClass:
                                                                    DetailsTableViewCell.self, forIndexPath: indexPath)
                cell.rightNowView.updateView(weather: item.weather, city: viewModel.pin.title ?? "")
                return cell
            }
            return UITableViewCell()
        case .hourly:
            if let item = viewModel.items[indexPath.row] as? WeatherViewModelHourly {
                let cell: WeatherReportTableViewCell = tableView.dequeue(cellClass:
                                                                            WeatherReportTableViewCell.self,
                                                                         forIndexPath: indexPath)
                cell.daily = nil
                cell.hourly = item.hourly
                cell.collectionView.reloadData()
                return cell
            }
            return UITableViewCell()
            
        case .weekly:
            if let item = viewModel.items[indexPath.row] as? WeatherViewModelWeekly {
                let cell: WeatherReportTableViewCell = tableView.dequeue(cellClass:
                                                                            WeatherReportTableViewCell.self,
                                                                         forIndexPath: indexPath)
                cell.hourly = nil
                cell.daily = item.days
                cell.collectionView.reloadData()
                return cell
            }
            return UITableViewCell()
        }
    }
    
}
