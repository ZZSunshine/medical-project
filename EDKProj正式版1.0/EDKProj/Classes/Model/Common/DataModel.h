//
//  DataModel.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

//code = 0;
// data =数组
// msg =OK

@property (nonatomic,strong) NSNumber *code;
@property (nonatomic,strong) NSArray * data;
@property (nonatomic,copy) NSString * msg;

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
+(instancetype)dataModelWith:(NSDictionary *)dict;


@end
