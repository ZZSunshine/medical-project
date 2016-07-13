//
//  TalkToDoctorViewController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/30.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "TalkToDoctorViewController.h"
#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "UIView+ExtensionSize.h"


@interface TalkToDoctorViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)  UUInputFunctionView *IFView;

@property (strong, nonatomic) MJRefreshNormalHeader *head;
@property (strong, nonatomic) ChatModel *chatModel;

@property (strong, nonatomic) UITableView *chatTableView;

@end

@implementation TalkToDoctorViewController
int pageNum = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self initBar];
    [self addRefreshViews];
    [self loadBaseViewsAndData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)initBar
{
//    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"私有",@"群组"]];
//    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//    segment.selectedSegmentIndex = 0;
//    self.navigationItem.titleView = segment;
    
//    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:nil action:nil];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
    
    self.navigationItem.title =@"与医生开始聊天";
}

- (void)segmentChanged:(UISegmentedControl *)segment
{
//    self.chatModel.isGroupChat = segment.selectedSegmentIndex;
//    [self.chatModel.dataSource removeAllObjects];
//    [self.chatModel populateRandomDataSource];
//    [self.chatTableView reloadData];
    
    
}

- (void)addRefreshViews
{
    
    //实例化tableView
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-40)];
    
    self.chatTableView.dataSource =self;
    self.chatTableView.delegate =self;
    
    [self.view addSubview:self.chatTableView];
    //load more
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.head =header;
    // 设置文字
    [header setTitle:@"查看更多信息" forState:MJRefreshStateIdle];
    [header setTitle:@"正在加载最新信息 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    
    // 马上进入刷新状态
    //[header beginRefreshing];
    
    // 设置刷新控件
    self.chatTableView.mj_header = header;
    
    
}

-(void)loadNewData
{
    __weak typeof(self) weakSelf = self;
    
 
    [self.chatModel addRandomItemsToDataSource:pageNum];
    
    if (self.chatModel.dataSource.count > pageNum) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.chatTableView reloadData];
            [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
            [weakSelf.head endRefreshing];
            
        });
    }
}

- (void)loadBaseViewsAndData
{
    self.chatModel = [[ChatModel alloc]init];
    self.chatModel.isGroupChat = NO;
    [self.chatModel populateRandomDataSource];
    
    _IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    _IFView.delegate = self;
    [self.view addSubview:_IFView];
    
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}



-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    if (notification.name == UIKeyboardWillShowNotification) {
        
        //修改talbeView 的y 值
        self.chatTableView.top = 0-keyboardEndFrame.size.height;
        //self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
    }else{
        self.chatTableView.top = 0;
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = _IFView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    _IFView.frame = newFrame;
    
    [UIView commitAnimations];
    
}



//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - InputFunctionViewDelegate
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    
    NSLog(@"%@",message);
    NSDictionary *dic = @{@"strContent": message,
                          @"type": @(UUMessageTypeText)};
    funcView.TextViewInput.text = @"";
    [funcView changeSendBtnWithPhoto:YES];
    [self dealTheFunctionData:dic];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image
{
    NSDictionary *dic = @{@"picture": image,
                          @"type": @(UUMessageTypePicture)};
    [self dealTheFunctionData:dic];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
    [self dealTheFunctionData:dic];
}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark -- tabelView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.messageFrame.message.strName message:@"您点击了头像" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
