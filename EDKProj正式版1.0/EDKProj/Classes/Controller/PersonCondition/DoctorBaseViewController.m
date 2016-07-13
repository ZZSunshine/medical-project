//
//  DoctorBaseViewController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

//
//  DoctorBaseInfoController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "DoctorBaseViewController.h"
#import "DictorList.h"
#import "EDKNetworking.h"
#import "DoctorBase.h"
#import "UIImageView+WebCache.h"
#import "iconImageButtonTwo.h"
#import "DoctorOtherInfoCollectionView.h"
#import "CommonFlowLayout.h"
#import "MsgAlertView.h"
#import "DCPathButton.h"

#import "EDKsummitMaterial.h"

#import "GitPresentToDoctorViewController.h"
#import "MBProgressHUD.h"

#import "TalkToDoctorViewController.h"

#define iconImageName @"导师"
#define CommonColor @"#53D0E5"

@interface DoctorBaseViewController ()<DCPathButtonDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *titleHeaderView;

@property (weak, nonatomic) IBOutlet UIImageView *doctroImageView;

@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *doctorKeshiLabel;

@property (weak, nonatomic) IBOutlet UILabel *doctorTitleName;

@property (weak, nonatomic) IBOutlet UILabel *doctorHospitalLbel;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMsg;

@property (weak, nonatomic) IBOutlet UIView *daoshiView;

@property (weak, nonatomic) IBOutlet UILabel *daoshiNameLabel;

@property (weak, nonatomic) IBOutlet iconImageButtonTwo *btnOpreationCount;

@property (weak, nonatomic) IBOutlet iconImageButtonTwo *btnFlowerCount;
@property (weak, nonatomic) IBOutlet iconImageButtonTwo *btnBannerCount;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (weak, nonatomic) IBOutlet UIButton *btnJztj;
@property (weak, nonatomic) IBOutlet UIButton *btnYsjj;
@property (weak, nonatomic) IBOutlet UIButton *btnJjsj;

@property (nonatomic,strong) UIActivityIndicatorView * actiview;
//创建一个自定义collectionView

@property(nonatomic,strong) UIView * currentLineView;

@property (nonatomic,strong) DoctorBase * doctor;

@property (nonatomic,weak) UIButton * lastTitleBtn;

@property (nonatomic,weak)DoctorOtherInfoCollectionView *OtherView;

@property (nonatomic,strong) MsgAlertView * alertSelectDayView;

@property (nonatomic,strong) UIView * screenView;

@property (nonatomic,strong) MBProgressHUD * HUD;

@end

@implementation DoctorBaseViewController
#pragma mark --懒加载
-(UIActivityIndicatorView *)actiview
{
    if (_actiview ==nil) {
        
        _actiview =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((KWidth - 44) *0.5, (KHeight - 44) *0.5, 44, 44)];
        
        
        _actiview.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
        
        [self.view addSubview:_actiview];
        
    }
    
    return _actiview;
}


-(UIView*) currentLineView
{
    if (_currentLineView ==nil) {
        _currentLineView =[[UIView alloc] initWithFrame:CGRectMake(0, self.btnJztj.height, self.btnJztj.width, 2)];
        
        [self.titleView addSubview:_currentLineView];
        
        _currentLineView.backgroundColor =[UIColor colorWithHexString:CommonColor];
    }
    
    return _currentLineView;
}

-(DoctorBase *)doctor
{
    if (_doctor ==nil) {
        _doctor = [DoctorBase new];
    }
    return  _doctor;
}


-(MsgAlertView *)alertSelectDayView
{
    if (_alertSelectDayView ==nil) {
        
        //使用xib 的方式来实现的..
        _alertSelectDayView =[[MsgAlertView alloc] initWithFrame:CGRectMake((KWidth -300) * 0.5, -130, 300, 130)];
        //使用动画的方式来改变frame
        
        __weak typeof(self) wself =self;
        
        
        //控制跳转...
        _alertSelectDayView.gotoblock = ^(NSString * controllerName)
        {
          
            //控制跳转
                UIStoryboard * stroyboard =[UIStoryboard storyboardWithName:controllerName bundle:nil];
            
                EDKsummitMaterial * edkMaterialVc = [stroyboard instantiateInitialViewController];
            
            
            [wself.navigationController pushViewController:edkMaterialVc animated:YES];
            
            [wself clearScreenClick];
            
            
        };

        _alertSelectDayView.alpha = 0.0;

        //[self.view addSubview:_alertSelectDayView];
        
    }
    return _alertSelectDayView;
}

