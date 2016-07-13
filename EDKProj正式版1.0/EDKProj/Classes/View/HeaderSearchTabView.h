//
//  HeaderSearchTabView.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchBlock)(NSString * keyWord);

@interface HeaderSearchTabView : UIView

@property (nonatomic,copy) searchBlock block;

@end
