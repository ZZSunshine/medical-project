//
//  EDKRightTableView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedBureaus)(NSDictionary *dict);

typedef void(^hostralOptionBlock)(NSString *str);

@interface EDKRightTableView : UITableView

//
@property (nonatomic,copy) selectedBureaus selecteddespe;

//
@property (nonatomic,copy) hostralOptionBlock hostralBlock;

@end
