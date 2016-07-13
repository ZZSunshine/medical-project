//
//  PersonalMessageController.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#import "EDKPersonalMessageController.h"
#import "EDKhomePageHeaderView.h"
#import "EDKMaterialSetViewController.h"
#import "EDKRegisterController.h"
#import "EDKApplysController.h"
#import "EDKPayBillController.h"
#import "EDKSetHelpController.h"
#import "EDKIdeaFeedbackController.h"
#import "EDKCollectController.h"
#import "EDKMedicalCaseViewController.h"
#import "MMDrawerController.h"
#import "EDKNavController.h"
#import "MMDrawerController.h"
#define kUserNameKey @"usernamekey"


@interface EDKPersonalMessageController ()<EDKhomePageHeaderViewPushViewControllerDelegate,cancelBtnPushViewControllerDelegate>

@end

@implementation EDKPersonalMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EDKhomePageHeaderView *headerView = [[EDKhomePageHeaderView alloc] init];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kUserNameKey];

    headerView.nameLabel.text = username;
    self.tableView.tableHeaderView = headerView ;
    headerView.delegate = self ;
    headerView.delegate2 = self ;
    
    headerView.imageHeader.layer.cornerRadius = 35 ;
    headerView.imageHeader.clipsToBounds = YES ;
    
    //分割线
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 129, [UIScreen mainScreen].bounds.size.width, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self.tableView addSubview:bottomLine];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (void)pushViewControllercancelBtn
{
    NSLog(@"注销了");
//#define kUserNameKey @"usernamekey"
//#define kCredentialsNumKey @"credentialsnumkey"
//#define kPhoneNumKey @"phonenumkey"

    
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    
    //把登录状态改为 0
    if ([defaults objectForKey:KisLoginFlag]) {
        
        [defaults setObject:@(0) forKey:KisLoginFlag];
    }

   
    MMDrawerController * mmVc=(MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //关闭控制器..
    [mmVc closeDrawerAnimated:YES completion:nil];
    
}

#pragma mark -- 跳转到个人信息设置
- (void)pushViewControllerchangebtn
{
    
//    NSLog(@"实现了方法");
    EDKMaterialSetViewController * vc = [[EDKMaterialSetViewController alloc]init];
    
    EDKNavController * navController =[[EDKNavController alloc] initWithRootViewController:vc];
    
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [self setCellWithUITableViewCell:cell andRowAtIndexPath:indexPath];
    
    return cell;
    
}

- (void)setCellWithUITableViewCell:(UITableViewCell *)cell andRowAtIndexPath:(NSIndexPath *)indexPath {
    //分割线
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:bottomLine];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"预约挂号列表";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"名医通申请";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"病例管理";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"我的收藏";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"支付明细";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"设置与帮助";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"意见反馈";
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 8, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            break;
            
        default:
            break;
    }

    
}


//确定弹出哪个控制器..
-(void)presentViewTargetController:(id) Controller
{
    EDKNavController * nav =[[EDKNavController alloc] initWithRootViewController:Controller];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //点击的时候 把抽屉取消

    switch (indexPath.row) {
        case 0:
        {
            EDKRegisterController *vc1 = [[EDKRegisterController alloc]init] ;
        
            [self presentViewTargetController:vc1];
       
        }
            break;
        case 1:
        {
            EDKApplysController *vc2 = [[EDKApplysController alloc]init] ;
            [self presentViewTargetController:vc2];

        }
            break;
        case 2:
            
#pragma mark --跳转到病例管理
        {
            EDKMedicalCaseViewController * mangeCaseVc = [[EDKMedicalCaseViewController alloc] init];
            
            [self presentViewTargetController:mangeCaseVc];
        }
            break;
        case 3:
        {
            EDKCollectController *vc3 = [[EDKCollectController alloc]init] ;
            [self presentViewTargetController:vc3];
        }
            
            break;
        case 4:
        {
            EDKPayBillController *vc4 = [[EDKPayBillController alloc]init] ;
            [self presentViewTargetController:vc4];
        }
            break;
        case 5:
        {
            EDKSetHelpController *vc5 = [[EDKSetHelpController alloc]init] ;
            [self presentViewTargetController:vc5];
        }
 
            break;
        case 6:
        {
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKIdeaFeedback" bundle:nil];

            EDKIdeaFeedbackController *vc6 = [board instantiateInitialViewController];
           [self presentViewTargetController:vc6];
        }
            
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 41 ;
    
}


@end







