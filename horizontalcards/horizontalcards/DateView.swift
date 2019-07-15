//
//  DateLabel.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit


class DateView: UIView {
    
    // MARK: - Properties
    
    private var dayLabel = UILabel()
    private var monthLabel = UILabel()
    
    // MARK: - Initializers
    
    init(day: Int, month: Month) {
        super.init(frame: CGRect.zero)
       
        monthLabel.text = month.rawValue.uppercased()
        
        addSubviewsAndConstraints()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        dayLabel.text = "29"
        dayLabel.textColor = .white
        dayLabel.font = UIFont.kolibrix.header
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.textAlignment = .center
        dayLabel.alpha = 0.3
        
        monthLabel.alpha = 0.3
        monthLabel.textColor = .white
        monthLabel.font = UIFont.kolibrix.bold
        monthLabel.textAlignment = .center
        monthLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func addSubviewsAndConstraints() {
        addSubview(monthLabel)
        addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(monthLabel.snp.top)
        }
        
        monthLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
    }
}

enum Month: String {
    case January = "Jan"
    case September = "Sept"
}
