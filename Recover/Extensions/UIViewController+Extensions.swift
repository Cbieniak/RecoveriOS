//
//  UIViewController+Extensions.swift
//  Jumbler
//
//  Created by ChristianBieniak on 17/3/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildViewController(childVC: UIViewController) {
        addChild(childVC)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
