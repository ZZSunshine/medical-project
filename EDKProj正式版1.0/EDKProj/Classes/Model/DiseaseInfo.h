//
//  DiseaseInfo.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiseaseInfo : NSObject


//"ci2_id" = 1;
//"ci3_id" = 1;
//"ci3_name" = "\U9f3b\U54bd\U6076\U6027\U80bf\U7624";

@property (nonatomic,assign) NSNumber *ci1_id;
@property (nonatomic,assign) NSNumber *ci2_id;
@property (nonatomic,assign) NSNumber *ci3_id;
@property (nonatomic,copy) NSString * ci3_name;


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
+(instancetype)DiseaseInfoWith:(NSDictionary *)dict;



@end
