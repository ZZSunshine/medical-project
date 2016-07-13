//
//  EDKDropListTableView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKDropListTableView.h"
#import "UIColor+ZXLazy.h"

@interface EDKDropListTableView () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation EDKDropListTableView

- (void)setDataArray:(NSMutableArray *)dataArray {
    
    _dataArray = dataArray;
    
    [self reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor grayColor];
        //1 设置数据源和方法
        self.dataSource = self;
        
        self.delegate = self;
        
        self.tableFooterView = [[UIView alloc]init];
        
    }
    return self;
}


#pragma mark  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //cell.backgroundColor = [UIColor colorWithHexString:@"CBD7FF"];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //1 取消灰色选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *str = self.dataArray[indexPath.row];
    
    if (self.dropList) {
        
        self.dropList(str);
    }
    
    //
    if (self.dropListBlcok) {
        
        self.dropListBlcok(str);
    }
    
    //选中某一行的时候发送通知
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"hidden" object:str];
    
}
















@end
