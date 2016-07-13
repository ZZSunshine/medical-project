//
//  EDKRightTableView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKRightTableView.h"
#import "EDKRightTableCell.h"

@interface EDKRightTableView () <UITableViewDataSource,UITableViewDelegate>

//数据源
@property (nonatomic,strong) NSMutableArray *bDespeArray;

@end

@implementation EDKRightTableView

//懒加载
- (NSMutableArray *)bDespeArray {
    if (!_bDespeArray) {
        
        //
        _bDespeArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Bureausdespe.plist" ofType:nil]];
    }
    return _bDespeArray;
}

//重写initwithframe方法
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    //
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        //1 设置数据源和代理对象
        self.dataSource = self;
        self.delegate = self;
        
        //2 设置属性 取消滚动
        self.showsHorizontalScrollIndicator = NO;
        
        //3 取消下划线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        //4 执行block
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           //__weak typeof(self) weakSelf = self;
            self.selecteddespe = ^(NSDictionary *dict) {
                
                //weakSelf.bDespeArray = nil;
                //赋值 加载数据
                //[weakSelf reloadData];
                
                //[NSThread sleepForTimeInterval:2.0];
                //演示效果
                //[weakSelf bDespeArray];
                
                //[weakSelf reloadData];
                
            };
            
        });
    }
    return self;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bDespeArray.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1 标识符
    static NSString *ID = @"cell";
    
    //2 重用
    EDKRightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //3 判断
    if (!cell) {
        
        cell = [[EDKRightTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //4 赋值和返回
    NSDictionary *dict = self.bDespeArray[indexPath.row];
    
    cell.tname = dict[@"tname"];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    NSString *str = self.bDespeArray[indexPath.row][@"tname"];
    
    if (self.hostralBlock) {
        
        self.hostralBlock(str);
    }
}








@end
