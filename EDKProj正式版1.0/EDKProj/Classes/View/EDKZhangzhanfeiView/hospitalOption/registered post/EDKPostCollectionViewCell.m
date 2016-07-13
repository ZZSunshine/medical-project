//
//  EDKPostCollectionViewCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKPostCollectionViewCell.h"
#import "EDKPostTableView.h"

@interface EDKPostCollectionViewCell ()

@property (nonatomic) EDKPostTableView *postTableView;

@end

@implementation EDKPostCollectionViewCell

//
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.contentView.backgroundColor = [UIColor redColor];
    
    // 实例化新闻主界面 tableView
    self.postTableView = [[EDKPostTableView alloc] initWithFrame:self.bounds];
    
    [self.contentView addSubview:self.postTableView];
    
    return self;
}

//
- (void)setDate:(NSDate *)date {
    
    //
    _date = date;
    
    //
    self.postTableView.date = date;
    
}

@end
