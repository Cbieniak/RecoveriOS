//
//  PlannedPeriodCollectionViewCell.swift
//  Recover
//
//  Created by ChristianBieniak on 10/7/19.
//  Copyright © 2019 BienThere. All rights reserved.
//

import UIKit

class PlannedPeriodCollectionViewCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    var color: UIColor? {
        didSet {
            self.backgroundColor = color
        }
    }
    
    private var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = color
        titleLabel = self.contentView.addSubviewOfType( {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.text = title
            return label
        })
        contentView.constrainToViews(bottom: titleLabel?.bottomAnchor, leading: titleLabel?.leadingAnchor)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title = nil
        color = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
