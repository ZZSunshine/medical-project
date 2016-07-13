//
//  DictorList.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictorList : NSObject

//accuracy = "98%";
//banner = 0;
//"doctor_gender" = 1;
//"doctor_hospital_name" = "\U5317\U4eac\U534f\U548c\U533b\U9662";
//"doctor_id" = 300000315;
//"doctor_name" = "\U4f55\U6654\U946b";
//"doctor_portrait" = "http://hdkj-web1.chinacloudapp.cn:8080/res/2093000003151445677716555.jpg";
//"doctor_title_name" = "\U5fc3\U7406\U533b\U751f";
//"easymob_id" = d300000315;
//flower = 0;
//"operation_count" = 0;

@property (nonatomic,copy) NSString *accuracy;
@property (nonatomic,assign) NSNumber *banner;
@property (nonatomic,assign) NSNumber *doctor_gender;
@property (nonatomic,copy) NSString *doctor_hospital_name;
@property (nonatomic,assign) NSNumber *doctor_id;
@property (nonatomic,copy) NSString *doctor_name;
@property (nonatomic,copy) NSString *doctor_portrait;
@property (nonatomic,copy) NSString *doctor_title_name;
@property (nonatomic,copy) NSNumber *easymob_id;
@property (nonatomic,assign) NSNumber *flower;
@property (nonatomic,assign) NSNumber *operation_count;

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
+(instancetype)DictorListWith:(NSDictionary *)dict;



@end
