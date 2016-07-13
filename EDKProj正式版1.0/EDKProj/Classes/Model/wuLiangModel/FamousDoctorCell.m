//
//  FamousDoctorCell.m
//  EDKProj
//
//  Created by wuliang on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "FamousDoctorCell.h"
#import "FamousDoctorModel.h"
#import "UIColor+Hex.h"

#define KMargin 25


@interface FamousDoctorCell ()

@property (nonatomic,weak) UIImageView *ci1_icon;

@property (nonatomic,weak) UILabel  *ci1_name;

@property (nonatomic,weak) NSNumber  *ci1_id;

@end


@implementation FamousDoctorCell



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        1.添加图片
        UIImageView *ci1_icon = [[UIImageView alloc]init];
        [self.contentView addSubview:ci1_icon];
        self.ci1_icon = ci1_icon;
        //        2.添加名称
        UILabel *ci1_name = [[UILabel alloc]init];
        [self.contentView addSubview:ci1_name];
        self.ci1_name = ci1_name;
        //        2.1设置文字位置
        ci1_name.textAlignment = NSTextAlignmentCenter;
        //        2.2设置字体大小
        ci1_name.font = [UIFont systemFontOfSize:15];
        
        // 设置文字颜色
        ci1_name.textColor = [UIColor lightGrayColor];
        
        ci1_name.textAlignment =NSTextAlignmentCenter;
        
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"名医通按钮框"]];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
    
}
//必须调用父类方法,在这个发方法中，我们设置子控件的frame,这个方法中，当前控件的frame已经有值
- (void)layoutSubviews{
    [super layoutSubviews];
    //    1.设置图片的frame
    
    self.ci1_icon.frame = CGRectMake(20, (self.height - 35) * 0.5, 30, 30);
    //    2.设置名称的frame
    
    
    self.ci1_name.frame = CGRectMake(CGRectGetMaxX(self.ci1_icon.frame) +15, 0, 80, 59);
    
    
}

-(void)setModel:(FamousDoctorModel *)Model{
    
    _Model = Model;
    
    self.ci1_icon.image = [UIImage imageNamed: Model.ci1_icon];
    self.ci1_name.text = Model.ci1_name;
    self.ci1_id = Model.ci1_id;
}
















@end
