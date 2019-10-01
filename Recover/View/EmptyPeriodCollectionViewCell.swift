//
//  EmptyPeriodCollectionViewCell.swift
//  Recover
//
//  Created by ChristianBieniak on 8/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

class EmptyPeriodCollectionViewCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    private var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        titleLabel = self.contentView.addSubviewOfType( {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.text = title
            return label
        })
        contentView.constrainToViews(bottom: titleLabel?.bottomAnchor, leading: titleLabel?.leadingAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
