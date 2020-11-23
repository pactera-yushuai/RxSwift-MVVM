//
//  YMTBaseColletionCell.swift
//  Yamoto
//
//  Created by pactera on 2020/11/5.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit

class YMTBaseColletionCell: UICollectionViewCell {
    
    open lazy var contentLabel = {()->UILabel in
        let lab = UILabel()
        return lab
    }()
    open  lazy var iconImage = { ()-> UIImageView in
        let image = UIImageView()
        return image
    }()
    open  lazy var titleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        return lab
    }()
    open   lazy var priceLabel = {()->UILabel in
        let lab = UILabel()
        return lab
    }()
    open  lazy var paymentLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .left
        return lab
    }()
    open  lazy var activitiesLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout() {}
}
