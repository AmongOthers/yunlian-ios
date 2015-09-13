//
//  PhotoScrollView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/10.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class PhotoScrollView: UIScrollView {
    struct UX {
        static let PhotoGap: CGFloat = 20.0
    }
    
    var imageArray: [UIImage]?
    var zoomablePhotoViews: [ZoomablePhotoView]?
    var currentPageNumber: Int!
    let offsetUnit: CGFloat
    
    init(frame: CGRect, imageArray: [UIImage], currentPageNumber: Int = 0) {
        self.imageArray = imageArray
        zoomablePhotoViews = [ZoomablePhotoView]()
        self.currentPageNumber = currentPageNumber
        offsetUnit = frame.width
        super.init(frame: frame)
        var i: CGFloat = 0
        for image in imageArray {
            let origin = CGPointMake(i * (frame.width - UX.PhotoGap + UX.PhotoGap), 0)
            let size = CGSizeMake(frame.width - UX.PhotoGap, frame.height)
            let zoomablePhotoView = ZoomablePhotoView(picture: image, frame: CGRect(origin: origin, size: size))
            addSubview(zoomablePhotoView)
            zoomablePhotoViews?.append(zoomablePhotoView)
            i++
        }
        bounces = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        pagingEnabled = true
        contentSize = CGSizeMake(CGFloat(imageArray.count) * frame.width + CGFloat(imageArray.count - 1) * UX.PhotoGap , frame.height)
        delegate = self
        
        contentOffset = CGPointMake(offsetUnit * CGFloat(currentPageNumber), 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func currentZoomablePhotoView() -> ZoomablePhotoView? {
        return zoomablePhotoViews?[currentPageNumber]
    }
}

extension PhotoScrollView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = contentOffset.x / offsetUnit
        let number = Int(pageNumber)
        if number != currentPageNumber {
            print("changeNumber to \(number) from \(currentPageNumber)")
            currentZoomablePhotoView()?.clearZoom()
            currentPageNumber = number
        }
    }
}