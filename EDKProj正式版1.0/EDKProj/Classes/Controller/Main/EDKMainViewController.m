//
//  EDKMainViewController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.

#import "EDKMainViewController.h"
#import "DCPicScrollView.h"
#import "EDKNetworking.h"
#import "FamousDoctorModel.h"
#import "FamousDoctorCell.h"
#import "SystemMessageCollectionViewController.h"
#import "UIColor+Hex.h"
#import "EDKPersonalMessageController.h"
#import "ConditionSelectController.h"
#import "DiseaseTypeOne.h"

#import "EDKBureausTableController.h"
#import "EDKsubscribTableController.h"
#import "EDKDiseaseController.h"
#import "MMDrawerController.h"
#import "EDKLoginViewController.h"
#import "EDKRegistViewController.h"
#import "MBProgressHUD.h"

#import "EDKweatherView.h"

@interface EDKMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray *array;

@property(nonatomic,strong)DCPicScrollView *scrollView;

@property(nonatomic,strong)UIView *AppointmentRegisterView;

@property(nonatomic,strong)UICollectionView *FamousDoctorCollectionView;

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong) NSArray *FamousDoctorArr;

@property(nonatomic,strong)UIView *blackView;

@property(nonatomic,strong)UIView *QuickLoginView;

@end

@implementation EDKMainViewController

static NSString *ID = @"doctor";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置主页布局
    [self setMainUI];
    
    // 注册cell
    [self.FamousDoctorCollectionView registerClass:[FamousDoctorCell class] forCellWithReuseIdentifier:ID];
    
    
    // 获取布局(通过代码获取布局）
    UICollectionViewFlowLayout *flowLayout =   (UICollectionViewFlowLayout *) self.FamousDoctorCollectionView.collectionViewLayout;
    
    //     设置大小
    flowLayout.itemSize = CGSizeMake(165, 59);
    
    flowLayout.minimumLineSpacing = 20;
    
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(40, 10, 0, 10);
    
    
    
    
}


// 懒加载轮播图数组
-(NSArray *)array {
    
    if (!_array) {
        
        _array = [NSArray array];
    }
    
    return _array;
}


// 懒加载名医通数组
-(NSArray *)FamousDoctorArr {
    
    
    if (!_FamousDoctorArr) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"FamousDoctorCell.plist" ofType:nil];
        
        _FamousDoctorArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *nmArray = [NSMutableArray array];
        
        for (NSDictionary *dict in _FamousDoctorArr) {
            
            FamousDoctorModel *model = [FamousDoctorModel cellWithDict:dict];
            
            [nmArray addObject:model];
        }
        
        _FamousDoctorArr = nmArray;
        
    }
    
    
    
    return _FamousDoctorArr;
}


#pragma mark - 设置MainUI

- (void)setMainUI {
    
    // 设置轮播ScrollViews布局
    [self setLunBoView];
    
    // 设置预约挂号CollectionView布局
    [self setAppointmentRegisterCollectionView];
    
    // 设置名医通CollectionView布局
    [self setFamousDoctorCollectionView];
}

#pragma mark - 设置轮播ScrollViews布局

- (void)setLunBoView {
    
    // 网络接口: http://iosapi.itcast.cn/doctor/banners.json.php
    
    
    NSMutableDictionary *dict = @{@"page_size":@"10",@"page":@"1"}.mutableCopy;
    
    [[EDKNetworking sharedNewtWorkTool] POST:@"http://iosapi.itcast.cn/doctor/banners.json.php" parameters:dict successBlock:^(id object) {
        
        //        NSLog(@"网络请求成功:%@",object);
        
        NSDictionary *temp = object;
        
        NSDictionary * obj = temp[@"data"];
        
        NSMutableArray *nmArray = obj[@"banners"];
        
        //        NSLog(@"网络:%@",nmArray);
        
        NSMutableArray *Urlarr = [NSMutableArray array];
        
        
        [nmArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            
            
            NSString *url = dict[@"banner_img_url"];
            
            [Urlarr addObject:url];
            
        }];
        
        self.array = Urlarr;
        
        
        DCPicScrollView *lunboView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) WithImageUrls:self.array];
        
        //        [self.tableView reloadData];
        
        [self.view addSubview:lunboView];
        
        self.scrollView = lunboView;
        
        //创建weather view
        [self createWeatherView];
        
        [self.scrollView reloadInputViews];
        
        
        
        
    }FailBlock:^(NSError *error) {
        NSLog(@"网络请求失败");
    }];
    
    UIView *lunBoLine = [[UIView alloc]initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 1)];
    
    lunBoLine.backgroundColor = [UIColor colorWithHexString:backImgColor];
    
    [self.view addSubview:lunBoLine];
    
}

