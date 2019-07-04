//
//  Optional+Extensions.swift
//  Jumbler
//
//  Created by ChristianBieniak on 17/3/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import Foundation

extension Optional {
    
    func performIfExist<T>(closure: ((Wrapped) -> T)) -> T? {
        self.map { return closure($0) }
    }
}

