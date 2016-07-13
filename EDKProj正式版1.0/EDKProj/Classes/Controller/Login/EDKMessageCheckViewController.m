//
//  EDKMessageCheckViewController.m
//  EDKProj
//

#import "EDKMessageCheckViewController.h"
#import "UIColor+Hex.h"
#import "EDKPersonalMessageController.h"
#import "EDKMainViewController.h"
#import "MMDrawerController.h"
#import "EDKNavController.h"
#define Y 84
#define X 22
#define KMargin 20





@interface EDKMessageCheckViewController ()


@end

@implementation EDKMessageCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Tabar布局
    [self setUpTabarUI];
    
    // 布局UI
    [self setUpMainUI];
    
    
}


- (void)setUpMainUI {
    
#pragma mark - 设置用户提示
    //用户提示图标
    UIImageView *noticeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(X + 70,  Y + 16, 20, 20)];
    
    //设置图片
    noticeIcon.image = [UIImage imageNamed:@"u44"];
    
    //添加到view上
    [self.view addSubview:noticeIcon];
    
    //创建用户登录提示文本
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(  CGRectGetMaxX(noticeIcon.frame) + 10,Y, 250, 50) ];
    
    //设置文字
    noticeLabel.text = @"请您确认注册信息";
    
    //设置字体大小
    [noticeLabel setFont:[UIFont systemFontOfSize:15.0]];
    
    //设置字体颜色
    noticeLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
    
    //添加到view上
    [self.view addSubview:noticeLabel];
    
    
#pragma mark - 确认姓名
    
    // 创建确认姓名Label
    UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(noticeIcon.frame) + KMargin, 120, 43)];

    // 设置文字
    NameLabel.text = @"真实姓名:";
    
    //设置字体大小
    NameLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字居中
    NameLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置字体颜色
    NameLabel.textColor = [UIColor lightGrayColor];
    
    //添加到view上
    [self.view addSubview:NameLabel];
    
    // 创建信息确认Label 布局
    UILabel *NameValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(NameLabel.frame), CGRectGetMaxY(noticeIcon.frame) + KMargin, 220, 43)];
    
    // 赋值
    NameValueLabel.text = self.nameValue;
    
    // 设置字体大小
    NameValueLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字左对齐
    NameValueLabel.textAlignment = NSTextAlignmentLeft;
    
    // 设置字体颜色
    NameValueLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    //添加到view上
    [self.view addSubview:NameValueLabel];
    
//    self.nameValue = NameValueLabel.text;
    
#pragma mark - 确认证件类型
    
    // 创建确认证件类型Label 布局
    UILabel *credentialsTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(NameLabel.frame) + KMargin, 120, 43)];
    
    // 赋值
    credentialsTypeLabel.text = @"证件类型:";
    
    // 设置字体大小
    credentialsTypeLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字居中
    credentialsTypeLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体颜色
    credentialsTypeLabel.textColor = [UIColor lightGrayColor];
    
    //添加到view上
    [self.view addSubview:credentialsTypeLabel];
    
    // 创建信息确认Label 布局
    UILabel *credentialsTypeValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(credentialsTypeLabel.frame), CGRectGetMaxY(NameLabel.frame) + KMargin, 220, 43)];
    
    // 赋值
    credentialsTypeValueLabel.text = self.credentialsTypeValue;
    
    // 设置字体大小
    credentialsTypeValueLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字左对齐
    credentialsTypeValueLabel.textAlignment = NSTextAlignmentLeft;
    
    // 设置字体颜色
    credentialsTypeValueLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    //添加到view上
    [self.view addSubview:credentialsTypeValueLabel];
    
    
#pragma mark - 确认证件号
    
    // 创建确认证件号码Label 布局
    UILabel *credentialsNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(credentialsTypeLabel.frame) + KMargin, 120, 43)];
    
    // 赋值
    credentialsNumLabel.text = @"证件号码:";
    
    // 设置字体大小
    credentialsNumLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字居中
    credentialsNumLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体颜色
    credentialsNumLabel.textColor = [UIColor lightGrayColor];
    
    //添加到view上
    [self.view addSubview:credentialsNumLabel];
    
    // 创建信息确认Label 布局
    UILabel *credentialsNumValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(credentialsNumLabel.frame), CGRectGetMaxY(credentialsTypeLabel.frame) + KMargin, 220, 43)];
    
    // 赋值
    credentialsNumValueLabel.text = self.credentialsNumValue;
    
    // 设置字体大小
    credentialsNumValueLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字左对齐
    credentialsNumValueLabel.textAlignment = NSTextAlignmentLeft;
    
    // 设置字体颜色
    credentialsNumValueLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    //添加到view上
    [self.view addSubview:credentialsNumValueLabel];
    
