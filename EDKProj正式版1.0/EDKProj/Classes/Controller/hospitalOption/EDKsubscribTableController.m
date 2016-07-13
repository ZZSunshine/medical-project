//
//  EDKsubscribTableController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKsubscribTableController.h"
#import "EDKCustomButton.h"
#import "EDKDropListTableView.h"
#import "EDKNetworking.h"
#import "EDKHostral.h"
#import "EDKsubscribCell.h"
#import "EDKSearchController.h"
#import "EDKBureausController.h"
#import "EDKSearchTableView.h"

@interface EDKsubscribTableController ()

//左边按钮
@property (nonatomic,strong) EDKCustomButton *leftButton;

//右边按钮
@property (nonatomic,strong) EDKCustomButton *rightButton;

//左边表
@property (nonatomic,strong) EDKDropListTableView *leftTableView;

//右边表
@property (nonatomic,strong) EDKDropListTableView *rightTableView;


//数据源 医院等级
@property (nonatomic,strong) NSMutableArray *gradeArray;

//数据源 医院地址
@property (nonatomic,strong) NSMutableArray *addressArray;

//医院信息
@property (nonatomic,strong) NSMutableArray *hostralArray;


@property (nonatomic,strong) UITextField *textField;

@end

@implementation EDKsubscribTableController

#pragma mark  懒加载
- (NSMutableArray *)addressArray {
    
    if (!_addressArray) {
        
        //
        _addressArray = [NSMutableArray arrayWithObjects:@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号", nil];
    }
    return _addressArray;
}

- (NSMutableArray *)gradeArray {
    
    if (!_gradeArray) {
        
        _gradeArray = [NSMutableArray arrayWithObjects:@"三级甲等",@"三级乙等",@"二级甲等",@"二级乙等",@"一级甲等",@"一级乙等",@"特级甲等",@"特级乙等", nil];
    }
    return _gradeArray;
}

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
//
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 2在导航栏中添加
    self.navigationItem.titleView = [self titleView];
    
    // 3 添加两个按钮的view
    [self createBtnTable];
    
    // 4添加tableView类
    [self createTableView];
    
    //注册观察者
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenTableView:) name:@"hidden" object:nil];
    
}

#pragma mark 加载下拉框数据
//- (void)hiddenTableView:(NSNotification *)notify {
//
//    NSString *strM = notify.object;
//
//    //根据穿过来的值进行刷新 加载数据
//    if (self.leftButton.tag == 1) {
//
//        [self leftBtnClick:self.leftButton];
//    }
//    else {
//
//        [self rightBtnClick:self.rightButton];
//    }
//}
//
//- (void)dealloc {
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


#pragma mark 标题栏view

- (UIView *)titleView {
    
    //0 bottomView
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 35)];
    
    //1 创建view
    UITextField *optionHostral = [[UITextField alloc]init];
    
    bottomView.layer.cornerRadius = 15;
    bottomView.layer.masksToBounds = YES;
    //1.2 设置属性
    optionHostral.placeholder = @"输入医院名称查找";
    optionHostral.font = [UIFont systemFontOfSize:15];
    
    optionHostral.backgroundColor = [UIColor whiteColor];
    
    optionHostral.frame = CGRectMake(2, 2, 240, 30);
    
    self.textField = optionHostral;
    
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

#pragma mark tableView
- (void)createTableView {
    
    //
    EDKSearchTableView *tableView = [[EDKSearchTableView alloc]initWithFrame:CGRectMake(0, 110, KWidth, KHeight) style:UITableViewStylePlain];
    //
    tableView.theName = self.textField.text;
    
    tableView.hospitalBlockSuccess = ^(EDKHostral *hostral) {
        
        //遍历keywindow里面的view
        [self deleteDropListTableView];
        
        EDKBureausController *bueaus = [[EDKBureausController alloc]init];
        
        bueaus.hostral = hostral;
        
        [self.navigationController pushViewController:bueaus animated:YES];
    };
    
    [self.view addSubview:tableView];
    
}

