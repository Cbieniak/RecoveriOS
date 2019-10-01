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
    
    func updateScale(_ newScale: CGFloat)
    
}

class DayViewModel: NSObject, DayViewModelable {
    
    var day: Day<EmptyPlan>
    
    var intervalSize: TimeInterval = 60 * 30
    
    private var collectionView: UICollectionView?
    
    init(day: Day<EmptyPlan>) {
        self.day = day
    }
    
    func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(PlannedPeriodCollectionViewCell.self, forCellWithReuseIdentifier: "Full")
        collectionView.register(EmptyPeriodCollectionViewCell.self, forCellWithReuseIdentifier: "Empty")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: "Holder", withReuseIdentifier: "Reuse")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.periodCollectionViewLayout?.configuration = defaultConfiguration()
        collectionView.backgroundColor = .white
        collectionView.reloadData()
        self.collectionView = collectionView
    }
    
    func updateScale(_ newScale: CGFloat) {
        var configuration = defaultConfiguration()
        configuration.scale = newScale.clamped(to: 0.5...2.0)
        collectionView?.periodCollectionViewLayout?.configuration = configuration
        collectionView?.periodCollectionViewLayout?.invalidateLayout()
    }
    
    func defaultConfiguration() -> PeriodCollectionViewLayout.Configuration {
        return PeriodCollectionViewLayout.Configuration(spacing: 2, itemSize: CGSize(width: UIScreen.main.bounds.width, height: 50), scale: 1)
    }
    
    func string(from indexPath: IndexPath) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date(from: indexPath))
    }
    
    func date(from indexPath: IndexPath) -> Date {
        return Calendar.current.startOfDay(for: Date()).addingTimeInterval(Double(indexPath.row) * intervalSize)
    }
    
    func range(from indexPath: IndexPath) -> Range<TimeInterval> {
        let currentRow = TimeInterval(indexPath.row)
        let nextRow = TimeInterval(indexPath.row + 1)
        return (currentRow * intervalSize)..<(nextRow * intervalSize)
    }
    
}

extension DayViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day.allPossiblePeriods().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // switch if empty or full
        let plan = day.periods(for: range(from: indexPath)).first
        
        if plan is EmptyPlannable {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Empty", for: indexPath) as! EmptyPeriodCollectionViewCell
            cell.title = string(from: indexPath)
            return cell
        } else if let plan = plan as? PlannedPlanable {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Full", for: indexPath) as! PlannedPeriodCollectionViewCell
            if plan.startTime == date(from: indexPath) {
                cell.title = plan.title
            }
            
            cell.color = plan.color
            return cell
        }
        fatalError("Cooked")
    }
}

extension DayViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let plan = day.periods(for: range(from: indexPath)).first,
            plan is EmptyPlannable {
            
            if let previousRow = indexPath.previousRow,
                var plannedPeriod = day.plannedPeriods(for: range(from: previousRow)).first {
                plannedPeriod.duration += 60 * 30
                day.blocks.removeAll { (plannable) -> Bool in
                    plannable.range.overlaps(range(from: indexPath))
                }
                day.blocks.append(plannedPeriod)
            } else if let nextRow = indexPath.nextRow,
                var plannedPeriod = day.plannedPeriods(for: range(from: nextRow)).first {
                plannedPeriod.duration += 60 * 30
                plannedPeriod.startTime = date(from: indexPath)
                
                day.blocks.removeAll { (plannable) -> Bool in
                    plannable.range.overlaps(range(from: indexPath))
                }
                day.blocks.append(plannedPeriod)
                
            } else {
                day.blocks.append(Plan(duration: 60 * 30, startTime: date(from: indexPath), title: "Drink", color: UIColor.orange.withAlphaComponent(0.3)))
            }
        } else {
            day.blocks.removeAll { (plannable) -> Bool in
                plannable.range.overlaps(range(from: indexPath))
            }
        }
        collectionView.reloadData()
    }
}

extension Comparable {
    func clamped(to r: ClosedRange<Self>) -> Self {
        let min = r.lowerBound, max = r.upperBound
        return self < min ? min : (max < self ? max : self)
    }
}

extension IndexPath {
    var previousRow: IndexPath? {
        guard self.row > 0 else { return nil }
        return IndexPath(row: self.row - 1, section: self.section)
    }
    
    var nextRow: IndexPath? {
        return IndexPath(row: self.row + 1, section: self.section)
    }
}
