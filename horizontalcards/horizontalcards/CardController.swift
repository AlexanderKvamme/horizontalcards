//
//  CardController.swift
//  horizontalcards
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit


final class CardController: UIViewController {
    
    // MARK: - Properties
    
    static var horizontalInsets: CGFloat = 16

    private var data = ["card one", "card two", "card three", "card four", "card 5", "card 6", "card 7", "card 8", "card 9", "card 10"]
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let pageControl = UIPageControl()
    
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
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: CardController.horizontalInsets, bottom: 0, right: -CardController.horizontalInsets)
        
        pageControl.backgroundColor = .green
        pageControl.currentPage = 2
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .blue
        pageControl.numberOfPages = 4
    }
    
    private func addSubviewsAndConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

extension CardController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CardCell.estimatedItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("data count: ", data.count)
        collectionView.contentInset.right = CGFloat(data.count-1) * 8
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell for item")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        cell.update(with: data[indexPath.row])
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
        
        let accumulatedSpacing = (roundedNumber-1)*CardController.horizontalInsets
        print("accumulatedSpacing: ", accumulatedSpacing)
        let endPosition = roundedNumber*cardSize.width + accumulatedSpacing
        print("would scroll to: ", endPosition)
        targetContentOffset.pointee.x = endPosition
        
        print("page number: ", Int(roundedNumber))
        print("velocity: ", velocity)
        pageControl.currentPage = Int(roundedNumber)
    }
}


final class CardCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let identifier = "Card cell"
    static let estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-CardController.horizontalInsets*2, height: 100)
    
    private let label = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        label.text = "test"
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func update(with data: String) {
        label.text = data
    }
}

