//
//  EDKCollectCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKCollectCell01.h"

@implementation EDKCollectCell01

+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    
    NSString *cellID = @"cellID";
    EDKCollectCell01 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDKCollectCell01" owner:nil options:nil]lastObject];;
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
