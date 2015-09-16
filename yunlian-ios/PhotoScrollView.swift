//
//  PhotoScrollView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/10.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

@objc protocol PhotoScrollViewDelegate {
    func tapped()
    func pageChanged(current: Int, total: Int)
}

class PhotoScrollView: UIScrollView {
    struct UX {
        static let PhotoGap: CGFloat = 20.0
    }
    
    var biggerFrame: CGRect!
    var imageArray: [UIImage]?
    var zoomablePhotoViews: [ZoomablePhotoView]?
    var currentPageNumber: Int!
    weak var photoDelegate: PhotoScrollViewDelegate?
    let offsetUnit: CGFloat
    
    init(frame: CGRect, imageArray: [UIImage], currentPageNumber: Int = 0) {
        self.imageArray = imageArray
        zoomablePhotoViews = [ZoomablePhotoView]()
        self.currentPageNumber = currentPageNumber
        biggerFrame = CGRect(origin: frame.origin, size: CGSizeMake(frame.width + UX.PhotoGap, frame.height))
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
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "tapZoom:")
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        let tap = UITapGestureRecognizer(target: self, action: "tap:")
        tap.numberOfTapsRequired = 1
        tap.requireGestureRecognizerToFail(doubleTap)
        addGestureRecognizer(tap)
    }
    
    func tap(recognizer: UITapGestureRecognizer) {
        photoDelegate?.tapped()
    }
    
    func tapZoom(recognizer: UITapGestureRecognizer) {
        currentZoomablePhotoView()?.tapZoom(recognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func currentZoomablePhotoView() -> ZoomablePhotoView? {
        return zoomablePhotoViews?[currentPageNumber]
    }
    
    func deleteCurrentPage() {
        let isLast = currentPageNumber == imageArray!.count - 1
        imageArray?.removeAtIndex(currentPageNumber)
        zoomablePhotoViews?[currentPageNumber].removeFromSuperview()
        zoomablePhotoViews?.removeAtIndex(currentPageNumber)
        contentSize = CGSizeMake(CGFloat(imageArray!.count) * biggerFrame.width + CGFloat(imageArray!.count - 1) * UX.PhotoGap , biggerFrame.height)
        if isLast {
            currentPageNumber = currentPageNumber - 1
            contentOffset = CGPointMake(offsetUnit * CGFloat(currentPageNumber), 0)
            
        } else {
            for i in currentPageNumber...imageArray!.count - 1 {
                let origin = CGPointMake(CGFloat(i) * (biggerFrame.width - UX.PhotoGap + UX.PhotoGap), 0)
                let size = CGSizeMake(biggerFrame.width - UX.PhotoGap, biggerFrame.height)
                zoomablePhotoViews?[i].frame = CGRect(origin: origin, size: size)
            }
        }
        photoDelegate?.pageChanged(currentPageNumber, total: imageArray!.count)
    }
}

extension PhotoScrollView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = contentOffset.x / offsetUnit
        print("DidEndDecelerating: \(contentOffset.x)")
        let number = Int(pageNumber)
        if number != currentPageNumber {
            print("changeNumber to \(number) from \(currentPageNumber)")
            currentZoomablePhotoView()?.clearZoom()
            currentPageNumber = number
            photoDelegate?.pageChanged(currentPageNumber, total: imageArray!.count)
        }
        if contentOffset.x % offsetUnit != 0 {
            contentOffset = CGPointMake(offsetUnit * CGFloat(currentPageNumber), 0)
        }
    }
}

extension PhotoScrollView: PhotoDelegate {
    func tapped() {
        photoDelegate?.tapped()
    }
}