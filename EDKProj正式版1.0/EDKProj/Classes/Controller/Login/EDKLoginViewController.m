//
//  EDKLoginViewController.m
//  EDKProj
//
//  Created by wuliang on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKLoginViewController.h"
#import "EDKRegistViewController.h"
#import "EDKRegisterNavController.h"
#import "MBProgressHUD.h"
#import "EDKNetworking.h"
#import "EDKMainViewController.h"
#import "UIColor+Hex.h"
#import "EDKNavController.h"
#import "MMDrawerController.h"
#import "EDKPersonalMessageController.h"
#import "EDKMainViewController.h"

#define Y  80
#define KMargin 20
#define kUserNameKey @"usernamekey"
#define kCredentialsNumKey @"credentialsnumkey"
#define kPhoneNumKey @"phonenumkey"

#define X (([UIScreen mainScreen].bounds.size.width - 270 ) * 0.5)


@interface EDKLoginViewController ()<UITextFieldDelegate>

/** 用户名 */
@property (nonatomic, strong)UITextField *userNameText;
/** 证件号码 */
@property (nonatomic, strong)UITextField *userIDTex;
/** 手机号码 */
@property (nonatomic, strong)UITextField *phoneNumText;
/** 验证码 */
@property (nonatomic, strong)UITextField *checkNumText;
/** 错误提示View */
@property (nonatomic, strong)UIImageView *errMassageView;
/** 错误提示View */
@property (nonatomic, strong)UIImageView *otherErrMassageView;

@property (nonatomic, strong) MBProgressHUD *HUB;

@end

@implementation EDKLoginViewController

-(UIImageView *)errMassageView
{
    if (_errMassageView ==nil) {
        
        _errMassageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u49"]];
        
        _errMassageView.bounds =CGRectMake(0, 0, 200, 250);
        // 设置frame
        _errMassageView.center = self.view.center;
        
        // 赋值
        
        // 添加到view上
        [self.view addSubview:_errMassageView];
        
    }
    return _errMassageView;
}

-(UIImageView *)otherErrMassageView
{
    if (_otherErrMassageView ==nil) {
        
        _otherErrMassageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u49"]];
        
        _otherErrMassageView.bounds =CGRectMake(0, 0, 200, 250);
        // 设置frame
        _otherErrMassageView.center = self.view.center;
        
        // 赋值
        
        // 添加到view上
        [self.view addSubview:_otherErrMassageView];
        
//        self.otherErrMassageView.hidden = NO;
    }
    return _otherErrMassageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
#pragma mark - 设置用户名Text
    //创建用户名输入框
    UITextField *userNameText = [[UITextField alloc]initWithFrame:CGRectMake(X, Y, 270, 37)];
    
    //添加clear button
    userNameText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    UIImageView *userNameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"人物"]];
    
    userNameText.borderStyle = UITextBorderStyleRoundedRect;
    userNameText.leftViewMode = UITextFieldViewModeAlways;
    userNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userNameText.leftView = userNameImg;
    userNameText.leftView.frame =CGRectMake(5, 0, 20, 20);
    
    //添加默认文字
    userNameText.placeholder = @"请输入用户姓名";
    
    //    [userNameText layoutSubviews];
    
    //设置背景图片
    userNameText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"u14"]];
    
    //添加到view上
    [self.view addSubview:userNameText];
    
    self.userNameText = userNameText;
    
    
#pragma mark - 设置用户证件号码Text
    //创建用户证件号码输入框
    UITextField *userIDText = [[UITextField alloc]initWithFrame:CGRectMake(X, Y + KMargin + 35, 270, 37)];
    
    UIImageView *userIDImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"请输入验证码左边图标"]];
    
    userIDText.borderStyle = UITextBorderStyleRoundedRect;
    userIDText.leftViewMode = UITextFieldViewModeAlways;
    userIDText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userIDText.leftView = userIDImg;
    
    userIDText.leftView.frame = CGRectMake(5, 0, 20, 20);
    
    //添加默认文字
    userIDText.placeholder = @"请输入用户证件号码";
    
    //设置背景图片
    userIDText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"u14"]];
    
    //添加clear button
    userIDText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.view addSubview:userIDText];
    
    self.userIDTex  = userIDText;
    
    
