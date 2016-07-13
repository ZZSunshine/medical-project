//
//  EDKRightTableCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKRightTableCell.h"

@implementation EDKRightTableCell

//
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1 添加下划线
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        
        bottomLine.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:bottomLine];
        
    }
    return self;
}

//重写set方法
- (void)setTname:(NSString *)tname {
    
    _tname = tname;
    
    self.textLabel.text = tname;
    
    self.textLabel.textColor = [UIColor grayColor];
}



@end
