//
//  EDKupLoadImage.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKupLoadImage.h"

@implementation EDKupLoadImage

- (instancetype)init
{
    self = [super init] ;
    
    return [[[NSBundle mainBundle]loadNibNamed:@"EDKupLoad" owner:nil options:nil]lastObject];
}

@end
