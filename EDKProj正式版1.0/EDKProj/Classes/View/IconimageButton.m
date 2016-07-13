//
//  IconimageButton.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "IconimageButton.h"

@interface IconimageButton()

@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * nameLabel;

@end

@implementation IconimageButton

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
    self.nameLabel.textColor =[UIColor colorWithHexString:@"#53D0E5"];
    
    [self addSubview:self.nameLabel];
//    return self;

}


//-(instancetype)initWithFrame:(CGRect)frame
//{
//   
//}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImageView.frame =CGRectMake(5, 0, 15, 15);
    self.nameLabel.frame =CGRectMake(25, 0, 25, 20);
    
}


-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    self.nameLabel.text = title;
    
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    self.iconImageView.image =image;
}

@end
