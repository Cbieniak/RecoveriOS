//
//  DayViewModel.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import Foundation

protocol DayViewModelable {}

struct DayViewModel: DayViewModelable {
    
    var day: Day
    
    init(day: Day) {
        self.day = day
    }
}
