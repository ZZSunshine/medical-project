//
//  EDKRegistViewController.m
//  EDKProj
//

#import "EDKRegistViewController.h"
#import "reguestView.h"
#import "EDKMessageCheckViewController.h"
#import "UIColor+Hex.h"
#import "EDKLoginViewController.h"

#import "TPKeyboardAvoidingScrollView.h"

#define Y 84
#define X 22
#define KMargin 20
#define kUserNameKey @"usernamekey"
#define kCredentialsNumKey @"credentialsnumkey"
#define kPhoneNumKey @"phonenumkey"



@interface EDKRegistViewController ()


/* 用户名 */
@property (nonatomic, strong)UITextField *userNameText;
/* 性别 */
@property (nonatomic, copy)NSString *genderLabel;
/* 证件号码 */
@property (nonatomic, strong)UITextField *userIDTex;
/* 现居住地 */
@property (nonatomic, strong)UITextField *liveAddressTex;
/* 手机号码 */
@property (nonatomic, strong)UITextField *phoneNumText;
/* 验证码 */
@property (nonatomic, strong)UITextField *checkNumText;
/** 错误提示View */
@property (nonatomic, strong)UIImageView *errMassageView;

@property (nonatomic,strong) TPKeyboardAvoidingScrollView *subScrollView;

@property (nonatomic,weak) UILabel * noticeLabel;
@end

@implementation EDKRegistViewController

#pragma mark 懒加载
- (TPKeyboardAvoidingScrollView *)subScrollView {
    
    if (!_subScrollView) {
        
        _subScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    }
    return _subScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1
    [self.view addSubview:self.subScrollView];
    
    // Tabar 布局
    [self setUpTabarUI];
    
    // 布局MainUI
    [self setUpMainUI];

    
}
#pragma mark - 登录页面布局
- (void)setUpMainUI {

    //创建真实姓名输入框
    UITextField *userNameText = [[UITextField alloc]initWithFrame:CGRectMake(X, Y, 217, 43)];
    
    // 设置leftView图片
    UIImageView *userNameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户"]];
    
    userNameText.borderStyle = UITextBorderStyleRoundedRect;
    
    userNameText.leftViewMode = UITextFieldViewModeAlways;
    
    userNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    userNameText.leftView = userNameImg;
    
    userNameText.leftView.frame = CGRectMake(0, 0, 20, 20);
    
    //添加默认文字
    userNameText.placeholder = @"请输入真实姓名";
    
    //设置背景图片
    userNameText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"g16"]];
    
    //添加clear button
    userNameText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.subScrollView addSubview:userNameText];
    
    // 赋值
    self.userNameText  = userNameText;
    
    // 创建性别显示View
    UIImageView *genderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"g22" ]];
    
    // 设置背景颜色
//    genderView.backgroundColor  = [UIColor redColor];
    
    // 设置frame
    genderView.frame = CGRectMake(X + userNameText.frame.size.width, Y, 113, 43);
    
    // 添加到view上
    [self.subScrollView addSubview:genderView];
    
    
    //创建用户证件号码输入框
    UILabel *genderLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 50, 43)];
    
//    UIImageView *genderTextImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xxxxx"]];
//    userIDText.borderStyle = UITextBorderStyleRoundedRect;
//    
//    userIDText.leftViewMode = UITextFieldViewModeAlways;
//    
//    userIDText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    
//    userIDText.leftView = userIDImg;
    
    //添加默认文字
    genderLabel.text = @"先生";
    
    // 文字居中
    genderLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置背景颜色
