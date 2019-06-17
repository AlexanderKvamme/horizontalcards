//
//  CardController.swift
//  horizontalcards
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit

fileprivate var horizontalCellSpacing: CGFloat = 16

final class CardController: UIViewController {
    
    // MARK: - Properties
    
    var data = ["card one", "card two", "card three", "card four", "card 5", "card 6", "card 7", "card 8", "card 9", "card 10"]
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    // MARK: - Initializers
    
    init() {
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CardCell.estimatedItemSize
        layout.minimumLineSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
    }
    
    private func addSubviewsAndConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
}

extension CardController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CardCell.estimatedItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("data count: ", data.count)
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell for item")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print()
        print("will end and go to ", targetContentOffset.pointee)
        let pointee = targetContentOffset.pointee
        let cardSize = CardCell.estimatedItemSize
        print("card: ", cardSize.width)
        let number = pointee.x / cardSize.width
        print("numer: ", number)
        let roundedNumber = number.rounded()
        print("rounded: ", roundedNumber)
        
        let accumulatedSpacing = roundedNumber*horizontalCellSpacing
        print("accumulatedSpacing: ", accumulatedSpacing)
        let endPosition = roundedNumber*cardSize.width + accumulatedSpacing
        print("would scroll to: ", endPosition)
        targetContentOffset.pointee.x = endPosition
    }
}














final class CardCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let identifier = "Card cell"
    static let estimatedItemSize = CGSize(width: 300, height: 200)
    
    private let label = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        print("init cell")
        
        label.text = "test"
        backgroundColor = .green
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.size.equalTo(CardCell.estimatedItemSize)
            make.edges.equalToSuperview()
        }
        
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    // MARK: - Methods

}

