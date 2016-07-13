//
//  UIView+CZExtension.m
//  NeteaseLottery
//
//  Created by Apple on 16/2/22.
//  Copyright © 2016年 . All rights reserved.
//

#import "UIView+CZExtension.h"

@implementation UIView (CZExtension)

- (void)setX:(CGFloat)x {
    
    // 1.获取控件的frame
    CGRect frame = self.frame;
    
    // 2.修改
    frame.origin.x = x;
    
    // 3.赋值
    self.frame = frame;

}

- (CGFloat)x {

    return self.frame.origin.x;

}

- (void)setY:(CGFloat)y {
    
    // 1.获取控件的frame
    CGRect frame = self.frame;
    
    // 2.修改
    frame.origin.y = y;
    
    // 3.赋值
    self.frame = frame;
    
}

- (CGFloat)y {
    
    return self.frame.origin.y;
    
}

- (void)setWidth:(CGFloat)width {
   
    // 1.获取控件的frame
    CGRect frame = self.frame;
    
    // 2.修改
    frame.size.width = width;
    
    // 3.赋值
    self.frame = frame;
    

}

- (CGFloat)width {

    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height {

    // 1.获取控件的frame
    CGRect frame = self.frame;
    
    // 2.修改
    frame.size.height = height;
    
    // 3.赋值
    self.frame = frame;

}

- (CGFloat)height {

    return self.frame.size.height;
}


@end
