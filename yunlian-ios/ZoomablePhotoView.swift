//
//  ZoomablePhotoView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/10.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

@objc protocol PhotoDelegate {
    func tapped()
}

class ZoomablePhotoView: UIScrollView, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    var image: UIImage!
    var isZoomed = false
    var pageNumber: Int = 0
    weak var photoDelegate: PhotoDelegate?
    
    init(picture assignedImage: UIImage, frame assignedFrame: CGRect) {
        image = assignedImage
        imageView = UIImageView(image: assignedImage)
        super.init(frame: assignedFrame)
        addSubview(imageView)
        imageView?.frame.size = calculatePictureSize()
        setPictoCenter()
        delegate = self
        bounces = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        minimumZoomScale = 1.0
        maximumZoomScale = calculateMaximunScale()
        imageView?.userInteractionEnabled = true
        let doubleTap = UITapGestureRecognizer(target: self, action: "tapZoom:")
        doubleTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTap)
        let tap = UITapGestureRecognizer(target: self, action: "tap:")
        tap.numberOfTapsRequired = 1
        tap.requireGestureRecognizerToFail(doubleTap)
        imageView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func tapZoom(recognizer: UITapGestureRecognizer) {
        if isZoomed {
            setZoomScale(minimumZoomScale, animated: true)
            isZoomed = false
        } else {
            let pointInView = recognizer.locationInView(imageView)
            let scrollViewSize = bounds.size
            let w = scrollViewSize.width / maximumZoomScale
            let h = scrollViewSize.height / maximumZoomScale
            let x = pointInView.x - w / 2
            let y = pointInView.y - h / 2
            let rectToZoomTo = CGRectMake(x, y, w, h)
            zoomToRect(rectToZoomTo, animated: true)
            //setZoomScale(maximumZoomScale, animated: true)
            isZoomed = true
        }
    }
    
    func tap(recognizer: UITapGestureRecognizer) {
        photoDelegate?.tapped()
    }
    
    func clearZoom() {
        setZoomScale(minimumZoomScale, animated: false)
        isZoomed = false
    }
    
    func calculatePictureSize() -> CGSize {
        let picSize = image.size
        let screenSize = frame.size
        let picRatio = picSize.width / picSize.height
        let screenRatio = screenSize.width / screenSize.height
        if picRatio > screenRatio {
            return CGSize(width: screenSize.width, height: screenSize.width / picSize.width * picSize.height)
        } else {
            return CGSize(width: screenSize.height / picSize.height * picSize.width, height: screenSize.height)
        }
    }
    
    func calculateMaximunScale() -> CGFloat {
        return image.size.width / calculatePictureSize().width
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setPictoCenter() {
        let screenSize = frame.size
        var intendHorizon = (screenSize.width - imageView.frame.width) / 2
        var intendVertical = (screenSize.height - imageView.frame.height) / 2
        intendHorizon = intendHorizon > 0 ? intendHorizon : 0
        intendVertical = intendVertical > 0 ? intendVertical : 0
        contentInset = UIEdgeInsets(top: intendVertical, left: intendHorizon, bottom: intendVertical, right: intendHorizon)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        setPictoCenter()
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        isZoomed = true
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if scale == self.minimumZoomScale {
            isZoomed = false
        }
    }
}
