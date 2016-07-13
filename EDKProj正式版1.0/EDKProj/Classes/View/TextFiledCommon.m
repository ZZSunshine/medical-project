//
//  TextFiledCommon.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "TextFiledCommon.h"

@implementation TextFiledCommon


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    self.borderStyle =UITextBorderStyleLine;
    
    self.backgroundColor =[UIColor whiteColor];
    self.layer.borderColor =[UIColor colorWithHexString:txtBorderColor].CGColor;
    
    return self;
}

-(void)setEnabled:(BOOL)enabled
{

    //改变背景颜色
    if (enabled) {
        self.backgroundColor =[UIColor whiteColor];
    }
    else
    {
        self.backgroundColor =[UIColor colorWithHexString:@"#E6E6E6"];
    }
    
    self.userInteractionEnabled  = NO;
    
}

@end
