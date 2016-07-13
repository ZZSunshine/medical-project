//
//  DCPathItemButton.h
//  DCPathButton
//
//  Created by tang dixi on 31/7/14.
//  Copyright (c) 2014 Tangdxi. All rights reserved.
//

@import UIKit;

@class DCPathItemButton;

@protocol DCPathItemButtonDelegate <NSObject>

- (void)itemButtonTapped:(DCPathItemButton *)itemButton;

@end

@interface DCPathItemButton : UIButton

@property (assign, nonatomic) NSUInteger index;
@property (weak, nonatomic) id<DCPathItemButtonDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image
             highlightedImage:(UIImage *)highlightedImage
              backgroundImage:(UIImage *)backgroundImage
   backgroundHighlightedImage:(UIImage *)backgroundHighlightedImage;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com