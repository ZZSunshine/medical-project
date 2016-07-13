//
//  FamousDoctorModel.h
//  EDKProj
//
//  Created by wuliang on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamousDoctorModel : NSObject

/**
 * 图标
 */
@property (nonatomic,strong) NSString *ci1_icon;

/**
 * 文字
 */
@property (nonatomic,strong) NSString  *ci1_name;

/**
 * 序号
 */
@property (nonatomic,copy) NSNumber  *ci1_id;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)cellWithDict:(NSDictionary *)dict;


@end
