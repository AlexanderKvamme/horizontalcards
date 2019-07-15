//
//  CardCell.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit


final class CardCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "Card cell"
    static let estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-CardController.horizontalInsets*2, height: 150)
    
    private let label = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        label.text = "test"
        label.font = UIFont.kolibrix.header
        label.textColor = UIColor.solarstein.seashell
        
        backgroundColor = UIColor.solarstein.sapphire
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.size.equalTo(CardCell.estimatedItemSize)
            make.edges.equalToSuperview()
        }
        
        layer.cornerRadius = 20
        
        alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func update(with data: String) {
        label.text = data
    }
    
    func setFaded(_ b: Bool) {
        alpha = b ? 0.5 : 1
    }
}
