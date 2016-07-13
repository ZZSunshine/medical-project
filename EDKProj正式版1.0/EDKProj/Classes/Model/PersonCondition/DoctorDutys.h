//
//  DoctorDutys.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorDutys : NSObject
//"duty_code" = 1;
//"duty_date" = "2015-12-30";
//"duty_source_id" = 5561;
//"duty_status" = 1;
//"duty_status_name" = "\U6709\U53f7";
//"has_number" = 1;
//"icon_type" = 1;
//"zuozhen_id" = 144;


@property (nonatomic,assign)NSNumber * duty_code;
@property (nonatomic,copy)NSString * duty_date;
@property (nonatomic,assign)NSNumber * duty_source_id;
@property (nonatomic,assign)NSNumber * duty_status;
@property (nonatomic,copy)NSString * duty_status_name;
@property (nonatomic,assign)NSNumber * icon_type;
@property (nonatomic,assign)NSNumber * has_number;
@property (nonatomic,assign)NSNumber * zuozhen_id;

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
+(instancetype)doctorDutyWith:(NSDictionary *)dict;



@end
