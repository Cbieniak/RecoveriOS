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

struct Day {
    
    var plans: [Plannable] = []
    
    var date: Date
    
    var period: DateInterval
    
    init(date: Date) throws {
        self.date = date
        guard let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date),
            let end = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date.addingTimeInterval(60 * 60 * 24)) else {
                throw DayError.invalidDate
        }
        self.period = DateInterval(start: start, end: end)
    }
    
}
