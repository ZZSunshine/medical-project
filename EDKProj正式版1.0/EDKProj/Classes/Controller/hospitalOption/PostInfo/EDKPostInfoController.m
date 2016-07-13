//
//  EDKPostInfoController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKPostInfoController.h"
#import "EDKCommitController.h"

@interface EDKPostInfoController ()



@end

@implementation EDKPostInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 标题
    self.navigationItem.title = @"挂号信息确认";
    
    //self.view.backgroundColor = [UIColor redColor];
}
- (IBAction)doneBtnClick:(UIButton *)sender {
    
    //1
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKCommit" bundle:nil];
    
    EDKCommitController *commit = [board instantiateInitialViewController];
    
    //2
    [self.navigationController pushViewController:commit animated:YES];
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
