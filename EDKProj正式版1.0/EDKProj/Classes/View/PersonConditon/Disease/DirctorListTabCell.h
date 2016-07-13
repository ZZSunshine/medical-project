//
//  DirctorListTabCell.h
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DictorList;
@interface DirctorListTabCell : UITableViewCell

+(instancetype)DirctorListTabCellWithNid;

@property (nonatomic,strong) DictorList * dlist;


@end
