//
//  DiseaseSelectTabController.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^selectBlock)(NSString * diseaseType);
typedef void(^returnBlock)(id model);

@class DiseaseTypeOne;
@interface DiseaseSelectTabController : UITableViewController

@property (nonatomic,strong) NSString * diseaseType;
@property (nonatomic,strong) DiseaseTypeOne * Diseaseone;


//定义block 用于返回
@property (nonatomic,copy) selectBlock selectBlock;

@property (nonatomic,copy) returnBlock returnblock;


@end
