//
//  SystemMessageModel.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.
//  Copyright © 2016年 晓飞. All rights reserved.
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
