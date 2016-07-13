//
//  ButtonNormal.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "ButtonNormal.h"

@interface ButtonNormal()

@property (nonatomic,strong) UIImage * image;
@property (nonatomic,strong) UIImage * disableImage;
@end

@implementation ButtonNormal

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self =[super initWithFrame:frame];
    
    [self setTitle:title forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor colorWithHexString:backImgColor] forState:UIControlStateNormal];
    
    [self setTitle:title forState:UIControlStateDisabled];
    
    [self setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateDisabled];
    
    self.backgroundColor =[UIColor colorWithHexString:selectBtnBlackGroundColor alpha:0.45];
    
    
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andDisableImg:(UIImage *)selectImg
{
    self =[super initWithFrame:frame];
    
    self.image =image;
    self.disableImage =selectImg;
    
    [self setImage:image forState:UIControlStateNormal];

    [self setImage:selectImg forState:UIControlStateDisabled];
    
    
    return self;
}



@end
