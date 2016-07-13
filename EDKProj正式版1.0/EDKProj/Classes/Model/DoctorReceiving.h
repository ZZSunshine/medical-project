//
//  DoctorReceiving.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorReceiving : NSObject

@property (nonatomic,copy)NSString * receiving_setting_extra;
@property (nonatomic,copy)NSArray * receiving_settings;

/**
 *  数据字典转模型的方法
 *
 *  @param dict 数据字典
 *
 *  @return 返回一个模型
 */
-(instancetype)initWithDictionary:(NSDictionary*) dict;

/**
 *  类方法返回一个模型对象
 *
 *  @param dict 数据字典
 *
 *  @return 返回模型对象
 */
+(instancetype)DoctorReceivingWith:(NSDictionary *)dict;



@end
