//
//  EDKupLoadImage.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKupLoadImage.h"

@implementation EDKupLoadImage

- (instancetype)init
{
    self = [super init] ;
    
    return [[[NSBundle mainBundle]loadNibNamed:@"EDKupLoad" owner:nil options:nil]lastObject];
}

@end
