//
//  MsgAlertView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^gotoControllerBlock)(NSString * storyBoardName);

@interface MsgAlertView : UIView

@property (nonatomic,strong) NSMutableDictionary * parmaters;

//跳转画面用的block
@property (nonatomic,copy) gotoControllerBlock gotoblock;

@end
