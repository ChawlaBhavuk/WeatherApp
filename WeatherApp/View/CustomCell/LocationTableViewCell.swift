//
//  LocationTableViewCell.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.applyGradient(colours: [UIColor.blue, UIColor.white])
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var item: MapPin? {
        didSet {
            guard let item = item else {
                return
            }
            timeLabel.text = item.currentTime
            locationLabel.text = item.title
            tempLabel.text = "\(String(Int.random(in: 10..<50)))°"
            self.bringSubviewToFront(baseView)
        }
    }
    
}
