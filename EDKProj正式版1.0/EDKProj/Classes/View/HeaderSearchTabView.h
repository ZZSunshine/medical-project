//
//  HeaderSearchTabView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchBlock)(NSString * keyWord);

@interface HeaderSearchTabView : UIView

@property (nonatomic,copy) searchBlock block;

@end
