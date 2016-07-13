//
//  FamousDoctorModel.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
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
