//
//  EDKSetHelpController.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#define kWIDTH [UIScreen mainScreen].bounds.size.width


#import "EDKSetHelpController.h"


@interface EDKSetHelpController ()

@end

@implementation EDKSetHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置与帮助";
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;
}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseID = @"reuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        [ self setSubviewsWithUITableViewCell:cell andWithIndexPath:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52 ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0. 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        NSLog(@"拨打400电话");
    } else if(indexPath.row == 2){
    
        // 提醒控制器
        UIAlertController *alertOne = [UIAlertController alertControllerWithTitle:nil message:@"暂时没有更新" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertOne addAction:action];
        // 显示提醒
        [self presentViewController:alertOne animated:YES completion:nil];

    }
    
    
}

- (void)setSubviewsWithUITableViewCell:(UITableViewCell *)cell andWithIndexPath:(NSIndexPath *)indexPath
{
    //分割线
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 52, [UIScreen mainScreen].bounds.size.width, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:bottomLine];
    
    switch (indexPath.row) {
        case 0:
        {
            UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 110, 21)];
            remindLabel.text = @"软件消息提醒";
            [cell.contentView addSubview:remindLabel];
            
            UISwitch *open = [[UISwitch alloc]initWithFrame:CGRectMake(kWIDTH - 71, 10, 51, 31)];
            [cell.contentView addSubview:open];
            
        }
            break;
        case 1:
        {
            UILabel *service = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 21)];
            service.text = @"联系客服";
            [cell.contentView addSubview:service];
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 15, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
        }
            
            break;
        case 2:
        {
            UILabel *renew =[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 21)];
            renew.text = @"检查更新";
            [cell.contentView addSubview:renew];
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 15, 25, 25)];
            imgView.image = [UIImage imageNamed:@"右拉伸箭头绿色"];
            [cell.contentView addSubview:imgView];
            
            UILabel *edition =[[UILabel alloc]initWithFrame:CGRectMake(kWIDTH - 160, 15, 150, 21)];
            edition.text = @"当前版本:1.0.0";
            [cell.contentView addSubview:edition];
            
        }
            
            break;
        case 3:
        {
            UILabel *negotiate = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 21)];
            negotiate.text = @"用户协议";
            [cell.contentView addSubview:negotiate];
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWIDTH - 51, 10, 31, 31)];
            imgView.image = [UIImage imageNamed:@"OK07"];
            [cell.contentView addSubview:imgView];
            
        }
            
            break;
            
        default:
            break;
    }
    
}



@end
