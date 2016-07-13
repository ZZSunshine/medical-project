//
//  EDKSearchCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKSearchCell.h"

@interface EDKSearchCell ()

//大图片
@property (nonatomic,strong) UIImageView *iconView;

//小图片
@property (nonatomic,strong) UIImageView *smallIconView;

//医院名称
@property (nonatomic,strong) UILabel *hospitalLabel;

//医院等级
@property (nonatomic,strong) UILabel *gradeLabel;

//医院地址
@property (nonatomic,strong) UILabel *addressLabel;

//医院距离
@property (nonatomic,strong) UILabel *distanceLabel;

@end

@implementation EDKSearchCell
//
//
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1
        self.iconView = [[UIImageView alloc]init];
        
        //2
        self.smallIconView = [[UIImageView alloc]init];
        
        //3
        self.hospitalLabel = [[UILabel alloc]init];
        
        //4
        self.gradeLabel = [[UILabel alloc]init];
        
        //5
        self.addressLabel = [[UILabel alloc]init];
        
        //6
        self.distanceLabel = [[UILabel alloc]init];
        
        // cell 分割线
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
        
        bottomLine.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:bottomLine];
        
        //添加到self上
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.smallIconView];
        [self.contentView addSubview:self.hospitalLabel];
        [self.contentView addSubview:self.gradeLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.distanceLabel];
        
    }
    return self;
}

//重写get方法
- (void)setHostralData:(EDKHostral *)hostralData {
    
    //
    _hostralData = hostralData;
    
    //赋值
    //1
    self.iconView.image = [UIImage imageNamed:hostralData.iconView];
    
    //2
    self.smallIconView.image = [UIImage imageNamed:hostralData.smallIconView];
    [self.smallIconView sizeToFit];
    
    //3 医院名称
    self.hospitalLabel.text = hostralData.hospitalLabel;
    [self.hospitalLabel sizeToFit];
    
    self.hospitalLabel.font = [UIFont systemFontOfSize:14];
    
    //4 医院等级
    self.gradeLabel.text = hostralData.gradeLabel;
    [self.gradeLabel sizeToFit];
    
    self.gradeLabel.font = [UIFont systemFontOfSize:14];
    self.gradeLabel.textColor = [UIColor grayColor];
    
    //5 医院地址
    self.addressLabel.text = hostralData.addressLabel;
    [self.addressLabel sizeToFit];
    
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    //self.addressLabel.textColor = [UIColor greenColor];
    self.addressLabel.textColor = [UIColor colorWithHexString:backImgColor];
    //6 医院距离
    self.distanceLabel.text = hostralData.distanceLabel;
    [self.distanceLabel sizeToFit];
    
    self.distanceLabel.font = [UIFont systemFontOfSize:14];
    //self.distanceLabel.textColor = [UIColor greenColor];
    self.distanceLabel.textColor = [UIColor colorWithHexString:backImgColor];
}

//布局
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //布局
    //1 图像
    
    CGFloat imageX = 8;
    CGFloat imageY = 8;
    CGFloat imageW = 60;
    CGFloat imageH = 54;
    
    self.iconView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //2 医院名称
    self.hospitalLabel.frame = CGRectMake(imageX * 2 + imageW, imageY, self.hospitalLabel.bounds.size.width, self.hospitalLabel.bounds.size.height);
    
    //3 医院等级
    self.gradeLabel.frame = CGRectMake(imageW + 3 *imageX + self.hospitalLabel.width , imageY, self.gradeLabel.bounds.size.width, self.gradeLabel.bounds.size.height);
    
    //4 小图标
    self.smallIconView.frame = CGRectMake(imageX * 2 + imageW, imageY + self.hospitalLabel.bottom + 10, self.smallIconView.bounds.size.width, self.smallIconView.bounds.size.height);
    
    //5 医院地址
    self.addressLabel.frame = CGRectMake(imageW + 3 *imageX + self.smallIconView.width, imageY + self.hospitalLabel.bottom + 5, self.addressLabel.bounds.size.width, self.addressLabel.bounds.size.height);
    
    //6 距离
    self.distanceLabel.frame = CGRectMake(imageW + 3*imageX + self.smallIconView.width +self.addressLabel.width, imageY + self.hospitalLabel.bottom + 5, self.distanceLabel.bounds.size.width, self.distanceLabel.bounds.size.height);
}


@end