-(UIView *)screenView
{
    if(_screenView ==nil)
    {
        _screenView =[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _screenView.backgroundColor =[UIColor blackColor];
        _screenView.alpha =0.5;
        
        //创建手势
        UITapGestureRecognizer * gesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearScreenClick)];
        
        [_screenView addGestureRecognizer:gesture];

    }
    return _screenView;
}

//点击移除view
-(void)clearScreenClick
{
    
    __weak typeof(MsgAlertView *) wmsgView = _alertSelectDayView;

    if (self.screenView) {
        //移除提示，和遮罩
        [wmsgView removeFromSuperview];
        [self.screenView removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.daoshiView.layer.cornerRadius = 5;
    self.daoshiView.layer.masksToBounds=YES;
    
    self.doctroImageView.layer.cornerRadius =5;
    self.doctroImageView.layer.masksToBounds =YES;
    
    self.navigationItem.title=@"医生基本信息";
    //就诊条件
    self.btnJztj.tag =1000;
    self.btnYsjj.tag =1001;
    self.btnJjsj.tag =1002;
    
    [self btnTitleClick:self.btnJztj];
    
    
    //创建layout
    CommonFlowLayout * flowLayout =[CommonFlowLayout InstanceFlowLayOutWithCollectionName:@"DoctorOtherInfoCollectionView" andItemSize:CGSizeMake(KWidth, self.centerView.height -30-60)];
    //创建collectionView
    DoctorOtherInfoCollectionView * OtherView=[[DoctorOtherInfoCollectionView alloc] initWithFrame:CGRectMake(0, 40, KWidth, self.centerView.height-30-60) collectionViewLayout:flowLayout];
    self.OtherView =OtherView;
    
    OtherView.doctorBase = self.doctorlist;
    
    //加入到中间的视图当中去
    [self.centerView addSubview:OtherView];
    
    //注册通知 下面的CollectionView 滚动事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DoctorContentScrollAction:) name:@"DoctorContentScroll" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alerDateSelectAction:) name:@"alerDateSelectAction" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MsgAlertCloseView:) name:@"MsgAlertCloseView" object:nil];
    
    //创建弹出按钮组
    [self configureDCPathButton];
    
    //创建收藏按钮
    [self createCollectionBtn];
    
}

//当点击 预约按钮的时候 执行的事件..
-(void)alerDateSelectAction:(NSNotification *)nofity
{
    
    [self.view addSubview:self.screenView];
    [self.view addSubview:self.alertSelectDayView];
    self.alertSelectDayView.frame = CGRectMake((KWidth -300) * 0.5, -130, 300, 130);
    
    NSMutableDictionary * parmaters = nofity.object;
    //把参数传递过去
    self.alertSelectDayView.parmaters = parmaters;

    [self.view bringSubviewToFront:self.alertSelectDayView];
    
    
    //把_alertSelectDayView 显示出来
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alertSelectDayView.alpha =1;
        self.alertSelectDayView.centerY = self.view.centerY;
       
        
    } completion:^(BOOL finished) {
        
        
    }];
}

//清除屏幕
-(void)MsgAlertCloseView:(NSNotification *)nofity
{
    [self clearScreenClick];
}

