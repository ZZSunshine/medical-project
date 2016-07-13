//
//  EDKPayBill.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKPayBillCells.h"


@interface EDKPayBillCells()

@property (nonatomic, strong) UILabel *SZLabel;
@property (nonatomic, strong) UILabel *DCLabel;
@property (nonatomic, strong) UILabel *XHLabel;
@property (nonatomic, strong) UILabel *TimeLabel;
@property (nonatomic, strong) UILabel *MoneyLabel;

@end

@implementation EDKPayBillCells

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.SZLabel = [[UILabel alloc]init];
    self.SZLabel.text = @"赠送";
    self.DCLabel = [[UILabel alloc]init];
    self.DCLabel.text = @"王医生";
    self.XHLabel = [[UILabel alloc]init];
    self.XHLabel.text = @"鲜花";
    self.TimeLabel = [[UILabel alloc]init];
    self.TimeLabel.text = @"2015-06-01 12:00";
    self.TimeLabel.textColor = [UIColor darkGrayColor];
    self.MoneyLabel = [[UILabel alloc]init];
    self.MoneyLabel.text = @"-101.08";
    self.MoneyLabel.textColor = [UIColor redColor];
    
    [self.contentView addSubview:self.SZLabel];
    [self.contentView addSubview:self.DCLabel];
    [self.contentView addSubview:self.XHLabel];
    [self.contentView addSubview:self.TimeLabel];
    [self.contentView addSubview:self.MoneyLabel];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 72, [UIScreen mainScreen].bounds.size.width, 1)];
    bottomLine.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:bottomLine];
    
    return self ;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.SZLabel.frame = CGRectMake(10, 10, 34, 21);
    self.DCLabel.frame = CGRectMake(54, 10, 51, 21);
    self.XHLabel.frame = CGRectMake(115, 10, 200, 21);
    self.TimeLabel.frame = CGRectMake(10, 41, 200, 21);
    self.MoneyLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 25, 100, 21);

}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
