//
//  EDKLeftTableCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKLeftTableCell.h"

@interface EDKLeftTableCell ()

//文本框
@property (nonatomic,strong) UILabel *text;

@end

@implementation EDKLeftTableCell

//
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    //
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        
        //1 创建一个label
        self.text = [[UILabel alloc]init];
        
        self.text.numberOfLines = 0;
        
        self.text.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.text];
        
        //添加一个分割线
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 79.5, self.width, 0.5)];
        
        bottomLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:bottomLine];
        
    }
    return self;
}

//重写set方法
- (void)setName:(NSString *)name {
    
    _name = name;
    
    self.text.text = name;
    self.text.numberOfLines = 0;
    [self.text sizeToFit];
}



//布局
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //重写布局
    CGFloat marginX = (self.width - self.text.width) * 0.5;
    CGFloat marginY = (self.height -self.text.height) * 0.5;
    
    self.text.frame = CGRectMake(marginX, marginY, self.text.width, self.text.height);
}
@end
