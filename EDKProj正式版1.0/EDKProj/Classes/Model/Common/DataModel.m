//
//  DataModel.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel


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
        
//        _code = dict[@"code"];
//        _msg = dict[@"msg"];
//        _data = dict[@"data"];
        //遍历数组字典转模型
        
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
+(instancetype)dataModelWith:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}



@end
