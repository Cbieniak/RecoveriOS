//
//  ViewController.swift
//  Recover
//
//  Created by ChristianBieniak on 4/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

class DayViewController<T: DayViewModelable>: UIViewController {
    
    var viewModel: T
    
    lazy var collectionView = configureCollectionView()
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupCollectionView(collectionView)
    }

    func configureCollectionView() -> UICollectionView {
        let collectionView = view.addSubviewOfType { return UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) }
        view.constrainToViews(all: collectionView)
        return collectionView
    }

}

