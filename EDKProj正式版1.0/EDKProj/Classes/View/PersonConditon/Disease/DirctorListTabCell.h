//
//  DirctorListTabCell.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DictorList;
@interface DirctorListTabCell : UITableViewCell

+(instancetype)DirctorListTabCellWithNid;

@property (nonatomic,strong) DictorList * dlist;


@end
