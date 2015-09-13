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
    weak var photoDelegate: PhotoDelegate?
    let offsetUnit: CGFloat
    
    init(frame: CGRect, imageArray: [UIImage], currentPageNumber: Int = 0) {
        self.imageArray = imageArray
        zoomablePhotoViews = [ZoomablePhotoView]()
        self.currentPageNumber = currentPageNumber
        let biggerFrame = CGRect(origin: frame.origin, size: CGSizeMake(frame.width + UX.PhotoGap, frame.height))
        offsetUnit = biggerFrame.width
        super.init(frame: biggerFrame)
        var i: CGFloat = 0
        for image in imageArray {
            let origin = CGPointMake(i * (biggerFrame.width - UX.PhotoGap + UX.PhotoGap), 0)
            let size = CGSizeMake(biggerFrame.width - UX.PhotoGap, biggerFrame.height)
            let zoomablePhotoView = ZoomablePhotoView(picture: image, frame: CGRect(origin: origin, size: size))
            addSubview(zoomablePhotoView)
            zoomablePhotoView.photoDelegate = self
            zoomablePhotoViews?.append(zoomablePhotoView)
            i++
        }
        bounces = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        pagingEnabled = true
        contentSize = CGSizeMake(CGFloat(imageArray.count) * biggerFrame.width + CGFloat(imageArray.count - 1) * UX.PhotoGap , biggerFrame.height)
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

extension PhotoScrollView: PhotoDelegate {
    func tapped() {
        photoDelegate?.tapped()
    }
}