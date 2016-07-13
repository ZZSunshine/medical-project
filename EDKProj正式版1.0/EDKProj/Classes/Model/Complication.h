//
//  Complication.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Complication : NSObject
//
//"complication_id" = 6;
//"complication_name" = "\U7f3a\U94c1\U6027\U8d2b\U88401";

@property (nonatomic,assign) NSNumber *complication_id;
@property (nonatomic,copy) NSString * complication_name;

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
+(instancetype)ComplicationWith:(NSDictionary *)dict;


@end
