//
//  EDKGuideCell.m
//  EDKProj
//
//  Created by wuliang on 16/3/30.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKGuideCell.h"
#import "UIView+CZExtension.h"
#import "EDKMainViewController.h"
#import "EDKNavController.h"
#import "MMDrawerController.h"
#import "EDKPersonalMessageController.h"

@interface EDKGuideCell ()

// 背景的图片框
@property (nonatomic, weak) UIImageView *imgView;




@end



@implementation EDKGuideCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1.创建图片框
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
                
        // 2.添加
        [self.contentView addSubview:imgView];
        
        // 3.赋值
        _imgView = imgView;
        
        
#pragma mark - 设置立即体验按钮
        UIButton *experienceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [experienceBtn setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
        
        // 让按钮根据图片调整大小
        [experienceBtn sizeToFit];
        
        experienceBtn.x = (self.width - experienceBtn.width) * 0.5;
        experienceBtn.y = self.height * 0.85;
        
        // 按钮默认隐藏
        experienceBtn.hidden = YES;
        
        
        [self addSubview:experienceBtn];
        
        // 赋值
        _experienceBtn = experienceBtn;
        
        // 注册点击事件
        [experienceBtn addTarget:self action:@selector(experienceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
#pragma mark - 设置跳过按钮
        UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [skipBtn setImage:[UIImage imageNamed:@"跳过"] forState:UIControlStateNormal];
        
        // 让按钮根据图片调整大小
        [skipBtn sizeToFit];
        
        skipBtn.x = self.width - 74;
        skipBtn.y = 50;
        
        
        [self addSubview:skipBtn];
        
        // 赋值
        _skipBtn = skipBtn;
        
        // 注册点击事件
        [skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


- (void)skipBtnClick {

    // 1.获取应用程序对象
    UIApplication *app = [UIApplication sharedApplication];
    
    
    
    EDKMainViewController *mainVC = [[EDKMainViewController alloc]init];
    
    EDKNavController * navVc =[[EDKNavController alloc] initWithRootViewController:mainVC];
    
    EDKPersonalMessageController * personVc =[[EDKPersonalMessageController alloc] init];
    
    
    MMDrawerController * mmVc = [[MMDrawerController alloc] initWithCenterViewController:navVc leftDrawerViewController:personVc];
    
    app.keyWindow.rootViewController = [[EDKNavController alloc]initWithRootViewController:mmVc];
    
//    app.keyWindow.rootViewController = [[EDKNavController alloc]initWithRootViewController:mainVC];

}


- (void)experienceBtnClick {

    // 1.获取应用程序对象
    UIApplication *app = [UIApplication sharedApplication];
    
    //需要包装
    
    
    
    EDKMainViewController *mainVC = [[EDKMainViewController alloc]init];
    
    app.keyWindow.rootViewController = [[EDKNavController alloc]initWithRootViewController:mainVC];

    
}



#pragma mark - 重写图片的set方法设置图片
-(void)setBackgroundImg:(UIImage *)backgroundImg{
    
    _backgroundImg = backgroundImg;
    
    self.imgView.image = backgroundImg;
    
    
}







@end
