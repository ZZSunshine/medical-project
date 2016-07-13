//
//  EDKHostral.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKHostral.h"

@implementation EDKHostral

//
+ (instancetype)hostralWithdict:(NSDictionary *)dict {
    
    //
    EDKHostral *hostral = [[EDKHostral alloc]init];
    
    //2 设置固定的值
    hostral.iconView = @"医院";
    //小图片
    hostral.smallIconView = @"定位";
    //医院名称
    hostral.hospitalLabel =@"北京协和医院";
    
    //医院等级
    hostral.gradeLabel = @"三级甲等";
    
    //医院地址
    hostral.addressLabel = @"北京市东城区帅府园一号";
    
    //医院距离
    hostral.distanceLabel = @"1km";
    
    return hostral;
}
@end
