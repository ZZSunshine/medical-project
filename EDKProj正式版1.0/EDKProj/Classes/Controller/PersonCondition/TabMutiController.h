//
//  TabMutiController.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.

#import <UIKit/UIKit.h>

typedef void(^returnblock)(NSString * arrayString);

@class DiseaseInfo;
@interface TabMutiController : UITableViewController

@property (nonatomic,copy) NSString * diseaseType;

@property (nonatomic,strong) DiseaseInfo * disInfo;


//定义返回的block
@property (nonatomic,copy) returnblock returnblock;

@end
