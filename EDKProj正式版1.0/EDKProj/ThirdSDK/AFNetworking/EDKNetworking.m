//
//  EDKNetworking.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKNetworking.h"

@implementation EDKNetworking

//单例
+ (instancetype)sharedNewtWorkTool
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//post方法
- (void)POST:(NSString *)urlString parameters:(id)parameters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail {
    //1 创建管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *dict =(NSDictionary *)parameters;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //2 设置解析的格式
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript" ,@"text/plain",@"text/html",nil];
    
    //3 发送请求
    [manager POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"--------%@",responseObject);
        if (success) {
            
            //成功回调
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            
            //失败后回调
            fail(error);
        }
    }];

}

@end
