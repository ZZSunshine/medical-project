//
//  EDKNavController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKNavController.h"
#import "UIColor+Hex.h"
@implementation EDKNavController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置
    
    UINavigationBar * navBar=[UINavigationBar appearance];
    //设置背景颜色
    [navBar setBarTintColor: [UIColor colorWithHexString:backImgColor]];
    
    //设置字体 大小 和字体颜色
    NSDictionary * dict=@{NSFontAttributeName :[UIFont systemFontOfSize:17],NSForegroundColorAttributeName :[UIColor whiteColor]};
    //设置渲染颜色
    [navBar setTintColor:[UIColor whiteColor]];

    [navBar setTitleTextAttributes:dict];

  
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置返回按钮的样式
    UIBarButtonItem * backItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
//    UIBarButtonItem * backItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回箭头"] style:UIBarButtonItemStylePlain target:nil action:nil];
//    
//    self.topViewController.navigationItem.hidesBackButton =YES;
//    
//    self.navigationBar.backItem.hidesBackButton =YES;
    
    //设置返回的样式
    self.topViewController.navigationItem.backBarButtonItem=backItem;

    
    
//    UIButton * backButton =[[UIButton alloc] init];
//    [backButton setImage:[UIImage imageNamed:@"返回箭头"] forState:UIControlStateNormal];
//    [backButton sizeToFit];
//    
//    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
//    //设置最顶部视图 的backItem 样式
//    viewController.navigationItem.backBarButtonItem=backItem;
    
  
    [super pushViewController:viewController animated:animated];
    
 
    

}

@end
