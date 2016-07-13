//
//  EDKAlreadySubmitCheck.m
//  EDKProj
//
//  Created by 张帅 on 16/3/30.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKAlreadySubmitCheck.h"

#import "EDKPersonalMessageController.h"
#import "EDKNavController.h"
#import "EDKMainViewController.h"
#import "MMDrawerController.h"

@interface EDKAlreadySubmitCheck ()

@end

@implementation EDKAlreadySubmitCheck

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)changeRootViewController
{
    EDKPersonalMessageController * personVc =[[EDKPersonalMessageController alloc] init];
    
    EDKMainViewController * mainVc =[[EDKMainViewController alloc] init];
    EDKNavController * navController = [[EDKNavController alloc] initWithRootViewController:mainVc];
    
    MMDrawerController * mmvc =[[MMDrawerController alloc] initWithCenterViewController:navController leftDrawerViewController:personVc];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = mmvc;
}

//跳转到首页
- (IBAction)clickToBackToHomePage:(UIButton *)sender {
//    MMDrawerController * mmVc=(MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [mmVc closeDrawerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [self changeRootViewController];
}
//跳转到个人中心
- (IBAction)clickBackToPersonalCenter:(UIButton *)sender {
    
    //切换根控制器
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [self changeRootViewController];
    
}


@end
