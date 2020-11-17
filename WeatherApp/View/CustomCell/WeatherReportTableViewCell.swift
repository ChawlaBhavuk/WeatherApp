//
//  WeatherReportTableViewCell.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import UIKit

class WeatherReportTableViewCell: UITableViewCell {
    
    var hourly: [Hourly]?
    var daily: [Daily]?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellClass: DataCollectionViewCell.self)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
extension WeatherReportTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,
                                      UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let hourly = hourly {
            return hourly.count
        } else  if let daily = daily {
            return daily.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DataCollectionViewCell = collectionView.dequeue(cellClass: DataCollectionViewCell.self,
                                                                  forIndexPath: indexPath)
        if let hourly = hourly {
            cell.updateHours(hourly: hourly[indexPath.row])
        } else  if let daily = daily {
            cell.updateDays(daily: daily[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 121)
    }
}
