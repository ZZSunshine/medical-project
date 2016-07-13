//
//  EDKPostTableViewCell.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EDKPostTableViewCell : UITableViewCell


//数据源
@property (nonatomic,strong) NSDictionary *dict;

/**
 *  选中的日期
 */
@property (nonatomic,copy) NSString *strDate;

//
+ (EDKPostTableViewCell *)postTableViewCell;

@end
