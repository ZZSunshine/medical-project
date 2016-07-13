//
//  EDKCollectCell02.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKCollectCell02.h"

@implementation EDKCollectCell02

+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"cellID";
    EDKCollectCell02 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDKCollectCell02" owner:nil options:nil]lastObject];;
    }
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 71, [UIScreen mainScreen].bounds.size.width, 1)];
    bottomLine.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:bottomLine];
    
    return cell ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