//    genderLabel.backgroundColor = [UIColor redColor];
    
    //添加到view上
    [genderView addSubview:genderLabel];
    
    self.genderLabel = genderLabel.text;
    
    // 下拉箭头设置
    UIButton *chooseIcon = [[UIButton alloc] initWithFrame:CGRectMake(40 + genderLabel.frame.size.width, 18, 12, 7)];
    
    // 添加图片
    [chooseIcon setBackgroundImage:[UIImage imageNamed:@"g50" ] forState:UIControlStateNormal];

    //添加到view上
    [genderView addSubview:chooseIcon];
    
    // 打开用户交互
    genderView.userInteractionEnabled = YES;
    
    
    
    
    
    
    
    //创建有效证件号码输入框
    UITextField *userIDText = [[UITextField alloc]initWithFrame:CGRectMake(X, Y + KMargin + 43, 217, 43)];
    
    UIImageView *userIDImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"请输入证件号码左边图标"]];
    
    userIDText.borderStyle = UITextBorderStyleRoundedRect;
    
    userIDText.leftViewMode = UITextFieldViewModeAlways;
    
    userIDText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    userIDText.leftView = userIDImg;
    
    userIDText.leftView.frame = CGRectMake(5, 0, 20, 20);
    
    //添加默认文字
    userIDText.placeholder = @"请输入有效证件号码";
    
    //设置背景图片
    userIDText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"g16"]];
    
    //添加clear button
    userIDText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.subScrollView addSubview:userIDText];
    
    self.userIDTex  = userIDText;
    
    
    UIImageView *IDView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"g22" ]];
    
//    IDView.backgroundColor  = [UIColor redColor];
    
    IDView.frame = CGRectMake(X + userIDText.frame.size.width, Y + KMargin + 43, 113, 43);
    
    [self.subScrollView addSubview:IDView];
    
    
    //创建用户证件号码输入框
    UILabel *IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 43)];
    
    //    UIImageView *genderTextImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xxxxx"]];
    //    userIDText.borderStyle = UITextBorderStyleRoundedRect;
    //
    //    userIDText.leftViewMode = UITextFieldViewModeAlways;
    //
    //    userIDText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //
    //    userIDText.leftView = userIDImg;
    
    //添加默认文字
    IDLabel.text = @"身份证";
    
    IDLabel.textAlignment = NSTextAlignmentCenter;
    
//    IDLabel.backgroundColor = [UIColor redColor];
    
    //添加到view上
    [IDView addSubview:IDLabel];
    
    
    UIButton *IDchooseIcon = [[UIButton alloc] initWithFrame:CGRectMake(90, 18, 12, 7)];
    
    [IDchooseIcon setBackgroundImage:[UIImage imageNamed:@"g50" ] forState:UIControlStateNormal];
    
    //添加到view上
    [IDView addSubview:IDchooseIcon];
    
    IDView.userInteractionEnabled = YES;
    
    
    
    
    
    
#pragma mark - 设置现居住地址输入框
    
    //创建现居住地址输入框
    UITextField *liveAddressTex = [[UITextField alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(self.userIDTex.frame) + KMargin, 330, 43)];
    
    // 设置leftView图片
    UIImageView *liveAddressImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位"]];
    
    liveAddressTex.borderStyle = UITextBorderStyleRoundedRect;
    
    liveAddressTex.leftViewMode = UITextFieldViewModeAlways;
    
    liveAddressTex.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    liveAddressTex.leftView = liveAddressImg;
    
    liveAddressTex.leftView.frame = CGRectMake(0, 0, 20, 20);
    //添加默认文字
    liveAddressTex.placeholder = @"请选择现居地址";
    
    //设置背景图片
    liveAddressTex.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"g14"]];
    
    //添加clear button
    liveAddressTex.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.subScrollView addSubview:liveAddressTex];
    
    // 赋值
    self.liveAddressTex  = liveAddressTex;
    
    // 创建分隔线
    UIImageView *separateLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"g90_line" ]];
    
    // 设置分割线frame
    separateLine.frame = CGRectMake(CGRectGetMaxX(self.liveAddressTex.frame) - 60, CGRectGetMinY(self.liveAddressTex.frame) + 4, 1, 35);
    
    // 添加到view上
    [self.subScrollView addSubview:separateLine];
    
    
    UIButton *AddressChooseIcon = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(separateLine.frame) + 19, CGRectGetMinY(self.liveAddressTex.frame) + 11, 22, 22)];
    
    [AddressChooseIcon setBackgroundImage:[UIImage imageNamed:@"g88" ] forState:UIControlStateNormal];
    
    //添加到view上
    [self.subScrollView addSubview:AddressChooseIcon];
    
    self.view.userInteractionEnabled = YES;
    
    
    
    
    