//    self.credentialsNumValue = credentialsNumValueLabel.text;
    
    
#pragma mark - 确认手机号
    
    // 创建确认手机号码Label 布局
    UILabel *phoneNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(credentialsNumLabel.frame) + KMargin, 120, 43)];
    // 赋值
    phoneNumLabel.text = @"手机号码:";
    
    // 设置字体大小
    phoneNumLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字居中
    phoneNumLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体颜色
    phoneNumLabel.textColor = [UIColor lightGrayColor];
    
    //添加到view上
    [self.view addSubview:phoneNumLabel];
    
    // 创建信息确认Label 布局
    UILabel *phoneNumValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneNumLabel.frame), CGRectGetMaxY(credentialsNumLabel.frame) + KMargin, 220, 43)];
    
    // 赋值
    phoneNumValueLabel.text = self.phoneNumValue;
    
    // 设置字体大小
    phoneNumValueLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字左对齐
    phoneNumValueLabel.textAlignment = NSTextAlignmentLeft;
    
    // 设置字体颜色
    phoneNumValueLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    //添加到view上
    [self.view addSubview:phoneNumValueLabel];
    
//    self.phoneNumValue = phoneNumValueLabel.text;
    
#pragma mark - 确认现居地址
    
    // 创建确认现居地址Label 布局
    UILabel *liveAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(phoneNumLabel.frame) + KMargin, 120, 43)];
    
    // 赋值
    liveAddressLabel.text = @"现居地址:";
    
    // 设置字体大小
    liveAddressLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字居中
    liveAddressLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体颜色
    liveAddressLabel.textColor = [UIColor lightGrayColor];
    
    //添加到view上
    [self.view addSubview:liveAddressLabel];
    
    // 创建信息确认Label 布局
    UILabel *liveAddressValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(liveAddressLabel.frame), CGRectGetMaxY(phoneNumLabel.frame) + KMargin, 220, 43)];
    
    // 赋值
    liveAddressValueLabel.text = self.liveAddressValue;
    
    // 设置字体大小
    liveAddressValueLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置文字左对齐
    liveAddressValueLabel.textAlignment = NSTextAlignmentLeft;
    
    // 设置字体颜色
    liveAddressValueLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    //添加到view上
    [self.view addSubview:liveAddressValueLabel];
    
    
    
#pragma mark - 完成注册

    // 创建完成注册按钮 布局
    UIButton *registDoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, CGRectGetMaxY(liveAddressLabel.frame) + KMargin, 330, 43)];
    
    //设置背景图片
    [registDoneBtn setBackgroundImage:[UIImage imageNamed:@"g34"] forState:UIControlStateNormal];
    
    //设置按钮文字
    [registDoneBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    
    //设置按钮文字颜色
    [registDoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 登录按钮点击事件
    [registDoneBtn addTarget:self action:@selector(registDoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到view上
    [self.view addSubview:registDoneBtn];

    // 打开用户交互
    self.view.userInteractionEnabled = YES;

}


#pragma mark -- 注册完成的登录事件
- (void)registDoneBtnClick {
    
    if (self.nameValue && self.credentialsNumValue && self.phoneNumValue) {
        [self saveUserInfo];
        
        //切换根控制器
        
     
         EDKPersonalMessageController * peronalMessageVc = [[EDKPersonalMessageController alloc] init];
        
        EDKMainViewController * mainVc =[[EDKMainViewController alloc] init];
        
           EDKNavController * navController = [[EDKNavController alloc] initWithRootViewController:mainVc];
    
        MMDrawerController * mmVc= [[MMDrawerController alloc] initWithCenterViewController:navController leftDrawerViewController:peronalMessageVc];
        
        
        [UIApplication sharedApplication].keyWindow.rootViewController =mmVc;
       
        
        
    }else {
    
        EDKLog(@"姓名,证件号或者手机号错误!");
    }
    
}


#pragma mark - 注册成功保存用户信息 到偏好设置
- (void)saveUserInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:self.nameValue forKey:kUserNameKey];
    
//    // 将密码进行加密
//    NSData *data = [self.password.text dataUsingEncoding:NSUTF8StringEncoding];
//    
//    // base64加密之后的密码.
//    NSString *password = [data base64EncodedStringWithOptions:0];
//    
    [user setObject:self.credentialsNumValue forKey:kCredentialsNumKey];
    
    [user setObject:self.phoneNumValue forKey:kPhoneNumKey];
    
    [user setObject:self.genderValue forKey:kGenderValueKey];
    
    //添加一个是否登录的判断..
    [user setObject:@(1) forKey:KisLoginFlag];
    
    
    [user synchronize];
}

#pragma mark - Tabar布局
- (void)setUpTabarUI {
    
    //添加返回按钮的图片并且显示
    UIImage *image = [UIImage imageNamed:@"返回箭头"];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //添加左侧"返回"按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    //设置title
    self.title = @"用户注册";
    
    //添加右侧"快速注册"按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"2/2" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)leftBarButtonItemClick {

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
