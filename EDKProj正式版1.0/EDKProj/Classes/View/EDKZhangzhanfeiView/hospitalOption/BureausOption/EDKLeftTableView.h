//
//  EDKLeftTableView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedBureaus)(NSDictionary *dict);

@interface EDKLeftTableView : UITableView

//
@property (nonatomic,copy) selectedBureaus selectedBur;

@end
