//
//  EDKBureausTableController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKBureausTableController.h"
#import "EDKSearchBureasController.h"
#import "EDKBureausView.h"

#import "EDKHosOptionController.h"

@interface EDKBureausTableController ()

@end

@implementation EDKBureausTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.navigationItem.titleView = [self titleView];
    
    //
    [self createBottomView];
    
    //[self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark 标题栏view

- (UIView *)titleView {
    
    //0 bottomView
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 35)];
    
    //1 创建view
    UITextField *optionHostral = [[UITextField alloc]init];
    
    bottomView.layer.cornerRadius = 15;
    bottomView.layer.masksToBounds = YES;
    //1.2 设置属性
    optionHostral.placeholder = @"输入科室查找";
    optionHostral.font = [UIFont systemFontOfSize:15];
    
    optionHostral.backgroundColor = [UIColor whiteColor];
    
    optionHostral.frame = CGRectMake(2, 2, 240, 30);
    
    //2.1 创建搜索按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    
    [btn sizeToFit];
    
    btn.frame = CGRectMake(bottomView.width - 30, 1, 28, 28);
    
    [btn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //添加
    [bottomView addSubview:optionHostral];
    [bottomView addSubview:btn];
    
    return bottomView;
}

//搜索按钮
- (void)searchBtn {
    
    //控制器跳转
    EDKSearchBureasController *controller = [[EDKSearchBureasController alloc]init];
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark 创建下面的View

- (void)createBottomView {
    
    EDKBureausView *bottomView = [[EDKBureausView alloc]initWithFrame:CGRectMake(0, 64, KWidth, KHeight - 64)];
    
    bottomView.rightTableView.hostralBlock = ^(NSString *str) {
        
        //
        EDKHosOptionController *hosOption = [[EDKHosOptionController alloc]init];
        
        [self.navigationController pushViewController:hosOption animated:YES];
        
        
    };
    
    [self.view addSubview:bottomView];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
