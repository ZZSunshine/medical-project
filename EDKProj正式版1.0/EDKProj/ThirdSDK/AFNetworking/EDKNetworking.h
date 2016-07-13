//
//  EDKNetworking.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void(^SuccessBlock)(id object);

typedef void(^failBlock)(NSError *error);


@interface EDKNetworking : NSObject

//单例模式
+ (instancetype)sharedNewtWorkTool;

//post请求
/**
 *  post请求
 *
 *  @param urlString  字符串网址
 *  @param parameters 参数列表(字典)
 *  @param success     成功回调 返回数据
 *  @param fail       失败回调  返回错误信息.
 */
- (void)POST:(NSString *)urlString parameters:(id)parameters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail;


@end
