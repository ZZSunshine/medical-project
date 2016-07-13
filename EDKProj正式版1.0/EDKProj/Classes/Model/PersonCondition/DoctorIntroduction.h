//
//  DoctorIntroduction.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorIntroduction : NSObject

@property (nonatomic,copy)NSString * introduction;
@property (nonatomic,strong) NSArray * doctor_lables;

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
+(instancetype)doctorIntroductionWith:(NSDictionary *)dict;


@end
