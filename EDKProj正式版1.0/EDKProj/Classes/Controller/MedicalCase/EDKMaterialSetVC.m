//
//  EDKMaterialSetVC.m
//  EDKProj
//
//  Created by 张帅 on 16/3/31.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKMaterialSetVC.h"
#import "EDKMaterialSet.h"
@interface EDKMaterialSetVC ()

@end

@implementation EDKMaterialSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    EDKMaterialSet *setView = [[[NSBundle mainBundle]loadNibNamed:@"EDKMaterialSet" owner:nil options:nil]lastObject];
    setView.frame = self.view.frame;
    [self.view addSubview:setView];
}




@end
