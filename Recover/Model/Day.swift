//
//  Day.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import Foundation

protocol TimePeriod {}

struct Day {
    
    var plans: [Plannable] = []
    
    var date: Date
    
}
