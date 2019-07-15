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
    
    private let headerLabel = UILabel()
    private let valueLabel = UILabel()
    private let mvaLabel = UILabel()
    private let accountLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        headerLabel.text = "test"
        headerLabel.font = UIFont.kolibrix.bold
        headerLabel.textColor = UIColor.solarstein.seashell
        
        valueLabel.font = UIFont.kolibrix.subheader
        valueLabel.textColor =  UIColor.solarstein.seashell
        valueLabel.text = "399 kr"
        
        mvaLabel.font = UIFont(name: "RobotoMono-Bold", size: 16)
        mvaLabel.textColor = UIColor.solarstein.salmon
        mvaLabel.text = "Legg til MVA"
        
        accountLabel.font = UIFont(name: "RobotoMono-Bold", size: 16)
        accountLabel.textColor = UIColor.solarstein.salmon
        accountLabel.text = "Legg til konto"
        
        backgroundColor = UIColor.solarstein.sapphire
        
        contentView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
        }
        
        contentView.addSubview(mvaLabel)
        mvaLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mvaLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(accountLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
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
        headerLabel.text = data
    }
    
    func setFaded(_ b: Bool) {
        alpha = b ? 0.5 : 1
    }
}
