//
//  iconImageButtonTwo.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "iconImageButtonTwo.h"

@interface iconImageButtonTwo()
@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * countLabel;

@end

@implementation iconImageButtonTwo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    //    self =[super initWithFrame:frame];
    
    self.iconImageView =[[UIImageView alloc] init];
    [self addSubview:self.iconImageView];
    
    self.nameLabel =[[UILabel alloc] init];
    self.nameLabel.font =[UIFont systemFontOfSize:12];
    self.nameLabel.textColor =[UIColor blackColor];
    
    self.nameLabel.textAlignment =NSTextAlignmentRight;
    [self addSubview:self.nameLabel];
    //    return self;
    
    self.countLabel =[[UILabel alloc] init];
    self.countLabel.textAlignment =NSTextAlignmentLeft;
    self.countLabel.font =[UIFont systemFontOfSize:12];
    self.countLabel.textColor =[UIColor colorWithHexString:@"#53D0E5"];
    [self addSubview:self.countLabel];
}


//-(instancetype)initWithFrame:(CGRect)frame
//{
//
//}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImageView.frame =CGRectMake(10, 0, 15, 15);
    self.nameLabel.frame =CGRectMake(30, 0, 40, 20);
    self.countLabel.frame =CGRectMake(95, 0, 20, 20);
    
}


-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    self.nameLabel.text =title;
}

-(void)setCount:(NSNumber *)number forState:(UIControlState)state
{
    self.countLabel.text =[NSString stringWithFormat:@"%@",number];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    self.iconImageView.image =image;
}


@end
