//
//  EDKCommitController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.


#import "EDKCommitController.h"

@interface EDKCommitController ()

@end

@implementation EDKCommitController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 设置属性
    
    self.navigationItem.title = @"已提交审核";
    
    //self.view.backgroundColor = [UIColor greenColor];
    
}


#pragma mark 事件

//个人中心
- (IBAction)personCenterBtn:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


// 返回首页
- (IBAction)returnPageBtn:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
