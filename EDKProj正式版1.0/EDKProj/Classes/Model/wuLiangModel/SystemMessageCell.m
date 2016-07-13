//
//  SystemMessageCell.m
//  EDKProj
//
//  Created by wuliang on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "SystemMessageCell.h"
#import "SystemMessageModel.h"
#import "UIColor+Hex.h"

@interface SystemMessageCell ()

@property (nonatomic,weak) UIImageView *icon;

@property (nonatomic,weak) UILabel  *title;

@property (nonatomic,weak) UILabel  *detail;


@end


@implementation SystemMessageCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
//        self.frame = CGRectMake(0, 0, 140, 58);
        
        // 添加图片
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
//        icon.backgroundColor = [UIColor grayColor];
        
        [icon sizeToFit];
        
        // 添加title
        UILabel *title = [[UILabel alloc]init];
        [self.contentView addSubview:title];
        self.title = title;
        // 设置文字位置
        title.textAlignment = NSTextAlignmentLeft;
        // 设置字体大小
        title.font = [UIFont systemFontOfSize:15.0];
        
//        title.backgroundColor = [UIColor redColor];
        
        // 设置文字颜色
        title.textColor = [UIColor colorWithHexString:backImgColor];
        
        
        // 添加detail
        UILabel *detail = [[UILabel alloc]init];
        [self.contentView addSubview:detail];
        self.detail = detail;
        // 设置文字位置
        detail.textAlignment = NSTextAlignmentLeft;
        // 设置字体大小
        detail.font = [UIFont systemFontOfSize:14];
        
        // 设置文字颜色
        detail.textColor = [UIColor colorWithHexString:backImgColor];
        
//        detail.lineBreakMode = NSLineBreakByWordWrapping;
        
        detail.numberOfLines = 0;
        
    }
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    self.icon.frame = CGRectMake(20, 8, 20, 20);
    
    
    self.title.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 10, 5, 300, 25);
    
    self.detail.frame = CGRectMake(20, 30, 330, 50);
    
}

-(void)setModel:(SystemMessageModel *)Model{
    
    _Model = Model;
    self.icon.image = [UIImage imageNamed: Model.icon];
    self.title.text = Model.title;
    self.detail.text = Model.detail;
    
}


@end
