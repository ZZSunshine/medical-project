//
//  SystemMessageModel.m
//  EDKProj
//
//  Created by wuliang on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel


- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cellWithDict:(NSDictionary *)dict;{
    
    return  [[self alloc]initWithDict:dict];
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key {
    //
}

@end
