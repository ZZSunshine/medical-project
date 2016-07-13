//
//  MutiIItemSelectCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//


#import "MutiIItemSelectCell.h"
#import "Complication.h"

#define unSelectImg @"没选中状态"
#define SelectImg @"选中状态"

@interface MutiIItemSelectCell()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * leftView;

@end
@implementation MutiIItemSelectCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel =[[UILabel alloc] init];
        
        self.leftView =[[UIImageView alloc] init];
        self.titleLabel.font =[UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.leftView];
        
        self.leftView.image=[UIImage imageNamed:unSelectImg];
        
        //不设置选中状态
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame =CGRectMake(5, 5, 25, 25);
    self.titleLabel.frame =CGRectMake(self.leftView.right + 5, 5, KWidth -40, 30);
    
}


//重写selected 方法
-(void)setSelected:(BOOL)selected
{
    if (selected) {
        //改变图片
        self.leftView.image =[UIImage imageNamed:SelectImg];
    }
    else
    {
        self.leftView.image =[UIImage imageNamed:unSelectImg];
    }
}


//-(void)setTitle:(NSString *)title
//{
//    _title =title;
//    self.titleLabel.text =title;
//}

-(void)setComp:(Complication *)comp
{
    _comp =comp;
    
    self.titleLabel.text = comp.complication_name;
}


@end