//下面滚动的时候触发的事件..
-(void)DoctorContentScrollAction:(NSNotification *)nofity
{
    NSNumber* index = nofity.object;
    
    if (self.lastTitleBtn) {
        self.lastTitleBtn.selected =NO;
    }
    
    //判断index 来选中对应的button
    if (index.integerValue ==0) {
        
        self.btnJztj.selected =YES;
        self.lastTitleBtn = self.btnJztj;
       
    }
    else if (index.integerValue == 1)
    {
        self.btnYsjj.selected =YES;
        self.lastTitleBtn = self.btnYsjj;
    }
    else
    {
         self.btnJjsj.selected =YES;
        self.lastTitleBtn = self.btnJjsj;
    }
    
    //改变frame
    [UIView animateWithDuration:0.25 animations:^{
        
        self.currentLineView.left = index.integerValue * self.btnJztj.width;
        
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)btnTitleClick:(UIButton *)sender {
    
    if (self.lastTitleBtn) {
        self.lastTitleBtn.selected =NO;
    }
    
    sender.selected =YES;
    
    NSInteger index = sender.tag -1000;
    
    [UIView animateWithDuration:0.25 animations:^{
       
        self.currentLineView.left = index * sender.width;
        
    }];
    
    //滚动到指定位置
    NSIndexPath * selectIndexPath =[NSIndexPath indexPathForItem:index inSection:0];
    
    [self.OtherView scrollToItemAtIndexPath:selectIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    self.lastTitleBtn =sender;
    
}

-(void)setDoctorlist:(DictorList *)doctorlist
{
    _doctorlist =doctorlist;
    //加载数据 基本数据
    [self laodData];
    
    
    
}

-(void)laodData
{
    //    {"user_id":1000089,"doctor_id":300000315}
    NSMutableDictionary * parmaters=[NSMutableDictionary dictionary];
    parmaters[@"user_id"] =@(1000089);
    parmaters[@"doctor_id"]=self.doctorlist.doctor_id;
    
    //开始加载
    self.actiview.hidden = NO;
    [self.actiview startAnimating];
    
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORBASEINFONET parameters:parmaters successBlock:^(id object) {
        
        //打印数据
        //EDKLog(@"%@",object);
        
        NSDictionary * dictData = object;
        if ([dictData[@"code"] integerValue]==0) {
            
            NSDictionary * doctorDict= dictData[@"data"];
            
            self.doctor  = [DoctorBase DoctorBaseWith:doctorDict];
           
            //获取到值以后来给控件赋值
            //设置基本信息
            [self setDoctorBaseInfo];
            
            [self.actiview stopAnimating];
            self.actiview.hidesWhenStopped=YES;

        }
        
    } FailBlock:^(NSError *error) {
        
    }];
    
}

-(void)setDoctorBaseInfo
{
    
    self.doctorName.text= self.doctorlist.doctor_name;
     self.doctorTitleName.text= self.doctorlist.doctor_title_name;
    [self.doctroImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorlist.doctor_portrait] placeholderImage:[UIImage imageNamed:@"user_default"]];
    
     self.doctorKeshiLabel.text= self.doctor.department_name;
    self.doctorHospitalLbel.text = self.doctorlist.doctor_hospital_name;
    
    self.daoshiNameLabel.text =([self.doctor.mentor_content isEqualToString:@" "] || !self.doctor.mentor_content) ? @"暂无":self.doctor.mentor_content ;
    
    
    [self.btnOpreationCount setImage:[UIImage imageNamed:@"手术刀"] forState:UIControlStateNormal];
    [self.btnOpreationCount setTitle:[NSString stringWithFormat:@"手术数:"] forState:UIControlStateNormal];
    
    [self.btnOpreationCount setCount:self.doctorlist.operation_count forState:UIControlStateNormal];
    
   
    [self.btnFlowerCount setImage:[UIImage imageNamed:@"赠送鲜花"] forState:UIControlStateNormal];
    [self.btnFlowerCount setTitle:[NSString stringWithFormat:@"鲜花数:"] forState:UIControlStateNormal];
    
    [self.btnFlowerCount setCount:self.doctorlist.flower forState:UIControlStateNormal];

    
    [self.btnBannerCount setImage:[UIImage imageNamed:@"赠送锦旗"] forState:UIControlStateNormal];
    [self.btnBannerCount setTitle:[NSString stringWithFormat:@"锦旗数:"] forState:UIControlStateNormal];
    
    [self.btnBannerCount setCount:self.doctorlist.banner forState:UIControlStateNormal];

    
}


- (IBAction)ShenQingBtnClick:(UIButton *)sender {
    
    if (self.lastTitleBtn) {
        self.lastTitleBtn.selected =NO;
    }
    
    self.btnJjsj.selected  =YES;
    //直接跳转到最后一个 选就诊日期的控制器
    NSInteger index = 2;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.currentLineView.left = index * self.btnJjsj.width;
        
    }];
    
    //滚动到指定位置
    NSIndexPath * selectIndexPath =[NSIndexPath indexPathForItem:index inSection:0];
    
    [self.OtherView scrollToItemAtIndexPath:selectIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    self.lastTitleBtn = self.btnJjsj;
    
}

