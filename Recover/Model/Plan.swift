//
//  Plan.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import Foundation

protocol Plannable {}

struct Plan: Plannable {
    
    var title: String

    var duration: TimeInterval
    
    var startTime: Date
}
