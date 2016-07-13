//
//  EDKHostral.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDKHostral : NSObject

//大图片
@property (nonatomic,copy) NSString *iconView;

//小图片
@property (nonatomic,copy) NSString *smallIconView;

//医院名称
@property (nonatomic,copy) NSString *hospitalLabel;

//医院等级
@property (nonatomic,copy) NSString *gradeLabel;

//医院地址
@property (nonatomic,copy) NSString *addressLabel;

//医院距离
@property (nonatomic,copy) NSString *distanceLabel;

//类方法
+ (instancetype)hostralWithdict:(NSDictionary *)dict;

@end