#pragma mark --创建导航栏的 收藏按钮
-(void)createCollectionBtn
{
    UIButton * collectBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setImage:[UIImage imageNamed:@"nav_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"nav_collected"] forState:UIControlStateSelected];

    [collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn sizeToFit];
    UIBarButtonItem * collectItem =[[UIBarButtonItem alloc] initWithCustomView:collectBtn];

    self.navigationItem.rightBarButtonItem =collectItem;
}

-(void)collectClick:(UIButton *)sender
{
    MBProgressHUD*  HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    self.HUD =HUD;

    if (sender.selected) {
       
        //创建HUD
        sender.selected =NO;
        HUD.labelText = @"已取消!";
    }
    else
    {
        
        sender.selected =YES;
        HUD.labelText = @"已收藏!";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
          [HUD showWhileExecuting:nil onTarget:nil withObject:nil animated:YES];
    });
  
    //EDKLog(@"点击了收藏按钮..");
}


#pragma mark ---HUD代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}


#pragma mark --配置特殊按钮
- (void)configureDCPathButton
{
    // Configure center button
    //
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"更多1"]
                                                           highlightedImage:[UIImage imageNamed:@""]
                                                            backgroundImage:[UIImage imageNamed:@""]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@""]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"赠送鲜花"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@""]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@""]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"赠送锦旗"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@""]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
  
   
    
   
    
    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,

                                 ]];
    
    // Change the bloom radius, default is 105.0f
    //
    dcPathButton.bloomRadius = 105.0f;
    
    // Change the DCButton's center
    //
    //    dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 25.5f);
    
    dcPathButton.dcButtonCenter = CGPointMake(KWidth - 27, 100);
    
    // Setting the DCButton appearance
    //
    dcPathButton.allowSounds = YES;
    dcPathButton.allowCenterButtonRotation = YES;
    
    dcPathButton.bottomViewColor = [UIColor grayColor];
    
    dcPathButton.bloomDirection = kDCPathButtonBloomDirectionBottomLeft;
    //dcPathButton.dcButtonCenter = CGPointMake(10 + dcPathButton.frame.size.width/2, self.view.frame.size.height - dcPathButton.frame.size.height/2 - 10);
    dcPathButton.bottomViewColor = [UIColor blackColor];
    
    [self.view addSubview:dcPathButton];
    
}

#pragma mark - DCPathButton Delegate

- (void)willPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    //NSLog(@"ItemButton will present");
    
}

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    //NSLog(@"You tap %@ at index : %lu", dcPathButton, (unsigned long)itemButtonIndex);
    
    NSMutableDictionary * parmaters = [NSMutableDictionary dictionary];
    
    switch (itemButtonIndex) {
        case 0:
//            EDKLog(@"跳转到和医生交流的画面");
            
        {
            TalkToDoctorViewController * talkVc =[[TalkToDoctorViewController alloc] init];
            [self.navigationController pushViewController:talkVc animated:YES];
            
            //跳转到聊天画面..
        }
            break;
        case 1:
        {
            //送鲜花
            GitPresentToDoctorViewController * gitvc= [[GitPresentToDoctorViewController alloc] initWithNibName:@"GitPresentToDoctorViewController" bundle:nil];
            parmaters[@"doctorName"] = self.doctorlist.doctor_name;
            parmaters[@"fee"]= @(50);
            parmaters[@"giftype"] =@"鲜花";
            
            gitvc.parmaters =parmaters;
            
            [self.navigationController pushViewController:gitvc animated:YES];
            
        }
           
            
        break;
        case 2:
        {
            GitPresentToDoctorViewController * gitvc= [[GitPresentToDoctorViewController alloc] initWithNibName:@"GitPresentToDoctorViewController" bundle:nil];
            parmaters[@"doctorName"] = self.doctorlist.doctor_name;
            parmaters[@"fee"]= @(100);
            parmaters[@"giftype"] =@"锦旗";
            
            gitvc.parmaters =parmaters;
            
            [self.navigationController pushViewController:gitvc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)didPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    //NSLog(@"ItemButton did present");
    
}

@end

