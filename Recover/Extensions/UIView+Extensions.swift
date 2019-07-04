//
//  UIView+Extensions.swift
//  Jumbler
//
//  Created by ChristianBieniak on 17/3/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

extension UIView {
    
    func constrainToViews(top: NSLayoutYAxisAnchor? = nil,
                          bottom: NSLayoutYAxisAnchor? = nil,
                          leading: NSLayoutXAxisAnchor? = nil,
                          trailing: NSLayoutXAxisAnchor? = nil) {
        top.performIfExist { return self.topAnchor.constraint(equalTo: $0) }?.isActive = true
        bottom.performIfExist { return self.bottomAnchor.constraint(equalTo: $0) }?.isActive = true
        leading.performIfExist { return self.leadingAnchor.constraint(equalTo: $0) }?.isActive = true
        trailing.performIfExist { return self.trailingAnchor.constraint(equalTo: $0) }?.isActive = true
    }
    
    func constrainToViews(all: UIView?) {
        constrainToViews(top: all?.topAnchor,
                         bottom: all?.bottomAnchor,
                         leading: all?.leadingAnchor,
                         trailing: all?.trailingAnchor)
    }
    
    func addSubviewOfType<T: UIView>(_ createClosure: (() -> T) = { T() }) -> T {
        let subview = createClosure()
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        return subview
    }
    
}
