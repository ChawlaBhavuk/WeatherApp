//
//  DetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 17/11/2020.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var rightNowView: RightNowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
}
