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
        collectionView.dataSource = self
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
    
}
