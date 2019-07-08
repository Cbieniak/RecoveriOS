//
//  PeriodCollectionViewLayout.swift
//  Recover
//
//  Created by ChristianBieniak on 7/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit



class PeriodCollectionViewLayout: UICollectionViewLayout {
    
    enum PeriodLine: String {
        case center
        case major
        case minor
    
        
        var next: PeriodLine {
            switch self {
            case .center, .major:
                return .minor
            case .minor:
                return .major
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 1000)
    }

    var suppCache: [UICollectionViewLayoutAttributes] = []
    var cache: [UICollectionViewLayoutAttributes] = []
    
    var scale: CGFloat = 1.0
    
    var configuration: Configuration!
    
    lazy var gestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(adjustZoom(recognizer:)))

    var initial = PeriodLine.minor
    override func prepare() {
        guard let collectionView = collectionView else { return }
        var yAmount: CGFloat = 0
        if !(collectionView.gestureRecognizers ?? []).contains(gestureRecognizer) {
            collectionView.addGestureRecognizer(gestureRecognizer)
        }
        
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            var scaledItemSize = configuration.itemSize
            scaledItemSize.height *= scale
            attributes.frame = CGRect(origin: CGPoint(x: 0, y: yAmount), size: scaledItemSize)
            cache.append(attributes)
            yAmount = attributes.frame.maxY + configuration.spacing
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        for attributes in suppCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return suppCache[indexPath.item]
    }
    
    @objc func adjustZoom(recognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            self.scale *= gestureRecognizer.scale
            gestureRecognizer.scale = 1.0
            cache = []
            suppCache = []
            invalidateLayout()
        }
    }

}

extension PeriodCollectionViewLayout {
    struct Configuration {
        let spacing: CGFloat
        let itemSize: CGSize
    }
}

extension UICollectionView {
    var periodCollectionView: PeriodCollectionViewLayout? {
        return self.collectionViewLayout as? PeriodCollectionViewLayout
    }
}

extension UICollectionViewLayoutAttributes {
    convenience init(periodLine: PeriodCollectionViewLayout.PeriodLine, with indexPath: IndexPath) {
        self.init(forSupplementaryViewOfKind: periodLine.rawValue, with: indexPath)
    }
}
