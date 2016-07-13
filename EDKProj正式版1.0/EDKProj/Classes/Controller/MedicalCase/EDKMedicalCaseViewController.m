//
//  EDKMedicalCaseViewController.m
//  EDKProj
//

#import "EDKMedicalCaseViewController.h"
#import "EDKNavController.h"
#import "EDKAddCaseViewController.h"
#import "EDKMedicalCaseCell.h"
#import "EDKsummitMaterial.h"
#import "UIColor+Hex.h"
#import "EDKMaterialSetVC.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height
#define KtopMargin 10
#define KleftMargin 15
#define KimgHW 17
#define KmidMargin 7
//底部view 的高度
#define KbottomH 60
@interface EDKMedicalCaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIView *UpView;
//头像
@property (nonatomic,strong)UIImageView *portraitImage;
//姓名
@property (nonatomic,strong)UILabel *nameLabel;
//性别图标
@property (nonatomic,strong)UIImageView *genderImage;
//性别label
@property (nonatomic,strong)UILabel *genderLabel;
//年龄label
@property (nonatomic,strong)UILabel *ageLabel;
//住址label
@property (nonatomic,strong)UILabel *locationLabel;
//住址图标
@property (nonatomic,strong)UIImageView *locationImage;
//ID 图标
@property (nonatomic,strong)UIImageView *IDImage;
//ID label
@property (nonatomic,strong)UILabel *IDlabel;
//电话图标
@property (nonatomic,strong)UIImageView *phoneImage;
//电话label
@property (nonatomic,strong)UILabel *phoneLabel;

//midView
@property (nonatomic,strong)UIView *midView;
//tableView
@property (nonatomic,strong)UITableView *tableView;

//接收传过来的数组
@property (nonatomic,strong)NSMutableArray *arrM;

@property (nonatomic,strong)UIImage *receiveImg;

@end

@implementation EDKMedicalCaseViewController
//懒加载传过来的数组
- (NSMutableArray *)arrM{
    if (_arrM == nil) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}