#pragma mark - 设置手机号码输入框
    
    //创建手机号码输入框
    UITextField *phoneNumText = [[UITextField alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(self.liveAddressTex.frame) + KMargin, 330, 43)];
    
    // 设置leftView图片
    UIImageView *phoneNumImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"电话"]];
    
    phoneNumText.borderStyle = UITextBorderStyleRoundedRect;
    
    phoneNumText.leftViewMode = UITextFieldViewModeAlways;
    
    phoneNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    phoneNumText.leftView = phoneNumImg;
    
    phoneNumText.leftView.frame = CGRectMake(0, 0, 20, 20);
    //添加默认文字
    phoneNumText.placeholder = @"请输入手机号码";
    
    //设置背景图片
    phoneNumText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"g14"]];
    
    //添加clear button
    phoneNumText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.subScrollView addSubview:phoneNumText];
    
    // 赋值
    self.phoneNumText  = phoneNumText;
    
    
#pragma mark - 设置验证码输入框
    
    //创建验证码输入框
    UITextField *checkNumText = [[UITextField alloc]initWithFrame:CGRectMake(X, CGRectGetMaxY(self.phoneNumText.frame) + KMargin, 207, 43)];
    
    // 设置leftView图片
    UIImageView *checkNumImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"请输入验证码左边图标"]];
    
    checkNumText.borderStyle = UITextBorderStyleRoundedRect;
    
    checkNumText.leftViewMode = UITextFieldViewModeAlways;
    
    checkNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    checkNumText.leftView = checkNumImg;
    
    checkNumText.leftView.frame = CGRectMake(5, 0, 20, 20);
    
    //添加默认文字
    checkNumText.placeholder = @"请输入验证码";
    
    //设置背景图片
    checkNumText.backgroundColor = [UIColor colorWithPatternImage:[ UIImage imageNamed:@"g16"]];
    
    //添加clear button
    checkNumText.clearButtonMode =  UITextFieldViewModeWhileEditing;
    
    //添加到view上
    [self.subScrollView addSubview:checkNumText];
    
    self.checkNumText  = checkNumText;
    
    
#pragma mark - 设置获取验证码按钮
    
    // 创建获取验证码按钮 布局
    UIButton *CheckNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(checkNumText.frame) + 10, CGRectGetMaxY(self.phoneNumText.frame) + KMargin, 113, 43)];
    
    // 设置背景图片
    [CheckNumBtn setBackgroundImage:[UIImage imageNamed:@"g22" ] forState:UIControlStateNormal];
    
    // 设置按钮文字
    [CheckNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    CheckNumBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    // 设置按钮文字颜色
    [CheckNumBtn setTitleColor:[UIColor colorWithHexString:backImgColor] forState:UIControlStateNormal];
    
    //添加到view上
    [self.subScrollView addSubview:CheckNumBtn];
    

    
#pragma mark - 设置用户提示
    //用户提示图标
    UIButton *agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(X + 40,  CGRectGetMaxY(self.checkNumText.frame) + KMargin + 16, 20, 20)];
    
    //设置图片
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"没选中状态"] forState:UIControlStateNormal];
    
    //agreeBtn.selected = !agreeBtn.selected;
   
    
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"选中对勾"] forState:UIControlStateSelected];
    
    
     agreeBtn.selected =YES;
    
    [agreeBtn addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    //添加到view上
    [self.subScrollView addSubview:agreeBtn];
    
    
    //创建用户登录提示文本
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(  CGRectGetMaxX(agreeBtn.frame) + 5,CGRectGetMaxY(self.checkNumText.frame) + KMargin, 250, 50) ];
    self.noticeLabel =noticeLabel;
    //设置文字
    noticeLabel.text = @"本人已阅读并同意用户协议";
    
    //设置字体大小
    [noticeLabel setFont:[UIFont systemFontOfSize:15.0]];
    
    //设置字体颜色
    noticeLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    //添加到view上
    [self.subScrollView addSubview:noticeLabel];
    
    
