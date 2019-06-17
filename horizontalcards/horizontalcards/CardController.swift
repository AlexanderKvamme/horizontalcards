//
//  CardController.swift
//  horizontalcards
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit
import CHIPageControl

final class CardController: UIViewController {
    
    // MARK: - Properties
    
    static var horizontalInsets: CGFloat = 16

    private var data = ["card 0", "card 1", "card 2", "card 3", "card 4", "card 5", "card 6", "card 7", "card 8", "card 9"]
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let pageControl = CHIPageControlAleppo(frame: CGRect(x: 0, y:0, width: 100, height: 20))
    
    private var currentCardIndex = 0
    
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
        
        
        pageControl.numberOfPages = 4
        pageControl.radius = 4
        pageControl.tintColor = UIColor.solarstein.mariner
        pageControl.currentPageTintColor = UIColor.solarstein.sapphire
        pageControl.padding = 6
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        cell.update(with: data[indexPath.row])
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pointee = targetContentOffset.pointee
        let cardSize = CardCell.estimatedItemSize
        let number = pointee.x / cardSize.width
        let newCardIndex = number.rounded()
        print("is this the correct card index? - ", newCardIndex)
        let accumulatedSpacing = (newCardIndex-1)*CardController.horizontalInsets
        let endPosition = newCardIndex*cardSize.width + accumulatedSpacing
        targetContentOffset.pointee.x = endPosition
    
        // NEW
        let newPageIndex = getPageIndexToDisplay(for: Int(newCardIndex), currentCardNumber: currentCardIndex)
        pageControl.set(progress: newPageIndex, animated: true)
        currentCardIndex = Int(newCardIndex)
        print("setting current cardindex to ", currentCardIndex)
        let offset = collectionView.contentOffset
        print("offset: ", offset)
        
    }
    
    // MARK: Helpers
    
    func getPageIndexToDisplay(for newCardNumberIndex: Int, currentCardNumber: Int) -> Int {
        
        // OLD
        
//        let number = offset.x / CardCell.estimatedItemSize.width
//        let roundedNumber = number.rounded()
//        print("got pager index: ", roundedNumber)
//        return Int(roundedNumber)
        
        // NEW

        let attemptedNewPage = min(newCardNumberIndex, pageControl.numberOfPages)
        
        let swipingForward = newCardNumberIndex > currentCardIndex
        let swipingBackward = newCardNumberIndex < currentCardNumber
        let swipingToSame = newCardNumberIndex == currentCardIndex
        
        print()
        print("newCardIndex: ", newCardNumberIndex)
        print("currentCardIndex: ", currentCardIndex)
        
        print("shazam forwards", swipingForward)
        
        if swipingToSame {
            return pageControl.currentPage
        }
        
        if swipingForward {
            if attemptedNewPage >= pageControl.numberOfPages-1 {
                if newCardNumberIndex == data.count-1 {
                    return pageControl.numberOfPages-1
                } else {
                    return pageControl.numberOfPages-2
                }
            }
        } else if swipingBackward {
            if newCardNumberIndex == 0 {
                print("swiping to first")
                return 0
            } else {
                print("bam returning ", min(newCardNumberIndex, 1))
                return min(newCardNumberIndex, 1)
            }
        }
        
        return newCardNumberIndex
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

