//
//  ImageStubCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/13.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ImageStubCell: ImageCell {
    
    override func setupViews() {
        super.setupViews()
        imageView.image = UIImage(named: "addStub")
    }
}
