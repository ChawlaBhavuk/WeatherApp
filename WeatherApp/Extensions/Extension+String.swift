//
//  Extension+String.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import UIKit

extension String {
    
    func formattedDetailsString(with font: UIFont, color: UIColor) -> NSAttributedString {
        let str = NSString(string: self)
        let superscriptRange = str.range(of: ".")
        let superscriptFontSize = (font.pointSize / 4) * 5
        let baselineOffset = (font.pointSize - superscriptFontSize) + 20

        let attr: [NSAttributedString.Key: Any] = [.font: font,
                                                   .foregroundColor: color]

        let attributedText = NSMutableAttributedString(string: self, attributes: attr)

        if superscriptRange.length <= 0 {
            return attributedText
        }

        let superscriptFont = font.withSize(superscriptFontSize)
        let superscriptAttr: [NSAttributedString.Key: Any] = [.font: superscriptFont,
                                                              .baselineOffset: baselineOffset,
                                                              .foregroundColor: color]
        attributedText.setAttributes(superscriptAttr, range: superscriptRange)
        return attributedText
    }

}
