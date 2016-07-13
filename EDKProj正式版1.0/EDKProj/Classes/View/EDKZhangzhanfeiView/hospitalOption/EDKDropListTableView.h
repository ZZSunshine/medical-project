//
//  EDKDropListTableView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//搜索数据的时候用的回调
typedef void(^DropListDataBlock)(NSString *str);

//下拉列表用到的数据
typedef void(^DropList)(NSString *str);

@interface EDKDropListTableView : UITableView

//数据来源
@property (nonatomic,strong) NSMutableArray *dataArray;

//
@property (nonatomic,copy) DropListDataBlock dropList;

//
@property (nonatomic,copy) DropList dropListBlcok;


@end