#pragma mark  weahter
- (void)createWeatherView {
    
    //1 创建view
    EDKweatherView *weather = [[EDKweatherView alloc]initWithFrame:CGRectMake(0, 0, KWidth, 35)];
    
    weather.alpha = 0.5;
    //weather.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:weather];
    
    [self.scrollView bringSubviewToFront:weather];
    
    //4 遮盖view
    UIView *conver = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width *0.3-4 , 35)];
    
    conver.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:conver];
}


#pragma mark - 设置预约挂号CollectionView布局

- (void)setAppointmentRegisterCollectionView {
    
    // 创建预约挂号View布局
    UIView *AppointmentRegisterView = [[UIView alloc] initWithFrame:CGRectMake(0,181, self.view.frame.size.width, 150)];
    
    // 赋值
    self.AppointmentRegisterView = AppointmentRegisterView;
    
    // 设置背景色
    //    self.AppointmentRegisterView.backgroundColor = [UIColor redColor];
    
    // 创建预约挂号title Label
    UILabel *AppointmentRegisterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    // 设置文字
    AppointmentRegisterLabel.text = @"预约挂号";
    
    // 设置文字居中
    AppointmentRegisterLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体大小
    AppointmentRegisterLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字颜色
    AppointmentRegisterLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    // 添加
    [AppointmentRegisterView addSubview:AppointmentRegisterLabel];
    
    
    // 循环创建按钮
    for (int i = 0; i < 3; i++) {
        
        CGFloat X = (self.view.frame.size.width - 3 * 80) / 4;
        
        // 设置按钮的frame
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(X + i * ( 80 + X ) , 30, 80, 80)];
        
        // 设置按钮背景图
        [btn setBackgroundImage:[UIImage imageNamed:@"预约挂号按钮框"] forState:UIControlStateNormal];
        
        // 添加按钮
        [AppointmentRegisterView addSubview:btn];
        
        // 赋值
        self.btn = btn;
        
        // 循环给按钮添加图片和文字
        if (i == 0) {
            [self btnSetData:@"找医院" :@"找医院"];
            
            [self.btn addTarget:self action:@selector(searchHospital) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i == 1) {
            [self btnSetData:@"找科室" :@"找科室"];
            
            [self.btn addTarget:self action:@selector(searchDepartment) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i == 2) {
            [self btnSetData:@"搜疾病" :@"搜疾病"];
            
            [self.btn addTarget:self action:@selector(searchDisease) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    // 添加到view上
    [self.view addSubview:AppointmentRegisterView];
    
    UIView *AppointmentRegisterLine = [[UIView alloc]initWithFrame:CGRectMake(0, 330, self.view.frame.size.width, 1)];
    
    AppointmentRegisterLine.backgroundColor = [UIColor colorWithHexString:backImgColor];
    
    [self.view addSubview:AppointmentRegisterLine];
    
}

#pragma mark --找医院
- (void)searchHospital {
    
    //EDKLog(@"找医院");
    EDKsubscribTableController * KsubscribVc = [[EDKsubscribTableController alloc] init];
    
    [self.navigationController pushViewController:KsubscribVc animated:YES];
    
}

#pragma mark --找科室

- (void)searchDepartment {
    
    EDKBureausTableController * bureaseVc = [[EDKBureausTableController alloc] init];
    
    [self.navigationController pushViewController:bureaseVc animated:YES];
}

#pragma mark --搜疾病
- (void)searchDisease {
    
    
    EDKDiseaseController * diseaseVc =[[EDKDiseaseController alloc] init];
    
    [self.navigationController pushViewController:diseaseVc animated:YES];
    
}




#pragma mark 预约挂号按钮设置图片和文字
- (void)btnSetData:(NSString *)ImgName :(NSString *)text {
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ImgName]];
    
    [iconView sizeToFit];
    
    iconView.frame = CGRectMake((self.btn.frame.size.width - iconView.image.size.width ) / 2, (self.btn.frame.size.height - iconView.image.size.height ) / 2 - 10, iconView.image.size.width, iconView.image.size.height);
    ;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 5, self.btn.frame.size.width, self.btn.frame.size.height - CGRectGetMaxY(iconView.frame))];
    
    label.text = text;
    
    label.font = [UIFont systemFontOfSize:15.0];
    
    label.textColor = [UIColor lightGrayColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.btn addSubview:label];
    
    [self.btn addSubview:iconView];
}



