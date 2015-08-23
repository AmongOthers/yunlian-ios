//
//  UIImage+Helper.m
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/22.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (UIImage *)imageWithFillColor:(UIColor *)color;
+ (UIImage*) imageWithUIView:(UIView*) view;
+ (UIImage*) imageWithUIView:(UIView*) view andRect:(CGRect) rect;

@end