//懒加载控件
//头像
- (UIImageView *)portraitImage{
    if (_portraitImage == nil) {
        _portraitImage = [[UIImageView alloc]init];
        _portraitImage.frame = CGRectMake(KleftMargin,KtopMargin ,70, 70);
                _portraitImage.backgroundColor = [UIColor blueColor];
        _portraitImage.image = [UIImage imageNamed:@"user_default"];
    }
    return _portraitImage;
}
//性别图标
- (UIImageView *)genderImage{
    if (_genderImage == nil) {
        _genderImage = [[UIImageView alloc]initWithFrame:CGRectMake(KleftMargin + self.portraitImage.bounds.size.width+KtopMargin, KtopMargin, KimgHW, KimgHW)];
//                _genderImage.backgroundColor = [UIColor blueColor];
        _genderImage.image = [UIImage imageNamed:@"人物"];
    }
    return _genderImage;
}
//性别label
- (UILabel *)genderLabel{
    if (_genderLabel == nil) {
        _genderLabel = [[UILabel alloc]initWithFrame:CGRectMake(KleftMargin+self.portraitImage.bounds.size.width+2*KtopMargin+ self.genderImage.bounds.size.width, KtopMargin, KimgHW, KimgHW)];
        _genderLabel.text = @"男";
        _genderLabel.textColor = [UIColor grayColor];
       
    }
    return _genderLabel;
}
//年龄label
- (UILabel *)ageLabel{
    if (_ageLabel == nil) {
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(KleftMargin+self.portraitImage.bounds.size.width+2*KtopMargin+ self.genderImage.bounds.size.width+self.genderLabel.bounds.size.width+2*KtopMargin, KtopMargin, 2*KimgHW, KimgHW)];
        _ageLabel.text = @"24";
        _ageLabel.textColor = [UIColor grayColor];
        
    }
    return _ageLabel;
}
//位置图标
- (UIImageView *)locationImage{
    if (_locationImage == nil) {
        _locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(KleftMargin + self.portraitImage.bounds.size.width+KtopMargin, KtopMargin+KimgHW+KmidMargin, KimgHW, KimgHW)];
        _locationImage.image = [UIImage imageNamed:@"定位-1"];
//        _locationImage.backgroundColor = [UIColor blueColor];
    }
    return _locationImage;
}
//位置label
- (UILabel *)locationLabel{
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(KleftMargin+self.portraitImage.bounds.size.width+2*KtopMargin+ self.genderImage.bounds.size.width, KtopMargin+KimgHW+KmidMargin, KWIDTH-(KleftMargin + self.portraitImage.bounds.size.width+2*KtopMargin-KtopMargin), KimgHW)];
        _locationLabel.text = @"北京市";
        _locationLabel.textColor = [UIColor grayColor];
    }
    return _locationLabel;
}
//ID 图标
- (UIImageView *)IDImage{
    if (_IDImage == nil) {
        _IDImage = [[UIImageView alloc]initWithFrame:CGRectMake(KleftMargin + self.portraitImage.bounds.size.width+KtopMargin, KtopMargin+2*KimgHW+2*KmidMargin, KimgHW, KimgHW)];

        _IDImage.image = [UIImage imageNamed:@"标签"];
    }
    return _IDImage;
}
//ID label
- (UILabel *)IDlabel{
    if (_IDlabel == nil) {
        _IDlabel = [[UILabel alloc]initWithFrame:CGRectMake(KleftMargin+self.portraitImage.bounds.size.width+2*KtopMargin+ self.genderImage.bounds.size.width, KtopMargin+2*KimgHW+2*KmidMargin, KWIDTH-(KleftMargin + self.portraitImage.bounds.size.width+2*KtopMargin-KtopMargin), KimgHW)];
        _IDlabel.text = @"412725198901212212";
        _IDlabel.textColor = [UIColor grayColor];
       
    }
    return _IDlabel;
}
//电话图标
- (UIImageView *)phoneImage{
    if (_phoneImage == nil) {
        _phoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(KleftMargin + self.portraitImage.bounds.size.width+KtopMargin, KtopMargin+3*KimgHW+3*KmidMargin, KimgHW, KimgHW)];

        _phoneImage.image = [UIImage imageNamed:@"电话"];
    }
    return _phoneImage;
}
//电话label
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(KleftMargin+self.portraitImage.bounds.size.width+2*KtopMargin+ self.genderImage.bounds.size.width, KtopMargin+3*KimgHW+3*KmidMargin, KWIDTH-(KleftMargin + self.portraitImage.bounds.size.width+2*KtopMargin-KtopMargin), KimgHW)];
        _phoneLabel.text = @"18515201721";
        _phoneLabel.textColor = [UIColor grayColor];
       
    }
    return _phoneLabel;
}
//姓名
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(2*KtopMargin, KleftMargin+self.portraitImage.bounds.size.height+KtopMargin, 60, KimgHW)];
        _nameLabel.textAlignment= NSTextAlignmentCenter;
        _nameLabel.text = @"王先生";
        _nameLabel.textColor = [UIColor grayColor];
        [self.tableView reloadData];
    }
    return _nameLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"病例管理";
    self.view.backgroundColor = [UIColor whiteColor];
    //创建上半部分View;
    [self createUpHeadView];
    //创建中间部分View
    [self createMidView];
    //创建底部的View
    [self createBottomView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clickToJumpToSummitMaterial)];
    [self.tableView reloadData];
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//跳转到递交资料界面
- (void)clickToJumpToSummitMaterial{
    UIStoryboard *baord = [UIStoryboard storyboardWithName:@"EDKsummitMaterial" bundle:nil];
    EDKsummitMaterial *summitMaterialVC = [baord instantiateInitialViewController];
    [self.navigationController pushViewController:summitMaterialVC animated:YES];
}

#pragma mark --创建上半部分View
- (void)createUpHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 160)];
    //    headView.backgroundColor = [UIColor greenColor];
    //添加头像
    [headView addSubview:self.portraitImage];
    //添加性别图标
    [headView addSubview:self.genderImage];
    //添加性别label
    [headView addSubview:self.genderLabel];
    //添加年龄label
    [headView addSubview:self.ageLabel];
    //添加位置图标
    [headView addSubview:self.locationImage];
    //添加位置label
    [headView addSubview:self.locationLabel];
    //添加ID图标
    [headView addSubview:self.IDImage];
    //添加ID label
    [headView addSubview:self.IDlabel];
    //添加 手机图标
    [headView addSubview:self.phoneImage];
    //添加手机label
    [headView addSubview:self.phoneLabel];
    //添加姓名label
    [headView addSubview:self.nameLabel];
    //添加横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,KleftMargin+2*KtopMargin+self.portraitImage.bounds.size.height+KimgHW, KWIDTH, 0.5)];
    //设置背景
    lineView.backgroundColor = [UIColor colorWithHexString:@"#66DBC1"];
    //添加到headView上
    [headView addSubview:lineView];
    //添加按钮
    UIButton *changeDetailBtn = [[UIButton alloc]initWithFrame:CGRectMake((KWIDTH-120)*0.5, CGRectGetMaxY(lineView.frame), 120, 36)];
    //给按钮添加点击事件
    [changeDetailBtn addTarget:self action:@selector(clickToModifyDetail) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮文本
    [changeDetailBtn setTitle:@"修改个人信息" forState:UIControlStateNormal];
    changeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //设置按钮字体颜色
    [changeDetailBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //添加按钮
    [headView addSubview:changeDetailBtn];
    //添加底部线条
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(changeDetailBtn.frame), KWIDTH, 1)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#66DBC1"];;
    [headView addSubview:bottomView];
    self.UpView = headView;
    [self.view addSubview:headView];
}
//实现点击修改信息方法
- (void)clickToModifyDetail{
    EDKMaterialSetVC *materialSetVC = [[EDKMaterialSetVC alloc]init];
    [self.navigationController pushViewController:materialSetVC animated:YES];
}

