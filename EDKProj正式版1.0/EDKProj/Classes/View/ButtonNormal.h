//
//  ButtonNormal.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonNormal : UIButton


//用title 初始化button
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

//用 图片设置button
-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andDisableImg:(UIImage *)selectImg;

@end
