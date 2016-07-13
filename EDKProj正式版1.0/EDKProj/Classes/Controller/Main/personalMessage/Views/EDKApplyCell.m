//
//  EDKApplyCell.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKApplyCell.h"


@interface EDKApplyCell ()




@end


@implementation EDKApplyCell


+ (instancetype) cellWithTableView2:(UITableView *)tableView
{
    
    NSString *cellID2 = @"cellID";
    EDKApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDKApply" owner:nil options:nil]lastObject];
    }
    cell.collorBtn.layer.cornerRadius = 20 ;
    cell.collorBtn.clipsToBounds = YES ;
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
