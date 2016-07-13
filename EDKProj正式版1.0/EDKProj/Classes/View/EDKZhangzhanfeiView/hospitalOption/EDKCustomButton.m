//
//  SDKCustomButton.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKCustomButton.h"

@implementation EDKCustomButton

/**
 *  重写布局的方法
 */
- (void)layoutSubviews {
    
    //
    [super layoutSubviews];
    
    //把按钮中的label和图片交换一下位置
    self.titleLabel.left = 30;
    self.imageView.left = self.titleLabel.width + 50;
}

@end
