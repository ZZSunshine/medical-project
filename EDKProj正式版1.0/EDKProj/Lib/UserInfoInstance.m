//
//  UserInfoInstance.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/30.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "UserInfoInstance.h"


@interface UserInfoInstance()

@property (nonatomic,strong) NSUserDefaults * defaults;
@end
@implementation UserInfoInstance

-(NSUserDefaults *)defaults
{
    if (_defaults ==nil) {
        
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

+(instancetype)getuserInstance
{
    static UserInfoInstance * instance ;
    
    if (instance ==nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            //创建示例
            instance =[[self alloc] init];
            
        });
    }
    return instance;
}

//#define kUserNameKey @"usernamekey"
//#define kCredentialsNumKey @"credentialsnumkey"
//#define kPhoneNumKey @"phonenumkey"
//#define kGenderValueKey @"gendervaluekey"
//#define kEdk_Version @"EDK_version"
//获取用户名
-(NSString *)getUserName
{
    NSString * userName=
    [self.defaults objectForKey:kUserNameKey];
    
    return userName;
}

-(NSString *)getCredentialsnumkey
{
    NSString * Credentialsnumkey=
    [self.defaults objectForKey:kCredentialsNumKey];
    
    return Credentialsnumkey;
}


-(NSString *)getPhonenumkey
{
    NSString * Phonenumkey=
    [self.defaults objectForKey:kPhoneNumKey];
    
    return Phonenumkey;
}






@end
