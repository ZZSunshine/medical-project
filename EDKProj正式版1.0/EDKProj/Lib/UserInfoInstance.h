//
//  UserInfoInstance.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/30.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoInstance : NSObject

+(instancetype)getuserInstance;

-(NSString *)getUserName;

-(NSString *)getCredentialsnumkey;

-(NSString *)getPhonenumkey;


@end
