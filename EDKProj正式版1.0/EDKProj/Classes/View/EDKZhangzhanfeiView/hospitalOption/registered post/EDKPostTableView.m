//
//  EDKPostTableView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKPostTableView.h"
#import "EDKPostTableViewCell.h"

@interface EDKPostTableView () <UITableViewDataSource,UITableViewDelegate>

//
@property (nonatomic,copy) NSString *strDate;
@end

@implementation EDKPostTableView

//
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //1 数据源方法和对象对象
        self.dataSource = self;
        
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        
        //注册监听事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDate:) name:@"dateOption" object:nil];
    }
    return self;
}

#pragma mark 通知事件
- (void)loadDate:(NSNotification *)notify {
    
    NSString *datestr = notify.object;
    
    self.strDate = datestr;
    
    [self reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1
    static NSString *ID = @"cell";
    
    //2
    EDKPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [EDKPostTableViewCell postTableViewCell];
    }
    
    cell.strDate = self.strDate;
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
