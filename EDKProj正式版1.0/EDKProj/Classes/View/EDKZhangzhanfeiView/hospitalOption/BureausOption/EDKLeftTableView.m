//
//  EDKLeftTableView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKLeftTableView.h"
#import "EDKLeftTableCell.h"


@interface EDKLeftTableView () <UITableViewDataSource,UITableViewDelegate>

//数据源
@property (nonatomic,strong) NSMutableArray *bureausArray;

@end


@implementation EDKLeftTableView
#pragma mark 懒加载
- (NSMutableArray *)bureausArray {
    
    if (!_bureausArray) {
        
        //初始化添加假数据
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Bureausname.plist" ofType:nil];
        
        _bureausArray = [NSMutableArray arrayWithContentsOfFile:filePath];
        
    }
    return _bureausArray;
}


//initwithframe

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    
    //判断
    if (self) {
        
        //1 设置数据源对象和代理对象
        self.dataSource = self;
        self.delegate = self;
        
        //2 设置一些属性
        //self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bureausArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1 标识符
    static NSString *ID = @"cell";
    
    //2 cell重用
    EDKLeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[EDKLeftTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //赋值
    NSDictionary *dict = self.bureausArray[indexPath.row];
    
   // cell.backgroundColor = [UIColor redColor];
    
    cell.name = dict[@"name"];
    
    return cell;
    
}

#pragma mark UITableViewDelegate

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    NSDictionary *dict = self.bureausArray[indexPath.row];
    
    //回调
    if (self.selectedBur) {
        
        self.selectedBur(dict);
    }

}

@end
