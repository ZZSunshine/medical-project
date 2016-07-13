//
//  UserInfoInstance.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/30.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoInstance : NSObject

+(instancetype)getuserInstance;

-(NSString *)getUserName;

-(NSString *)getCredentialsnumkey;

-(NSString *)getPhonenumkey;


@end
