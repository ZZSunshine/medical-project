//
//  SystemMessageModel.h
//  EDKProj
//
//  Created by wuliang on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject

/**
 * 图标
 */
@property (nonatomic,copy) NSString *icon;

/**
 * 标题
 */
@property (nonatomic,copy) NSString  *title;

/**
 * 内容
 */
@property (nonatomic,copy) NSString  *detail;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)cellWithDict:(NSDictionary *)dict;


@end