#pragma mark - 设置手机号码Text
    //创建手机号码输入框
    UITextField *phoneNumText = [[UITextField alloc]initWithFrame:CGRectMake(X, Y + (KMargin + 35) * 2, 270, 37)];
    
    UIImageView *phoneNumImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"电话"]];
    
    phoneNumText.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumText.leftViewMode = UITextFieldViewModeAlways;
    phoneNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneNumText.leftView = phoneNumImg;
    
    phoneNumText.leftView.frame = CGRectMake(10, 0, 20, 20);
    
    //添加默认文字
    phoneNumText.placeholder = @"请输入手机号码";
    
    //设置背景图片
    phoneNumText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"u14"]];
    
    //添加clear button
    phoneNumText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.view addSubview:phoneNumText];
    
    self.phoneNumText = phoneNumText;
    
    
#pragma mark - 设置验证码Text
    //创建验证码输入框
    UITextField *checkNumText = [[UITextField alloc]initWithFrame:CGRectMake(X, Y + (KMargin + 37) * 3, 171, 37)];
    
    
    UIImageView *checkNumImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"请输入证件号码左边图标"]];
    checkNumText.borderStyle = UITextBorderStyleRoundedRect;
    checkNumText.leftViewMode = UITextFieldViewModeAlways;
    checkNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    checkNumText.leftView = checkNumImg;
    checkNumText.leftView.frame = CGRectMake(5, 0, 20, 20);
    
    //添加默认文字
    checkNumText.placeholder = @"请输入验证码";
    
    //设置背景图片
    checkNumText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"u26"]];
    
    //添加clear button
    checkNumText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.view addSubview:checkNumText];
    
    self.checkNumText.delegate = self;
    
    //添加点击事件
    [checkNumText addTarget:self action:@selector(checkNumTextClick) forControlEvents:UIControlEventEditingDidBegin];
    
    self.checkNumText = checkNumText;
    
    
#pragma mark - 设置获取验证码按钮
    //创建获取验证码按钮
    UIButton *receiveCheckNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(checkNumText.frame.origin.x + KMargin + 170, Y + (KMargin + 37) * 3, 90, 37)];
    
    //设置背景图片
    [receiveCheckNumBtn setBackgroundImage:[UIImage imageNamed:@"u30"] forState:UIControlStateNormal];
    
    //设置按钮上的文字
    [receiveCheckNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    //设置按钮文字颜色
    [receiveCheckNumBtn setTitleColor:[UIColor colorWithHexString:backImgColor] forState:UIControlStateNormal];
    
    //设置按钮文字大小
    receiveCheckNumBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    //添加到view上
    [self.view addSubview:receiveCheckNumBtn];
    
    
    
#pragma mark - 设置用户提示
    //用户提示图标
    UIImageView *noticeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(X , receiveCheckNumBtn.frame.origin.y + 57 + KMargin, 20, 20)];
    
    //设置图片
    noticeIcon.image = [UIImage imageNamed:@"获取验证码后面的"];
    
    //添加到view上
    [self.view addSubview:noticeIcon];
    
    //创建用户登录提示文本
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(noticeIcon.frame.origin.x + 30, receiveCheckNumBtn.frame.origin.y + 42 + KMargin, 250, 50)];
    
    //设置文字
    noticeLabel.text = @"请使用医立得平台实名制用户登录";
    
    //设置字体大小
    [noticeLabel setFont:[UIFont systemFontOfSize:15.0]];
    
    //设置字体颜色
    noticeLabel.textColor = [UIColor lightGrayColor];
    
    //添加到view上
    [self.view addSubview:noticeLabel];
    
    
#pragma mark - 设置登录按钮
    //创建登录按钮
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, noticeIcon.frame.origin.y + 37 + KMargin, 250, 37)];
    
    UIImage * currentImg =[UIImage imageNamed:@"按钮背景图片"];
    UIImage * strchImg =
    [currentImg stretchableImageWithLeftCapWidth:currentImg.size.width * 0.5 topCapHeight:currentImg.size.height * 0.5];
    
    //设置背景图片
    [loginBtn setBackgroundImage:strchImg forState:UIControlStateNormal];
    
    //设置按钮文字
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    //设置按钮文字颜色
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 登录按钮点击事件
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //添加到view上
    [self.view addSubview:loginBtn];
    
    // 冲偏好设置加载用户信息
    [self loadUserInfo];
    
    
}