#pragma mark - 设置名医通CollectionView布局

- (void)setFamousDoctorCollectionView {
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *FamousDoctorView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,331, self.view.frame.size.width, self.view.frame.size.height - 331) collectionViewLayout:flowlayout];
    
    flowlayout.itemSize = CGSizeMake(100, 80);
    
    flowlayout.minimumLineSpacing = 20;
    
    flowlayout.minimumInteritemSpacing = 20;
    
    flowlayout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
    
    self.FamousDoctorCollectionView = FamousDoctorView;
    
    [self.FamousDoctorCollectionView registerClass:[FamousDoctorCell class] forCellWithReuseIdentifier:ID];
    
    self.FamousDoctorCollectionView.dataSource = self;
    
    self.FamousDoctorCollectionView.delegate = self;
    
    
    self.FamousDoctorCollectionView.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:FamousDoctorView];
    
    
    UILabel *FamousDoctorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    // 设置文字
    FamousDoctorLabel.text = @"名医通";
    
    // 设置文字居中
    FamousDoctorLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体大小
    FamousDoctorLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字颜色
    FamousDoctorLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    // 添加
    [FamousDoctorView addSubview:FamousDoctorLabel];
    
    
    
}


#pragma mark 返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

#pragma mark 返回多少行(格子)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
#pragma mark 返回怎么样cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    1.创建cell
    
    FamousDoctorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //        cell.backgroundColor = [UIColor redColor];
    
    FamousDoctorModel *model = self.FamousDoctorArr[indexPath.row];
    
    cell.Model = model;
    
    // 返回cell
    return cell;
    
}

#pragma mark --选择 下面的重大疾病
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FamousDoctorModel *model = self.FamousDoctorArr[indexPath.row];
    
    
    
    // 判断应该显示哪个界面!
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KisLoginFlag]) {
        
        NSNumber * isLogin=
        [[NSUserDefaults standardUserDefaults] objectForKey:KisLoginFlag];
        
        //如果已经登录了
        if ([isLogin integerValue] ==1) {
            DiseaseTypeOne * diseaseOne = [DiseaseTypeOne new];
            diseaseOne.ci1_id = model.ci1_id;
            diseaseOne.ci1_name = model.ci1_name;
            //EDKLog(@"%@",model.ci1_id);
            
            ConditionSelectController * conditionVc =[[ConditionSelectController alloc] init];
            conditionVc.diseaseOne  = diseaseOne;
            
            //跳转到控制器
            [self.navigationController pushViewController:conditionVc animated:YES];
        }
        else
        {
            // 显示快速登录界面
            [self QuickLogin];
        }
    }
    else
    {
        [self unRegisterAction];
    }
    
    
    
}

#pragma mark -- 没注册的时候点击..
-(void)unRegisterAction
{
    //
    MBProgressHUD * hud =[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.labelText =@"您是第一次使用本系统..请注册";
    
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
        //如果从来没有注册过..
        EDKRegistViewController * registerVc =[[EDKRegistViewController alloc] init];
        [self.navigationController pushViewController:registerVc animated:YES];
        
    });

}

