//
//  Plan.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

protocol Plannable {
    var id: UUID { get }
    var duration: TimeInterval { get set }
    var startTime: Date { get set }
    init()
}

extension Plannable {
    
    init(range: Range<TimeInterval>, on day: Date = Date()) {
        self.init()
        self.duration = range.upperBound - range.lowerBound
        self.startTime = Calendar.current.startOfDay(for: day).addingTimeInterval(range.lowerBound)
    }
}

protocol EmptyPlannable: Plannable {
    
}

protocol PlannedPlanable: Plannable {
    
    
    
    var title: String { get set }
    
    var color: UIColor { get }
}

struct Plan: PlannedPlanable {
    
    var id: UUID = UUID()
    
    var duration: TimeInterval
    
    var startTime: Date
    
    var title: String
    
    var color: UIColor
    
    init() {
        duration = 0
        startTime = Date()
        title = ""
        color = .black
    }
    
    init(duration: TimeInterval, startTime: Date, title: String, color: UIColor) {
        self.duration = duration
        self.startTime = startTime
        self.title = title
        self.color = color
    }
}

struct EmptyPlan: EmptyPlannable {
    
    var id: UUID = UUID()
    
    var duration: TimeInterval
    
    var startTime: Date
    
    init() {
        duration = 0
        startTime = Date()
    }
}
