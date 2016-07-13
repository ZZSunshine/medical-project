//
//  DoctorZuozhenInfo.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorZuozhenInfo : NSObject

@property (nonatomic,strong) NSArray * duties;
@property (nonatomic,assign)NSNumber * period;
@property (nonatomic,copy)NSString * start_date;
@property (nonatomic,strong)NSArray * zuozhen_infos;


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
+(instancetype)zuozhenInfoWith:(NSDictionary *)dict;



@end
