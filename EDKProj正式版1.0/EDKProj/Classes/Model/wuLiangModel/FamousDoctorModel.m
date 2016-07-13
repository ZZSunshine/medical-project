//
//  FamousDoctorModel.m
//  EDKProj
//
//  Created by wuliang on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "FamousDoctorModel.h"

@implementation FamousDoctorModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cellWithDict:(NSDictionary *)dict;{
    
    return  [[self alloc]initWithDict:dict];
}

@end
