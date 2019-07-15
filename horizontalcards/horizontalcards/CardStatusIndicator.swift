//
//  CardStatusIndicator.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit

enum CardStatus {
    case yellow
    case red
    case green
}

final class CardStatusIndicator: UIView {
    
    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.solarstein.warningColor
        layer.cornerRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
