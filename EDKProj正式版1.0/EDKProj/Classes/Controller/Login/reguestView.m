//
//  reguestView.m
//  EDKProj
//
//  Created by wuliang on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "reguestView.h"

@implementation reguestView

-(instancetype)init {
    
    self = [super init];
    
    
    return [[[NSBundle mainBundle]loadNibNamed:@"RegistView" owner:nil options:nil]lastObject];
}

@end