#pragma mark - 从偏好设置加载用户信息
- (void)loadUserInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user objectForKey:kUserNameKey] && [user objectForKey:kCredentialsNumKey] && [user objectForKey:kPhoneNumKey]) {
        
        self.userNameText.text = [user objectForKey:kUserNameKey];
        
        self.userIDTex.text = [user objectForKey:kCredentialsNumKey];
        
        self.phoneNumText.text = [user objectForKey:kPhoneNumKey];
        
        [user synchronize];
        
    }
}

#pragma mark --登录
- (void)loginBtnClick {
    
//    self.otherErrMassageView.hidden = YES;
    
    // 关闭键盘
    [self.view endEditing:YES];
    
#pragma mark - 给用户提示
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    self.HUB =hud;
    // 添加到对应的view
    [self.view addSubview:hud];
    
    // 设置需要显示的文字信息
    hud.labelText = @"登录中...";
    
    // 显示
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
#pragma mark - 登录失败后,提示错误
        hud.mode = MBProgressHUDModeText;
        
        
        [hud hide:YES afterDelay:0.5];
        
        // 添加背景图片
        
        
        [self messageChenk];
        
    });
}

- (void)messageChenk {

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user objectForKey:kUserNameKey] && [user objectForKey:kCredentialsNumKey] && [user objectForKey:kPhoneNumKey]) {
        
        [user synchronize];
    
            if ([self.userNameText.text isEqualToString: [user objectForKey:kUserNameKey]]) {
    
                if ([self.userIDTex.text isEqualToString:[user objectForKey:kCredentialsNumKey]]) {
    
                    if ([self.phoneNumText.text isEqualToString:[user objectForKey:kPhoneNumKey]]) {
    
                        [self CheckNumErr];
                    }else {
    
                        [self PhoneNumCheckErr];
                    }
    
                }else {
    
                    [self IDCheckErr];
                }
    
            }else {
                [self NameCheckErr];
            }
    }
    else
    {
        self.HUB.labelText=@"您还没有注册";
        [self.HUB show:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //跳转到注册页
            EDKRegistViewController *  registerVc=[[EDKRegistViewController alloc] init];
            [self.navigationController pushViewController:registerVc animated:YES];
            
        });
    }
}


- (void)CheckNumErr {
    
    if ([self.checkNumText.text isEqualToString:@"111111"]) {
        
#pragma mark -- 登录成功...
        EDKLog(@"登录成功");
        
        
        UIImageView *successIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u113"]];
        
        successIcon.frame = CGRectMake((self.otherErrMassageView.frame.size.width - 88) * 0.5, (self.otherErrMassageView.frame.size.height - 88) * 0.5, 88, 88);
        
        [self.otherErrMassageView addSubview:successIcon];
        
        
        UILabel *successLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(successIcon.frame) + 20, self.otherErrMassageView.frame.size.width, 50)];
        
        successLabel.text = @"登录成功";
        
        successLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
        
        successLabel.font = [UIFont systemFontOfSize:15.0];
        
        successLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self.otherErrMassageView addSubview:successLabel];
        
        [self performSelector:@selector(hidsuccess) withObject:nil afterDelay:1];
        
    }else {
        EDKLog(@"验证码输入有误");
        
        self.otherErrMassageView.hidden = YES;
    }
    
    
}

#pragma mark -- 在隐藏提示框里 然后跳转到主界面..
- (void)hidsuccess{
    
    self.otherErrMassageView.hidden = YES;
    
    [self saveUserInfo];
    
//    // 创建主页面控制器
//    EDKMainViewController *mainViewController = [[EDKMainViewController alloc]init];
//    
//    // 页面跳转
//    [self.navigationController pushViewController:mainViewController animated:YES];
    
    [self changeRootViewController];
}

#pragma mark --登录成功以后更改控制器..
-(void)changeRootViewController
{
    EDKPersonalMessageController * peronalMessageVc = [[EDKPersonalMessageController alloc] init];
    
    EDKMainViewController * mainVc =[[EDKMainViewController alloc] init];
    
    EDKNavController * navController = [[EDKNavController alloc] initWithRootViewController:mainVc];
    
    MMDrawerController * mmVc= [[MMDrawerController alloc] initWithCenterViewController:navController leftDrawerViewController:peronalMessageVc];
    
    
    [UIApplication sharedApplication].keyWindow.rootViewController =mmVc;

}


