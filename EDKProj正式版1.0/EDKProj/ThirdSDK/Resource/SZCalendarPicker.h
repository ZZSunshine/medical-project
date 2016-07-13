//
//  SZCalendarPicker.h
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>


//继承UiView的类能实现 collectionviewdelegate吗?

@interface SZCalendarPicker : UIView<UICollectionViewDelegate , UICollectionViewDataSource>

// 这个也是保存的是当前的日期
@property (nonatomic , strong) NSDate *date;


//保存当天的信息
@property (nonatomic , strong) NSDate *today;

//回调
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

+ (instancetype)showOnView:(UIView *)view;

@end
