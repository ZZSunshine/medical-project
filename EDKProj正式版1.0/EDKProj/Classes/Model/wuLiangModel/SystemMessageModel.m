//
//  SystemMessageModel.m
//  EDKProj
//
//  Created by  on 16/3/29.
//  Copyright © 2016年 晓飞. All rights reserved.
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