#pragma mark - 注册成功保存用户信息 到偏好设置
- (void)saveUserInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:self.userNameText.text forKey:kUserNameKey];
    
    [user setObject:self.userIDTex.text forKey:kCredentialsNumKey];
    
    [user setObject:self.phoneNumText.text forKey:kPhoneNumKey];
    
    //设置登录标识为已登录..
    [user setObject:@(1) forKey:KisLoginFlag];
    
    [user synchronize];
}



#pragma mark - 手机号未绑定
- (void)PhoneNumCheckErr {
    
    // 错误信息
    NSString *errMassage = @"未绑定手机号";
    NSString *errdetail = @"您所填写的证件号码已是114平台的实名注册用户，但未绑定手机号";
    NSString *help = @"请前往北京市预约挂号统一平台填写绑定手机否则无法注册或登录。";
    NSString *resetBtnText = @"重新填写";
    
    self.errMassageView.hidden = NO;
    // 错误信息布局 添加
    UILabel *errMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.errMassageView.frame.size.width, 50)];
    
    // 赋值
    errMassageLabel.text = errMassage;
    
    // 设置字体
    errMassageLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置颜色
    errMassageLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
    
    // 设置居中对齐
    errMassageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 添加
    [self.errMassageView addSubview:errMassageLabel];
    
    
    // 错误详情布局 添加
    UILabel *errdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.errMassageView.frame.size.width, 50)];
    
    // 赋值
    errdetailLabel.text = errdetail;
    
    // 设置字体
    errdetailLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置字体颜色
    errdetailLabel.textColor = [UIColor lightGrayColor];
    
    // 设置换行
    errdetailLabel.numberOfLines = 0;
    
    // 设置左对齐
    errdetailLabel.textAlignment = NSTextAlignmentLeft;
    
    //添加
    [self.errMassageView addSubview:errdetailLabel];
    
    
    // 帮助信息 布局
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.errMassageView.frame.size.width, 50)];
    
    // 赋值
    helpLabel.text = help;
    
    // 设置字体大小
    helpLabel.font = [UIFont systemFontOfSize:15.0];
    
    //设置字体颜色
    helpLabel.textColor = [UIColor lightGrayColor];
    
    // 设置行数
    helpLabel.numberOfLines = 0;
    
    // 设置左对齐
    helpLabel.textAlignment = NSTextAlignmentLeft;
    
    // 添加
    [self.errMassageView addSubview:helpLabel];
    
    
    CGFloat BtnX = self.errMassageView.frame.size.width * 0.5 - 68;
    
    
    // 重新输入手机号按钮 布局 添加
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(BtnX, 170 , 136, 36)];
    
    // 设置按钮文字
    [resetBtn setTitle:resetBtnText forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [resetBtn setBackgroundImage:[UIImage imageNamed:@"u89"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.errMassageView  addSubview:resetBtn];
    
    // 打开用户交互
    self.errMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [resetBtn addTarget:self action:@selector(resetPhoneNumClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)resetPhoneNumClick {
    
    EDKLog(@"重新输入");
    
    self.errMassageView.hidden = YES;
    
}


#pragma mark - 证件号没有注册
- (void)IDCheckErr {
    
    // 错误信息
    NSString *errMassage = @"登录失败";
    NSString *errdetail = @"您所填写的用户未在114平台实名制注册。";
    NSString *registNewUser = @"注册新用户";
    NSString *resetBtnText = @"重新填写";
    
    self.otherErrMassageView.hidden = NO;
    // 错误信息布局 添加
    UILabel *errMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.otherErrMassageView.frame.size.width, 70)];
    
    // 赋值
    errMassageLabel.text = errMassage;
    
    // 设置字体
    errMassageLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置颜色
    errMassageLabel.textColor = [UIColor lightGrayColor];
    
    // 设置居中对齐
    errMassageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 添加
    [self.otherErrMassageView addSubview:errMassageLabel];
    
    
    // 错误详情布局 添加
    UILabel *errdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,70, self.otherErrMassageView.frame.size.width, 70)];
    
    // 赋值
    errdetailLabel.text = errdetail;
    
    // 设置字体
    errdetailLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置字体颜色
    errdetailLabel.textColor = [UIColor lightGrayColor];
    
    // 设置换行
    errdetailLabel.numberOfLines = 0;
    
    // 设置左对齐
    errdetailLabel.textAlignment = NSTextAlignmentLeft;
    
    //添加
    [self.otherErrMassageView addSubview:errdetailLabel];
    
    
    CGFloat BtnX = (self.otherErrMassageView.frame.size.width - 198) / 3;
    
    // 注册新用户按钮 布局 添加
    UIButton *registNewUserBtn = [[UIButton alloc]initWithFrame:CGRectMake(BtnX,160, 99, 36)];
    
    // 设置按钮文字
    [registNewUserBtn setTitle:registNewUser forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [registNewUserBtn setBackgroundImage:[UIImage imageNamed:@"u107"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [registNewUserBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.otherErrMassageView addSubview:registNewUserBtn];
    
    // 打开用户交互
    self.otherErrMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [registNewUserBtn addTarget:self action:@selector(registNewUserBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // 重新输入按钮 布局 添加
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(2 * BtnX + 99,160, 99, 36)];
    
    // 设置按钮文字
    [resetBtn setTitle:resetBtnText forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [resetBtn setBackgroundImage:[UIImage imageNamed:@"u105"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.otherErrMassageView addSubview:resetBtn];
    
    // 打开用户交互
    self.otherErrMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [resetBtn addTarget:self action:@selector(IDResetClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)IDResetClick {
    
    EDKLog(@"请重新填写");
    
    self.otherErrMassageView.hidden = YES;
    
}

- (void)registNewUserBtnClick {
    
    EDKRegistViewController *registVc = [[EDKRegistViewController alloc] init];
    
    [self.navigationController pushViewController:registVc animated:YES];
    
    self.otherErrMassageView.hidden = YES;
    
}


#pragma mark - 姓名不匹配
- (void)NameCheckErr {
    
    // 错误信息
    NSString *errMassage = @"用户姓名错误";
    NSString *errdetail = @"您所填写的用户姓名与114平台用户姓名不匹配";
    NSString *resetBtnText = @"重新填写姓名";
    
    self.otherErrMassageView.hidden = NO;
    // 错误信息布局 添加
    UILabel *errMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.otherErrMassageView.frame.size.width, 70)];
    
    // 赋值
    errMassageLabel.text = errMassage;
    
    // 设置字体
    errMassageLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置颜色
    errMassageLabel.textColor = [UIColor lightGrayColor];
    
    // 设置居中对齐
    errMassageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 添加
    [self.otherErrMassageView addSubview:errMassageLabel];
    
    
    // 错误详情布局 添加
    UILabel *errdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,70, self.otherErrMassageView.frame.size.width, 70)];
    
    // 赋值
    errdetailLabel.text = errdetail;
    
    // 设置字体
    errdetailLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置字体颜色
    errdetailLabel.textColor = [UIColor lightGrayColor];
    
    // 设置换行
    errdetailLabel.numberOfLines = 0;
    
    // 设置左对齐
    errdetailLabel.textAlignment = NSTextAlignmentLeft;
    
    //添加
    [self.otherErrMassageView addSubview:errdetailLabel];
    
    
    CGFloat BtnX = self.otherErrMassageView.frame.size.width * 0.5 - 68;
    
    // 重新输入手机号按钮 布局 添加
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(BtnX,160, 136, 36)];
    
    // 设置按钮文字
    [resetBtn setTitle:resetBtnText forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [resetBtn setBackgroundImage:[UIImage imageNamed:@"u89"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.otherErrMassageView addSubview:resetBtn];
    
    // 打开用户交互
    self.otherErrMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [resetBtn addTarget:self action:@selector(nameResetClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)nameResetClick {
    
    EDKLog(@"请重新填写姓名");
    
    self.otherErrMassageView.hidden = YES;
    
}

#pragma mark - 获取验证码点击事件
- (void)checkNumTextClick{
    
    NSString *mobileNum = self.phoneNumText.text;
    
    BOOL isNumber = [self isMobileNumber:mobileNum];
    
    if ( isNumber) {
        
        EDKLog(@"手机号输入正确");
        
    } else {
        
        EDKLog(@"手机号输入错误");
        [self MobileNumberCheckErr];
    }
}

- (void)MobileNumberCheckErr {
    
    // 关闭键盘
    [self.view endEditing:YES];
    
#pragma mark - 给用户提示
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    // 添加到对应的view
    [self.view addSubview:hud];
    
    // 设置需要显示的文字信息
    hud.labelText = @"登录中...";
    //    hud.dimBackground = YES;
    // 4.显示
    [hud show:YES];
    
    // 可以模拟延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        EDKLog(@"手机号码输入错误");
        
#pragma mark - 登录失败后,提示错误
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:0.5];
        
        // 添加背景图片
        UIImageView *errMassageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u49"]];
        
        // 设置frame
        errMassageView.center = self.view.center;
        
        // 赋值
        self.errMassageView = errMassageView;
        
        // 添加到view上
        [self.view addSubview:errMassageView];
        
        // 手机号错误时执行的方法
        [self CheckNumClick];
        
        
    });
}

#pragma mark - 登手机号错误时执行的方法
- (void)CheckNumClick{
    
    // 错误信息
    NSString *errMassage = @"绑定手机错误";
    NSString *errdetail = @"您所填写的手机号不是114平台实名制用户的绑定手机";
    NSString *help = @"请前往北京市预约挂号统一平台修改手机号或填写其他手机号";
    NSString *resetBtnText = @"重新填写手机号";
    
    // 错误信息布局 添加
    //    UILabel *errMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.errMassageView.frame.origin.x, self.errMassageView.frame.origin.y, self.errMassageView.frame.size.width, 50)];
    
    UILabel *errMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.errMassageView.frame.size.width, 50)];
    // 赋值
    errMassageLabel.text = errMassage;
    
    // 设置字体
    errMassageLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置颜色
    errMassageLabel.textColor = [UIColor lightGrayColor];
    
    // 设置居中对齐
    errMassageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 添加
    [self.errMassageView addSubview:errMassageLabel];
    
    
    // 错误详情布局 添加
    UILabel *errdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.errMassageView.frame.size.width, 50)];
    
    // 赋值
    errdetailLabel.text = errdetail;
    
    // 设置字体
    errdetailLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置字体颜色
    errdetailLabel.textColor = [UIColor lightGrayColor];
    
    // 设置换行
    errdetailLabel.numberOfLines = 0;
    
    // 设置左对齐
    errdetailLabel.textAlignment = NSTextAlignmentLeft;
    
    //添加
    [self.errMassageView addSubview:errdetailLabel];
    
    
    // 帮助信息 布局
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.errMassageView.frame.size.width, 50)];
    
    // 赋值
    helpLabel.text = help;
    
    // 设置字体大小
    helpLabel.font = [UIFont systemFontOfSize:15.0];
    
    //设置字体颜色
    helpLabel.textColor = [UIColor lightGrayColor];
    
    // 设置行数
    helpLabel.numberOfLines = 0;
    
    // 设置左对齐
    helpLabel.textAlignment = NSTextAlignmentLeft;
    
    // 添加
    [self.errMassageView addSubview:helpLabel];
    
    
    CGFloat BtnX = self.errMassageView.frame.size.width * 0.5 - 68;
    
    
    // 重新输入手机号按钮 布局 添加
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(BtnX, 170 , 136, 36)];
    
    // 设置按钮文字
    [resetBtn setTitle:resetBtnText forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [resetBtn setBackgroundImage:[UIImage imageNamed:@"u89"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.errMassageView addSubview:resetBtn];
    
    // 打开用户交互
    self.errMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)resetBtnClick {
    
    EDKLog(@"请重新填写手机号");
    
    self.errMassageView.hidden = YES;
    
}



#pragma mark - 判断是否为手机号
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}




- (instancetype)init {
    
//    添加返回按钮的图片并且显示
    UIImage *image = [UIImage imageNamed:@"返回箭头"];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    添加左侧"返回"按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置title
    self.title = @"用户登录";
    
    //添加右侧"快速注册"按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"快速注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    return self;
}

//左侧返回按钮的点击事件
- (void)leftBarButtonItemClick {
    
    
    EDKMainViewController *MainVc = [[EDKMainViewController alloc] init];

    [self.navigationController pushViewController:MainVc animated:YES];
}

//右侧快速注册的点击事件
- (void)rightBarButtonItemClick {
    
    // 加载注册ViewController
    EDKRegistViewController *registVc = [[EDKRegistViewController alloc] init];
    
    // 跳转页面
    [self.navigationController pushViewController:registVc animated:YES];
    
}



@end
