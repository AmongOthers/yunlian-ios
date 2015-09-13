//
//  ImageCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/12.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.backgroundColor = UIConstants.BackgroundGray
        imageView.contentMode = UIViewContentMode.ScaleToFill
    }
    
    func setupConstraints() {
        imageView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
    }
}
