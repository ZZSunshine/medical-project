//
//  EDKSearchTableView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKSearchTableView.h"
#import "EDKSearchCell.h"

@interface EDKSearchTableView () <UITableViewDataSource,UITableViewDelegate>

//医院信息
@property (nonatomic,strong) NSMutableArray *hostralArray;

@end


@implementation EDKSearchTableView
#pragma mark 懒加载
- (NSMutableArray *)hostralArray {
    
    if (!_hostralArray) {
        
        //
        NSDictionary *dict = [[NSDictionary alloc]init];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 20;i++) {
            
            EDKHostral *hostral = [EDKHostral hostralWithdict:dict];
            
            [temp addObject:hostral];
        }
        _hostralArray = temp;
        
    }
    return _hostralArray;
}



//重写init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        //1 设置数据源 和代理对象
        self.delegate = self;
        self.dataSource = self;
        
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}


#pragma mark 刷新
- (void)setTheName:(NSString *)theName {
    
    _theName = theName;
    
    //根据穿过来的值重新加载数据并进行刷新
    
    [self reloadData];
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.hostralArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1 标识符
    static NSString *ID = @"cell";
    
    //2 重用
    EDKSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //3 判断
    if (!cell) {
        
        cell = [[EDKSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //
    EDKHostral *hostral = self.hostralArray[indexPath.row];
    
    cell.hostralData = hostral;
    
    //cell显示后刷新一下    这样写会卡的呀
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        [self reloadData];
    //    });
    
    return cell;
    
}

#pragma mark UITableViewDelegate

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //医院信息模型
    EDKHostral *hostral = self.hostralArray[indexPath.row];
    
    if (self.hospitalBlockSuccess) {
        
        self.hospitalBlockSuccess(hostral);
    }
    
    
}

@end
