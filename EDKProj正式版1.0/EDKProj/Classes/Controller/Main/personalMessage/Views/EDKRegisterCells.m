//
//  EDKRegisterCells.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKRegisterCells.h"

@implementation EDKRegisterCells

+ (instancetype) cellWithTableView:(UITableView *)tableView
{

    NSString *cellID = @"cellID";
    EDKRegisterCells *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"EDKRegisterCell" owner:nil options:nil]lastObject];;
        }

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
