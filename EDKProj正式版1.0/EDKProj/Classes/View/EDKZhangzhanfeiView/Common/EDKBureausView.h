//
//  EDKBureausView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDKRightTableView.h"
#import "EDKLeftTableView.h"

@interface EDKBureausView : UIView

@property (nonatomic,strong) EDKRightTableView *rightTableView;

@property (nonatomic,strong) EDKLeftTableView *leftTableView;

@end