- (void)createBtnTable {
    
    //1 创建一个大的view
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 45)];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    
    //底部分割线
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.height- 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    
    bottomLine.backgroundColor = [UIColor grayColor];
    
    [bottomView addSubview:bottomLine];
    
    //中间分割线
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(bottomView.width * 0.5, 3, 0.5, bottomView.height -6)];
    
    centerLine.backgroundColor = [UIColor grayColor];
    
    [bottomView addSubview:centerLine];
    
    
    //2 创建左边自定义的按钮
    
    EDKCustomButton *leftButton = [[EDKCustomButton alloc]initWithFrame:CGRectMake(0, 0, bottomView.width * 0.5, bottomView.height)];
    
    [leftButton setTitle:@"医院等级" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton setImage:[UIImage imageNamed:@"右拉伸箭头灰色"] forState:UIControlStateNormal];
    
    leftButton.backgroundColor = [UIColor clearColor];
    
    self.leftButton = leftButton;
    
    //2.1 设置点击事件
    [leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.2 添加表
    CGFloat marignY = CGRectGetMaxY(bottomView.frame);
    
    EDKDropListTableView *leftTableView = [[EDKDropListTableView alloc]initWithFrame:CGRectMake(0, marignY, self.leftButton.width, 0)];
    
    //
    leftTableView.dataArray = self.addressArray;
    
    leftTableView.dropListBlcok = ^(NSString *str) {
        
        //__weak typeof(self) weakSelf;
        //根据穿过来的值进行刷新 加载数据
        if (self.leftButton.tag == 1) {
            
            [self leftBtnClick:self.leftButton];
        }
        else {
            
            [self rightBtnClick:self.rightButton];
        }
        
    };
    
    
    self.leftTableView = leftTableView;
    
    
    //3 创建右边自定义的按钮
    
    EDKCustomButton *rightButton = [[EDKCustomButton alloc]initWithFrame:CGRectMake(leftButton.width, 0, bottomView.width, bottomView.height)];
    
    rightButton.backgroundColor = [UIColor clearColor];
    
    [rightButton setTitle:@"医院地区" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [rightButton setImage:[UIImage imageNamed:@"右拉伸箭头灰色"] forState:UIControlStateNormal];
    
    //3.1 设置点击事件
    [rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //3.2 添加表
    
    EDKDropListTableView *rightTableView = [[EDKDropListTableView alloc]initWithFrame:CGRectMake(self.leftButton.width, marignY, self.leftButton.width, 0)];
    
    //赋值 添加数据
    rightTableView.dataArray = self.gradeArray;
    
    
    rightTableView.dropListBlcok = ^(NSString *str) {
        
        //__weak typeof(self) weakSelf;
        //根据穿过来的值进行刷新 加载数据
        if (self.leftButton.tag == 1) {
            
            [self leftBtnClick:self.leftButton];
        }
        else {
            
            [self rightBtnClick:self.rightButton];
        }
        
    };
    
    self.rightTableView = rightTableView;
    
    
    //4 把按钮添加到View上
    [bottomView addSubview:leftButton];
    [bottomView addSubview:rightButton];
    
    [self.view addSubview:bottomView];
}

#pragma mark  点击事件
- (void)leftBtnClick:(EDKCustomButton *)sender {
    
    //0为了接受通知设置的一个值
    sender.tag = 1;
    self.rightButton.tag = 0;
    
    //1 先关闭右边
    [UIView animateWithDuration:0.2 animations:^{
        
        self.rightTableView.height = 0;
        self.rightButton.imageView.transform = CGAffineTransformIdentity;
    }];
    
    //2 获取高度
    CGFloat leftheight = self.leftTableView.height;
    
    //2.1 进行判断
    if (leftheight > 0) {
        
        //隐藏
        leftheight = 0;
        [UIView animateWithDuration:0.2 animations:^{
            
            self.leftTableView.height = leftheight;
            // 清除按钮的图片旋转
            sender.imageView.transform = CGAffineTransformIdentity;
            
        }];
        [self.leftTableView removeFromSuperview];
    }
    else {
        [[UIApplication sharedApplication].keyWindow addSubview:self.leftTableView];
        //显示
        [UIView animateWithDuration:0.2 animations:^{
            
            self.leftTableView.height = 230;
            
            [self.leftTableView reloadData];
            sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI * 0.9999/2);
        }];
    }
}

- (void)rightBtnClick:(EDKCustomButton *)sender {
    
    //0为了接受通知设置的一个值
    sender.tag = 1;
    self.leftButton.tag = 0;
    
    
    //1 先关闭左边
    [UIView animateWithDuration:0.2 animations:^{
        
        self.leftTableView.height = 0;
        self.leftButton.imageView.transform = CGAffineTransformIdentity;
    }];
    
    //2 获取高度进行判断   显示和隐藏
    CGFloat marginheight = self.rightTableView.height;
    
    if (marginheight > 0) {
        
        //
        marginheight = 0;
        [UIView animateWithDuration:0.2 animations:^{
            
            self.rightTableView.height = marginheight;
            // 清除按钮的图片旋转
            sender.imageView.transform = CGAffineTransformIdentity;
        }];
        [self.rightTableView removeFromSuperview];
    }
    else {
        
        //
        [[UIApplication sharedApplication].keyWindow addSubview:self.rightTableView];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.rightTableView.height = 230;
            
            [self.rightTableView reloadData];
            
            sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI * 0.9999/2);
            
        }];
    }
}

- (void)searchBtn {
    
    [self deleteDropListTableView];
    
    //创建搜索控制器
    EDKSearchController *Search = [[EDKSearchController alloc]init];
    
    Search.theName = self.textField.text;
    
    [self.navigationController pushViewController:Search animated:YES];
}


#pragma mark 移除keywindow上的table
- (void) deleteDropListTableView {
    
    //遍历keywindow里面的view
    UIApplication *app = [UIApplication sharedApplication];
    for (UIView *view in app.keyWindow.subviews) {
        if ([view isKindOfClass:[EDKDropListTableView class]]) {
            
            [view removeFromSuperview];
            
            self.rightButton.imageView.transform = CGAffineTransformIdentity;
            self.leftButton.imageView.transform = CGAffineTransformIdentity;
        }
    }
}
@end
