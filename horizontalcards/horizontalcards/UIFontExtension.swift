//
//  UIFontExtension.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit

// MARK: Interface/API to be used in app

extension UIFont {
    
    // MARK: - Enums
    
    enum kolibrix {
        static let header =     sofia(style: .bold, ofSize: 40)
        static let subheader =  sofia(style: .bold, ofSize: 24)
        static let bold =       sofia(style: .bold, ofSize: 16)
        static let body =       sofia(style: .regular, ofSize: 16)
    }
    
    enum FontWeight: String {
        case regular = "SofiaPro-Regular"
        case bold = "SofiaPro-Bold"
    }
    
    // MARK: Fileprivate helper methods
    
    fileprivate static func sofia(style: FontWeight, ofSize: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: ofSize)!
    }
}
