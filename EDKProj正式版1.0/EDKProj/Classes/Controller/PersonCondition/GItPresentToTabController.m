//
//  GItPresentToTabController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "GItPresentToTabController.h"
#import "DCPaymentView.h"
#import "MBProgressHUD.h"
#import "GitSendFinishedController.h"

@interface GItPresentToTabController ()<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblSendDoctorName;
@property (weak, nonatomic) IBOutlet UIButton *btnAilPay;
@property (weak, nonatomic) IBOutlet UIButton *btnWeChatPay;

@property (weak, nonatomic) IBOutlet UILabel *lblSendFee;
@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic,strong) UIButton * btnConfirmPay;

@end

@implementation GItPresentToTabController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title=@"答谢医生";
    
    UIView * footerView =[[UIView alloc] initWithFrame:CGRectMake(0, 300, KWidth, 300)];
    
    self.btnConfirmPay = [[UIButton alloc] initWithFrame:CGRectMake((footerView.width - 200) * 0.5, 50, 200, 40)];
    [self.btnConfirmPay setTitle:@"支付" forState:UIControlStateNormal];
    
    [self.btnConfirmPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnConfirmPay setBackgroundColor:[UIColor colorWithHexString:backImgColor]];
    
    self.btnConfirmPay.layer.cornerRadius =  self.btnConfirmPay.height /5;
    self.btnConfirmPay.layer.masksToBounds = YES;
    
    [footerView addSubview:self.btnConfirmPay];
    
    //添加点击事件..
    [self.btnConfirmPay addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    //footerView.backgroundColor =EDKRandomColor;
    
    
    //创建尾部视图
    self.tableView.tableFooterView = footerView;
    
    self.btnAilPay.selected = YES;
    self.selectBtn = self.btnAilPay;
    
    [self loadData];
    
}


-(void)loadData
{
    NSString * doctorName=self.parmaters[@"doctorName"];
    
    self.lblSendDoctorName.text =[NSString stringWithFormat:@"赠送给%@医生",doctorName];
    
    NSNumber * fee=self.parmaters[@"fee"];
    self.lblSendFee.text = [NSString stringWithFormat:@"￥%@,00",fee];
    
    
}


#pragma mark --代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中的时候改变状态
    if (self.selectBtn) {
        self.selectBtn.selected =NO;
    }
    
    if (indexPath.row ==3) {
        
        self.btnAilPay.selected =YES;
        self.selectBtn = self.btnAilPay;
    }
    else if (indexPath.row ==4)
    {
        self.btnWeChatPay.selected = YES;
        self.selectBtn = self.btnWeChatPay;
    }
    
    
}


-(void)confirmClick
{
    //跳转到支付成功画面...
    
    
    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
    payAlert.title = @"请输入支付密码";
    
 
    if (self.btnAilPay.selected) {
        payAlert.detail = @"支付宝支付";
    }
    else
    {
        payAlert.detail = @"微信宝支付";
    }

    payAlert.amount= [self.parmaters[@"fee"] floatValue];
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        
        //输入密码以后跳转到指定的画面...
        if ([inputPwd isEqualToString:@"123456"]) {
            
             //密码正确
            //跳转到支付成功画面..

            
            MBProgressHUD*  HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
                
            HUD.delegate = self;
            HUD.labelText = @"支付成功";
            
            [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
            
            
        }
        else
        {
            //弹出提示框。密码错误
            UIAlertController * alertVc= [UIAlertController alertControllerWithTitle:@"提示" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertVc addAction:action];
            
            [self presentViewController:alertVc animated:YES completion:nil];
        }
        
        //NSLog(@"密码是%@",inputPwd);
    };
    
}


- (void)myTask {
    
    //[NSThread sleepForTimeInterval:1];
    
    //真正的是发送网络请求。给支付宝或者微信...
    
    //发送请求后跳转
    //创建控制器  延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        GitSendFinishedController * finshVc =[[GitSendFinishedController alloc] initWithNibName:@"GitSendFinishedController" bundle:nil];
        
        finshVc.parmaters =self.parmaters;
        
        [self.navigationController pushViewController:finshVc animated:YES];
        

    });
    
    
    //EDKLog(@"画面跳转");
    
}


#pragma mark ---HUD代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud {

    [hud removeFromSuperview];
    hud = nil;
}










@end
