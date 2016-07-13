//
//  DoctorIntroduction.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "DoctorIntroduction.h"

@implementation DoctorIntroduction

/**
 *  数据字典转模型的方法
 *
 *  @param dict 数据字典
 *
 *  @return 返回一个模型
 */
-(instancetype)initWithDictionary:(NSDictionary*) dict;
{
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


//不让系统来执行 forUndefinedKey 方法 。可以防止 [self setValuesForKeysWithDictionary:dict]; 因字段缺失 而产生的错误
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/**
 *  类方法返回一个模型对象
 *
 *  @param dict 数据字典
 *
 *  @return 返回模型对象
 */
+(instancetype)doctorIntroductionWith:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}



@end
