//
//  DoctorZuoZhenDetial.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorZuoZhenDetial : NSObject

//"icon_type" = 1;
//"offer_time" = "9\Uff1a00";
//"zuozhen_address" = "\U8d70\U54ea\U7b97\U54ea";
//"zuozhen_department_name" = "\U795e\U7ecf\U5185\U79d1";
//"zuozhen_fee" = 12;
//"zuozhen_hospital_name" = "\U5317\U4eac\U534f\U548c\U533b\U9662";
//"zuozhen_id" = 144;

@property (nonatomic,copy)NSString * offer_time;
@property (nonatomic,assign)NSNumber * icon_type;
@property (nonatomic,copy)NSString * zuozhen_address;
@property (nonatomic,copy)NSString * zuozhen_department_name;
@property (nonatomic,copy)NSNumber * zuozhen_fee;
@property (nonatomic,copy)NSString * zuozhen_hospital_name;
@property (nonatomic,copy)NSNumber * zuozhen_id;

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
+(instancetype)detialWith:(NSDictionary *)dict;



@end