#pragma mark --创建中间的View
- (void)createMidView{
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, self.UpView.frame.size.height+64, KWIDTH,KHEIGHT-self.UpView.frame.size.height-KbottomH-64)];
  //暂无病例button
    UIButton *noCaseBtn = [[UIButton alloc]initWithFrame:CGRectMake((KWIDTH-120)*0.5, 2*KtopMargin, 120, 15)];
    [noCaseBtn setImage:[UIImage imageNamed:@"u45"] forState:UIControlStateNormal];
    [noCaseBtn setTitle:@"暂无病例" forState:UIControlStateNormal];
    [noCaseBtn setTitleColor:[UIColor colorWithHexString:@"#66DBC1"] forState:UIControlStateNormal];
    [noCaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    //设置字体
    noCaseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [midView addSubview:noCaseBtn];
    
    //创建显示病例的tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:midView.bounds];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
   //获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"arrKey"]) {
        tableView.hidden = NO;
    }else{
      tableView.hidden = YES;  
    }
    
    
    [midView addSubview:tableView];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toCreateTableView:) name:@"clickToAddCase" object:nil];
    //赋值
    self.midView = midView;
    
    [self.view addSubview:midView];
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.arrM = [defaults objectForKey:@"arrKey"];
    [self.tableView reloadData];
}

#pragma mark --实现tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"cell";
    EDKMedicalCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDKMedicalCaseCellTest" owner:nil options:nil]lastObject];
        cell.imageView.backgroundColor = [UIColor blueColor];
    };

//    cell.iconImage.layer.borderColor = [UIColor redColor].CGColor;
//    cell.iconImage.layer.borderWidth = 2;
//    //获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"arrKey"]) {
        NSString *path = self.arrM[indexPath.row][@"img"];
        NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
        NSString *currentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
        if (range.location != NSNotFound) {
            NSString *searchPath = [path substringWithRange:NSMakeRange(0, range.location)];
            NSString *imagePath = [path stringByReplacingOccurrencesOfString:searchPath withString:currentPath];
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            [cell.iconImage setImage:image];
            cell.timeLabel.text = self.arrM[indexPath.row][@"date"];
            cell.medicalCase.text = [NSString stringWithFormat:@"患者基本病例 %ld",indexPath.row+1];
            
        }
    }

    return cell;
}

//实现通知方法
- (void)toCreateTableView:(NSNotification *)notify{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.arrM = [defaults objectForKey:@"arrKey"];
    
    [self.midView bringSubviewToFront:self.tableView];
    self.tableView.hidden = NO;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EDKMedicalCaseCell * cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = YES;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    EDKMedicalCaseCell * cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *temp = self.arrM.mutableCopy;
    
    [temp removeObjectAtIndex:indexPath.row];
    self.arrM = temp;
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [defaults setObject:self.arrM forKey:@"arrKey"];
    [defaults synchronize];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -- 创建底部视图
- (void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT-KbottomH, KWIDTH, KbottomH)];
    //添加bottomView上面的横线
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT-KbottomH-1, KWIDTH, 1)];
    bottomLineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomLineView];
    bottomLineView.alpha = 0.3;
    //添加按钮
    UIButton *addMedicalCaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(2*KleftMargin,KtopMargin,KWIDTH-4*KleftMargin,40)];
    [bottomView addSubview:addMedicalCaseBtn];
    [addMedicalCaseBtn setBackgroundImage:[UIImage imageNamed:@"addCaseNormal"] forState:UIControlStateNormal];
    [addMedicalCaseBtn setBackgroundImage:[UIImage imageNamed:@"addCaseSelect"] forState:UIControlStateSelected];
    //给按钮添加点击事件
    [addMedicalCaseBtn addTarget:self action:@selector(clickToAddMedicalCase) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
}
//点击按钮添加病例
- (void)clickToAddMedicalCase{
    EDKAddCaseViewController *addCaseVC = [[EDKAddCaseViewController alloc]init];
    [self.navigationController pushViewController:addCaseVC animated:YES];
    
}

@end
