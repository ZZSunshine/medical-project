//
//  TabMutiController.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnblock)(NSString * arrayString);

@class DiseaseInfo;
@interface TabMutiController : UITableViewController

@property (nonatomic,copy) NSString * diseaseType;

@property (nonatomic,strong) DiseaseInfo * disInfo;


//定义返回的block
@property (nonatomic,copy) returnblock returnblock;

@end
