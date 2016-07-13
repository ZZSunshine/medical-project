//
//  EDKSearchTableView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDKHostral;

//block
typedef void(^hospitalBlock)(EDKHostral *hostral);

@interface EDKSearchTableView : UITableView

//搜索数据用到的字符串
@property (nonatomic,copy) NSString *theName;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) hospitalBlock hospitalBlockSuccess;

@end