- (void)QuickLogin {
    
    UIView *blackView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    blackView.alpha = 0.3;
    
    blackView.backgroundColor = [UIColor blackColor];
    
    [self.navigationController.view addSubview:blackView];
    
    UIView *QuickLoginView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    
    //    QuickLoginView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"快速登录框"]];
    
    QuickLoginView.backgroundColor = [UIColor whiteColor];
    
    QuickLoginView.center = blackView.center;
    
    QuickLoginView.layer.cornerRadius = 10;
    
    [self.navigationController.view bringSubviewToFront:QuickLoginView];
    
    [self.navigationController.view addSubview:QuickLoginView];
    
    self.QuickLoginView = QuickLoginView;
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((QuickLoginView.width - 48) * 0.5, 30, 48, 48)];
    
    icon.image = [UIImage imageNamed:@"用户"];
    
    [QuickLoginView addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 98, 250, 20)];
    
    label.text = @"未登录";
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor colorWithHexString:backImgColor];
    
    label.font = [UIFont systemFontOfSize:14.0];
    
    [QuickLoginView addSubview:label];
    
    
    // 登录按钮
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((QuickLoginView.frame.size.width - 200 ) / 3, 138, 100, 30)];
    
    loginBtn.backgroundColor = [UIColor colorWithHexString:backImgColor];
    //
    //    [loginBtn setBackgroundImage:[UIImage imageNamed:@"快速登录按钮框"] forState:UIControlStateNormal];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    loginBtn.layer.cornerRadius = 10;
    
    [QuickLoginView addSubview:loginBtn];
    
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake((QuickLoginView.frame.size.width - 200 ) / 3 * 2 + 100, 138, 100, 30)];
    
    //    [registBtn setBackgroundImage:[UIImage imageNamed:@"快速登录按钮框"] forState:UIControlStateNormal];
    
    registBtn.backgroundColor = [UIColor colorWithHexString:backImgColor];
    
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    registBtn.layer.cornerRadius = 10;
    
    [QuickLoginView addSubview:registBtn];
    
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 1.创建点按手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    // 2.添加到对应的视图上
    [blackView addGestureRecognizer:tap];
    
    self.blackView = blackView;
}


// 3.实现对应的方法
- (void)tapAction:(UITapGestureRecognizer *)recognizer {
    
    self.blackView.hidden = YES;
    
    self.QuickLoginView.hidden = YES;
    
}



- (void)loginBtnClick {
    
    EDKLog(@"跳转登录页面");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
    
    EDKLoginViewController *loginVc = [[EDKLoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
    
}

- (void)registBtnClick {
    
    EDKLog(@"跳转注册页面");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil];
}


- (instancetype)init {
    
    //添加返回按钮的图片并且显示
    UIImage *image = [UIImage imageNamed:@"用户-白色"];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加左侧"返回"按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(UserBtnClick)];
    
    //设置title
    self.title = @"医立得";
    
    //添加右侧"快速注册"按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(MessageBtnClick)];
    
    
    return self;
}

- (void)UserBtnClick {
    //EDKLog(@"进入个人主页");
    
    //判断是否已经登录..
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KisLoginFlag]) {
        
        NSInteger flag=  [[[NSUserDefaults standardUserDefaults] objectForKey:KisLoginFlag] integerValue];
        if(flag ==0)
        {
            // 显示快速登录界面
            [self QuickLogin];
        }
        else
        {
            // 判断应该显示哪个界面!
          
            MMDrawerController *mmVC = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            
            [mmVC toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        }
    }
    else
    {
        //如果第一次 没注册
        [self unRegisterAction];
    }
    
    
    
    
}

- (void)MessageBtnClick {
    //EDKLog(@"进入消息通知页");
    
    UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc] init];
    
    SystemMessageCollectionViewController *SystemMessage = [[SystemMessageCollectionViewController alloc] initWithCollectionViewLayout:flowlayout];
    
    [self.navigationController pushViewController:SystemMessage animated:YES];
    
}

@end
