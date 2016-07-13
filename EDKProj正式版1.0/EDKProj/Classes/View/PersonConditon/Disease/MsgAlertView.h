//
//  MsgAlertView.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^gotoControllerBlock)(NSString * storyBoardName);

@interface MsgAlertView : UIView

@property (nonatomic,strong) NSMutableDictionary * parmaters;

//跳转画面用的block
@property (nonatomic,copy) gotoControllerBlock gotoblock;

@end
