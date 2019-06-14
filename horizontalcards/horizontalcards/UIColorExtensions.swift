//
//  UIColorExtensions.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    enum solarstein {
        // Loading animation
        static let sMediumBlue = UIColor(hue:0.59, saturation:0.67, brightness:0.84, alpha:1.00)
        static let sLightBlue = UIColor(hue:0.59, saturation:0.52, brightness:0.87, alpha:1.00)
        
        // Kolibrix branding
        static let mariner = UIColor.hex("3E67B1")
        static let poloBlue = UIColor.hex("94AAD3")
        static let seashell = UIColor.hex("FFFCF9")
        static let sapphire = UIColor.hex("0A2049")
        static let salmon = UIColor.hex("FF846A")
        static let mediumSeaGreen = UIColor.hex("2FBF71")
        
        // other
        static let errorColor = UIColor.hex("d6292b")
    }
    
    static func hex(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
