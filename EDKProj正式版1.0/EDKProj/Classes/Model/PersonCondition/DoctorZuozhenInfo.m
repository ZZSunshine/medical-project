//
//  DoctorZuozhenInfo.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "DoctorZuozhenInfo.h"
#import "DoctorDutys.h"
#import "DoctorZuoZhenDetial.h"

@implementation DoctorZuozhenInfo

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
        //[self setValuesForKeysWithDictionary:dict];
        
        //字典转模型
        _zuozhen_infos = dict[@"zuozhen_infos"];
        _period =dict[@"period"];
        _start_date=dict[@"start_date"];
        _duties =dict[@"duties"];
        
        NSMutableArray * temp1 =[NSMutableArray array];
        NSMutableArray * temp2 =[NSMutableArray array];
        //把里面的数组转换成模型
        [_zuozhen_infos enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            DoctorZuoZhenDetial * detial= [DoctorZuoZhenDetial detialWith:obj];
            
            [temp1 addObject:detial];
        }];
        
        _zuozhen_infos = [temp1 copy];
        
        [_duties enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            DoctorDutys * duty= [DoctorDutys doctorDutyWith:obj];
            
            [temp2 addObject:duty];
        }];
        
        _duties = [temp2 copy];
        
        
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
+(instancetype)zuozhenInfoWith:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}



@end