#pragma mark - 设置登录按钮
    //创建登录按钮
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, CGRectGetMaxY(noticeLabel.frame) + KMargin, 330, 43)];
    
    UIImage * currentImg =[UIImage imageNamed:@"按钮背景图片"];
    UIImage * strchImg =
    [currentImg stretchableImageWithLeftCapWidth:currentImg.size.width * 0.5 topCapHeight:currentImg.size.height * 0.5];
    
    //设置背景图片
    [registBtn setBackgroundImage:strchImg forState:UIControlStateNormal];
    
    
    //设置按钮文字
    [registBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    //设置按钮文字颜色
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 注册按钮点击事件
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到view上
    [self.subScrollView addSubview:registBtn];

}

-(void)agreeClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        
        self.noticeLabel.textColor=[UIColor colorWithHexString:backImgColor];
    }
    else
    {
        self.noticeLabel.textColor =[UIColor lightGrayColor];
    }
   
    
}

#pragma mark - 设置下一步按钮

- (void)registBtnClick {

    EDKMessageCheckViewController *messageCheck = [[EDKMessageCheckViewController alloc]init];
    
    messageCheck.nameValue = self.userNameText.text;
    
    messageCheck.credentialsTypeValue = self.userIDTex.text;
    
    messageCheck.credentialsTypeValue = @"身份证";

    messageCheck.credentialsNumValue = self.userIDTex.text;
    
    messageCheck.phoneNumValue = self.phoneNumText.text;
    
    messageCheck.liveAddressValue = @"帝都";
    
    messageCheck.genderValue = self.genderLabel;

    // 添加背景图片
    UIImageView *errMassageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u49"]];
    
    // 设置frame
    errMassageView.center = self.view.center;
    
    // 赋值
    self.errMassageView = errMassageView;
    
    // 添加到view上
    [self.view addSubview:errMassageView];
    
    // 判断证件号码是否已经注册
    if (self.userIDTex.text.length <= 0 ) {
        
        // 证件号码错误
        [self credentialsNumErr];
        
    }else {
  
        //        // 判断手机号是否为空
        //        if ([self.phoneNumText.text isEqualToString:@""]) {
        //
        //            [self tiePhoneNumErr];
        //        }
        
        if (self.phoneNumText.text.length <= 0) {
            
            // 绑定手机错误
            [self phoneNumErr];
            
        }else {
            
            // 跳转页面
            [self.navigationController pushViewController:messageCheck animated:YES];
            
            // 隐藏errMassageView
            self.errMassageView.hidden = YES;
        }
        
        
    }
}

//#pragma mark - 未绑定手机号错误
//- (void)tiePhoneNumErr {
//
//
//}


#pragma mark - 证件号码错误
- (void)credentialsNumErr {

    
    // 错误信息
    NSString *errMassage = @"证件号码错误";
    NSString *errdetail = @"请输入真实有效的用户证件号码";
    NSString *login = @"登录";
    NSString *resetcredentialsNumBtnText = @"重新填写";
    
    // 错误信息布局 添加
    UILabel *credentialsNumErrMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.errMassageView.frame.size.width, 70)];
    
    // 赋值
    credentialsNumErrMassageLabel.text = errMassage;
    
    // 设置字体
    credentialsNumErrMassageLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置颜色
    credentialsNumErrMassageLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
    
    // 设置居中对齐
    credentialsNumErrMassageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 添加
    [self.errMassageView addSubview:credentialsNumErrMassageLabel];
    
    
    // 错误详情布局 添加
    UILabel *credentialsNumErrdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,70, self.errMassageView.frame.size.width, 70)];
    
    // 赋值
    credentialsNumErrdetailLabel.text = errdetail;
    
    // 设置字体
    credentialsNumErrdetailLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置字体颜色
    credentialsNumErrdetailLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
    
    // 设置换行
    credentialsNumErrdetailLabel.numberOfLines = 0;
    
    // 设置左对齐
    credentialsNumErrdetailLabel.textAlignment = NSTextAlignmentLeft;
    
    //添加
    [self.errMassageView addSubview:credentialsNumErrdetailLabel];
    
    
    CGFloat BtnX = (self.errMassageView.frame.size.width - 198) / 3;
    
