//
//  UIImage+Helper.m
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/22.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImage+Helper.h"

@implementation UIImage (Helper)

+ (UIImage *)imageWithFillColor:(UIColor *)color
{
    if (color)
    {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextFillRect(ctx, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    return nil;
}

+ (UIImage*) imageWithUIView:(UIView*) view
{
    //设置了这些选项避免模糊失真
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates: YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*) imageWithUIView:(UIView*) view andRect:(CGRect) rect
{
    //设置了这些选项避免模糊失真
    UIGraphicsBeginImageContextWithOptions(rect.size, view.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context,
                       CGAffineTransformMakeTranslation(-(int)rect.origin.x, -(int)rect.origin.y));
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates: YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end