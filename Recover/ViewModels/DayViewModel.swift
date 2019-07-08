//
//  DayViewModel.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

protocol DayViewModelable {
    
    func setupCollectionView(_ collectionView: UICollectionView)
    
}

class DayViewModel: NSObject, DayViewModelable {
    
    var day: Day
    
    var intervalSize: TimeInterval = 60 * 30
    
    init(day: Day) {
        self.day = day
    }
    
    
    func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: PeriodCollectionViewLayout.PeriodLine.major.rawValue, withReuseIdentifier: "Reuse")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: PeriodCollectionViewLayout.PeriodLine.minor.rawValue, withReuseIdentifier: "Reuse")
        collectionView.dataSource = self
        collectionView.periodCollectionView?.configuration = PeriodCollectionViewLayout.Configuration(spacing: 10, itemSize: CGSize(width: UIScreen.main.bounds.width, height: 50))
        collectionView.backgroundColor = .white
        collectionView.reloadData()
    }
}

extension DayViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(day.period.duration / intervalSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Reuse", for: indexPath)
        let subview = view.addSubviewOfType()
        subview.backgroundColor = .black
        subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.constrainToViews(leading: subview.leadingAnchor, trailing: subview.trailingAnchor)
        
        switch PeriodCollectionViewLayout.PeriodLine(rawValue: kind) {
        case .major, .center:
            subview.heightAnchor.constraint(equalToConstant: 4).isActive = true
        case .minor:
            subview.heightAnchor.constraint(equalToConstant: 2).isActive = true
        default: break
        }
    
        return view
    }
    
}