#pragma mark - 证件号码错误时 登录按钮
    
    // 登录按钮 布局 添加
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(BtnX,160, 99, 36)];
    
    // 设置按钮文字
    [loginBtn setTitle:login forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"u107"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [loginBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.errMassageView addSubview:loginBtn];
    
    // 打开用户交互
    self.errMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 证件号码错误时 重新输入按钮
    
    // 重新输入按钮 布局 添加
    UIButton *resetCredentialsNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(2 * BtnX + 99,160, 99, 36)];
    
    // 设置按钮文字
    [resetCredentialsNumBtn setTitle:resetcredentialsNumBtnText forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [resetCredentialsNumBtn setBackgroundImage:[UIImage imageNamed:@"u105"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [resetCredentialsNumBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.errMassageView addSubview:resetCredentialsNumBtn];
    
    // 添加点击事件
    [resetCredentialsNumBtn addTarget:self action:@selector(resetCredentialsNumClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)resetCredentialsNumClick {
    
    EDKLog(@"请重新填写");
    
    self.errMassageView.hidden = YES;
    
}

- (void)loginBtnClick {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:nil forKey:kUserNameKey];
    
    [user setObject:nil forKey:kCredentialsNumKey];
    
    [user setObject:nil forKey:kPhoneNumKey];
    
    [user synchronize];
    
    
    self.errMassageView.hidden = YES;
    
    EDKLoginViewController *LoginVc = [[EDKLoginViewController alloc] init];
    
    [self.navigationController pushViewController:LoginVc animated:YES];
    
}




#pragma mark - 绑定手机错误

- (void)phoneNumErr {
    
    // 错误信息
    NSString *errMassage = @"绑定手机错误";
    NSString *errdetail = @"请输入正确的手机号码";
    NSString *resetBtnText = @"重新填写手机号";
    
    // 错误信息布局 添加
    UILabel *phoneNumErrMassageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.errMassageView.frame.size.width, 70)];
    
    // 赋值
    phoneNumErrMassageLabel.text = errMassage;
    
    // 设置字体
    phoneNumErrMassageLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置颜色
    phoneNumErrMassageLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
    
    // 设置居中对齐
    phoneNumErrMassageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 添加
    [self.errMassageView addSubview:phoneNumErrMassageLabel];
    
    
    // 错误详情布局 添加
    UILabel *phoneNumErrdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,70, self.errMassageView.frame.size.width, 70)];
    
    // 赋值
    phoneNumErrdetailLabel.text = errdetail;
    
    // 设置字体
    phoneNumErrdetailLabel.font = [UIFont systemFontOfSize:15.0];
    
    // 设置字体颜色
    phoneNumErrdetailLabel.textColor = [UIColor colorWithHexString:@"09D7FF"];
    
    // 设置换行
    phoneNumErrdetailLabel.numberOfLines = 0;
    
    // 设置左对齐
    phoneNumErrdetailLabel.textAlignment = NSTextAlignmentLeft;
    
    //添加
    [self.errMassageView addSubview:phoneNumErrdetailLabel];
    
    
    CGFloat BtnX = self.errMassageView.frame.size.width * 0.5 - 68;
    
    // 重新输入手机号按钮 布局 添加
    UIButton *resetPhoneNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(BtnX,160, 136, 36)];
    
    // 设置按钮文字
    [resetPhoneNumBtn setTitle:resetBtnText forState:UIControlStateNormal];
    
    // 设置按钮的背景颜色
    [resetPhoneNumBtn setBackgroundImage:[UIImage imageNamed:@"u89"] forState:UIControlStateNormal];
    
    // 设置文字颜色
    [resetPhoneNumBtn setTitleColor:[UIColor colorWithHexString:@"09D7FF"] forState:UIControlStateNormal];
    
    // 添加
    [self.errMassageView addSubview:resetPhoneNumBtn];
    
    // 打开用户交互
    self.errMassageView.userInteractionEnabled = YES;
    
    // 添加点击事件
    [resetPhoneNumBtn addTarget:self action:@selector(resetPhoneNumClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)resetPhoneNumClick {
    
    EDKLog(@"请重新填写姓名");
    
    self.errMassageView.hidden = YES;
    
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"1/2" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)leftBarButtonItemClick {

    // 返回登录页
//    [self.navigationController popViewControllerAnimated:YES];
    
    EDKLoginViewController *LoginVc = [[EDKLoginViewController alloc] init];
    
    [self.navigationController pushViewController:LoginVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
