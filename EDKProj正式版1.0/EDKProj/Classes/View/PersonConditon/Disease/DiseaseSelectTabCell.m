//
//  DiseaseSelectTabCell.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "DiseaseSelectTabCell.h"
#import "DiseaseInfo.h"
@interface DiseaseSelectTabCell()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * rightView;


@end

@implementation DiseaseSelectTabCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel =[[UILabel alloc] init];
        self.titleLabel.font =[UIFont systemFontOfSize:16];
        
        self.rightView =[[UIImageView alloc] init];
        
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.rightView];
        
        self.rightView.image=[UIImage imageNamed:@"右拉伸箭头灰色"];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame =CGRectMake(10, 5, KWidth-50, 35);
    self.rightView.frame =CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 5, 20, 20);
    
}



-(void)setInfo:(DiseaseInfo *)info
{
    _info =info;

    self.titleLabel.text =info.ci3_name;

    
}

@end
