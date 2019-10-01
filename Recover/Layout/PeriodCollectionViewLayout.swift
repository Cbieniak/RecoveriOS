//
//  PeriodCollectionViewLayout.swift
//  Recover
//
//  Created by ChristianBieniak on 7/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit


// A layout that contains a list of potential locations that cells can sit in.
class PeriodCollectionViewLayout: UICollectionViewLayout {
    
    override var collectionViewContentSize: CGSize {
        if let collectionView = self.collectionView {
            let numberOfItems = collectionView.numberOfItems(inSection: 0)
            let itemSizeHeight = (self.configuration.itemSize.height * scale) + self.configuration.spacing
            let calculatedHeight = (CGFloat(numberOfItems) * itemSizeHeight)
            return CGSize(width: collectionView.bounds.width, height: calculatedHeight)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 1000)
    }

    var cellCache: [UICollectionViewLayoutAttributes] = []
    
    var scale: CGFloat {
        return configuration.scale
    }
    
    var configuration: Configuration!
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        var yAmount: CGFloat = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            var scaledItemSize = configuration.itemSize
            scaledItemSize.height *= scale
            attributes.frame = CGRect(origin: CGPoint(x: 0, y: yAmount), size: scaledItemSize)
            cellCache.append(attributes)
            
            yAmount = attributes.frame.maxY + configuration.spacing
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        let attributesCollection = cellCache
        // Loop through the cache and look for items in the rect
        for attributes in attributesCollection {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellCache[indexPath.item]
    }
    
    
    func reset() {
        cellCache = []
        invalidateLayout()
    }

}

extension PeriodCollectionViewLayout {
    struct Configuration {
        let spacing: CGFloat
        let itemSize: CGSize
        var scale: CGFloat
        
    }
}

extension UICollectionView {
    var periodCollectionViewLayout: PeriodCollectionViewLayout? {
        return self.collectionViewLayout as? PeriodCollectionViewLayout
    }
}
