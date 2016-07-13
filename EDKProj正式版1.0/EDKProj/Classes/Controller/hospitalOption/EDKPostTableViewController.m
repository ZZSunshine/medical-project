//
//  EDKPostTableViewController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "EDKPostTableViewController.h"
#import "SZCalendarPicker.h"

#import "EDKSearchTableView.h"
#import "EDKPostCollectionView.h"
#import "EDKPostInfoController.h"
#import "ConditionSelectController.h"

@interface EDKPostTableViewController ()

//中间的视图
@property (weak, nonatomic) IBOutlet UIView *collectionTableView;

//底部附近的医院
@property (weak, nonatomic) IBOutlet UIView *hostralTableView;

//保存选中的日期
@property (nonatomic,strong) NSString *dateStr;

@property (nonatomic,assign) NSInteger index;

//scllotion
@property (nonatomic,weak) EDKPostCollectionView *postCollection;

//两个按钮
@property (weak, nonatomic) IBOutlet UIButton *presentBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation EDKPostTableViewController


#pragma mark 懒加载

- (NSString *)dateStr {
    if (!_dateStr) {
        
        _dateStr = [NSString string];
    }
    return _dateStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.navigationItem.title = @"北京协和医院";
    
    //加载完成后按钮的状态
    [self didLoadBtnState];
    
    //中间
    [self createCenterView];
    
    //底部
    [self createBottomTableView];
    
    
    //注册观察者 调转到info界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushInfo:) name:@"info" object:nil];
    
}
#pragma mark 加载完成后按钮的状态

- (void)didLoadBtnState {
    
    //1 上一个
    self.presentBtn.enabled = NO;
    
    //2 下一个
    self.nextBtn.enabled = YES;
    
}


#pragma mark 通知
- (void) pushInfo:(NSNotification *)notify {
    
    //获取数据
    NSDictionary *dict = notify.object;
    
    //2 跳转界面
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKPostInfo" bundle:nil];
    
    EDKPostInfoController *info = [board instantiateInitialViewController];
    
    info.dict = dict;
    
    [self.navigationController pushViewController:info animated:YES];
}

- (void)dealloc {
    
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark  底部添加附近医院信息

- (void)createBottomTableView {
    
    //
    EDKSearchTableView *bottomTableView = [[EDKSearchTableView alloc]initWithFrame:self.hostralTableView.bounds style:UITableViewStylePlain];
    
    //加载数据的个数
    bottomTableView.index = 2;
    
    [self.hostralTableView addSubview:bottomTableView];
    
}

#pragma mark 中间的视图

- (void)createCenterView {
    
    //1 创建collectionview
    
    //1.1 布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //设置属性
    flow.itemSize = CGSizeMake(self.collectionTableView.width, self.collectionTableView.height);
    
    //1.2 设置共同的属性
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    //1.2 创建collectionview对象
    EDKPostCollectionView *dateCollection = [[EDKPostCollectionView alloc]initWithFrame:self.collectionTableView.bounds collectionViewLayout:flow];
    
    dateCollection.nextDay = 7;
    
    self.postCollection = dateCollection;
    //2 添加
    [self.collectionTableView addSubview:dateCollection];
    
}

#pragma mark  选择日期的按钮
- (IBAction)preventBtnClick:(UIButton *)sender {
    //1 改变index的值
    self.index--;
    
    //2 改变下一个按钮的属性
    if (self.index == 5) {
        
        self.nextBtn.enabled = YES;
        [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"下一日"] forState:UIControlStateNormal];
    }
    
    //3 改变当前按钮的属性
    if (self.index < 1) {
        
        sender.enabled = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"上一日"] forState:UIControlStateNormal];
    }
    
    //2 滚动到一定的位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    
    [self.postCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    

}

- (IBAction)nextBtnClick:(UIButton *)sender {
    //1 改变index的值
    self.index ++;
    
    //2 改变上一日按钮的属性
    if (self.index > 0) {
        
        self.presentBtn.enabled = YES;
        [self.presentBtn setBackgroundImage:[UIImage imageNamed:@"下一日"] forState:UIControlStateNormal];
    }
    
    //3 改变当前按钮的属性
    if (self.index == 6) {
        
        sender.enabled = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"上一日"] forState:UIControlStateNormal];
    }
    //4 滚动到一定的位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    
    [self.postCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    

}


#pragma mark --跳转到重大疾病..
//跳转的按钮
- (IBAction)pustBtnClick:(UIButton *)sender {
    
    //跳转到重大疾病...
    ConditionSelectController * condVc =[[ConditionSelectController alloc] init];
    
    [self.navigationController pushViewController:condVc animated:YES];
}


#pragma mark  日历控件

- (IBAction)calendarBtn:(UIButton *)sender {
    
    // 1
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
    
    calendarPicker.today = [NSDate date];
    
    calendarPicker.date = calendarPicker.today;
    
    calendarPicker.frame = CGRectMake(0, 100, self.view.frame.size.width, 352);
    
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        
        self.dateStr = [NSString stringWithFormat:@"%li-%li-%li", (long)year,(long)month,(long)day];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dateOption" object:self.dateStr];
    };

    
}

@end

