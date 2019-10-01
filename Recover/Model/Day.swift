//
//  Day.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import Foundation

enum DayError: Error {
    case invalidDate
}

protocol TimePeriod {}

struct Day<T: EmptyPlannable> {
    
    var plans: [Plannable] = []
    
    var date: Date
    
    var period: DateInterval
    
    var blocks: [Plannable] = []
    
    var intervalSize: TimeInterval = 60 * 30 {
        didSet {
            calcBlocks()
        }
    }
    
    let dayLength: TimeInterval = 86400
    
    var numberOfSections: TimeInterval {
        return dayLength / intervalSize
    }
    
    init(date: Date) throws {
        self.date = date
        guard let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date),
            let end = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date.addingTimeInterval(60 * 60 * 24)) else {
                throw DayError.invalidDate
        }
        self.period = DateInterval(start: start, end: end)
        
        calcBlocks()
    }
    
    // method that calculates all possible blocks.
    mutating func calcBlocks() {
        
    }
    // each day is
    
    func allPossiblePeriods() -> [Plannable] {
        var periods = [Plannable]()
        var baseValue = 0.0
        for divider in 1...Int(numberOfSections) {
            let doubleDivider = Double(divider)
            let periodRange = baseValue..<(intervalSize * doubleDivider)
            
            let item = plannedPeriods(for: periodRange).first ?? T(range: periodRange)
            periods.append(item)
            baseValue = periodRange.upperBound
        }
        return periods
    }
    
    func plannedPeriods(for range: Range<Double>) -> [Plannable] {
        return blocks.filter {
            range.overlaps($0.range)
        }
    }
    
    func periods(for range: Range<Double>) -> [Plannable] {
        return allPossiblePeriods().filter {
            range.overlaps($0.range)
        }
    }
}

extension Plannable {
    var range: Range<TimeInterval> {
        let timeInterval = startTime.timeIntervalSince(Calendar.current.startOfDay(for: startTime))
        return timeInterval..<(timeInterval + duration)
    }
}


