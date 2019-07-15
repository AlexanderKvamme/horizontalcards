//
//  ViewController.swift
//  horizontalcards
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import UIKit
import SnapKit


final class ContactShadowView: UIView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func addShadow(ofSize size: CGSize) {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        let contactRect = CGRect(x: 50, y: 0, width: frame.width-50, height: frame.height)
        layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        layer.shadowRadius = 30
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowColor = UIColor.solarstein.sapphire.cgColor
        layer.shadowOpacity = 0.3
    }
}


class ViewController: UIViewController {

    // MARK: - Properties

    private let cardController = CardController()
    private let cardShadowView = ContactShadowView()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        addSubviewsAndConstraints()
        
        view.backgroundColor = UIColor.solarstein.seashell
        cardShadowView.addShadow(ofSize: CardCell.estimatedItemSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        addChild(cardController)
        view.addSubview(cardController.view)
        cardController.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview()
            make.height.equalTo(CardCell.estimatedItemSize)
        }

        view.addSubview(cardShadowView)
        cardShadowView.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardController.view)
            make.left.equalTo(cardController.view.snp.left).offset(10)
            make.right.equalTo(cardController.view.snp.right).offset(-10)
            make.top.equalTo(cardController.view.snp.top).offset(30)
            make.height.equalTo(6)
        }
        
        view.sendSubviewToBack(cardShadowView)
    }
}

