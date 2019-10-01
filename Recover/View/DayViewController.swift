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
    
    private var scale: CGFloat = 1.0
    
    lazy var collectionView = configureCollectionView()
    
    lazy var gestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(adjustZoom(recognizer:)))

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    func configureCollectionView() -> UICollectionView {
        let collectionView = view.addSubviewOfType { return UICollectionView(frame: .zero, collectionViewLayout: PeriodCollectionViewLayout()) }
        gestureRecognizer.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(gestureRecognizer)
        view.constrainToViews(all: collectionView)
        return collectionView
    }
    
    @objc func adjustZoom(recognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            self.scale *= gestureRecognizer.scale
            gestureRecognizer.scale = 1.0
            viewModel.updateScale(scale)
            collectionView.periodCollectionViewLayout?.reset()
        }
    }
    
    

}

