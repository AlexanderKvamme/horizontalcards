//
//  ViewController.swift
//  horizontalcards
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {

    // MARK: - Properties

    private let cardController = CardController()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.solarstein.seashell
        
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        addChild(cardController)
        view.addSubview(cardController.view)
        cardController.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(CardCell.estimatedItemSize)
        }
    }
}

