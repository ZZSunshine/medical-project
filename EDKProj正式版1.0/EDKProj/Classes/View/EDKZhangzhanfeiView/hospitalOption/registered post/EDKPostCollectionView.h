//
//  EDKPostCollectionView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDKPostCollectionView : UICollectionView

//cell的个数
@property (nonatomic,assign) NSInteger nextDay;

//数据源(里面包含日期)
@property (nonatomic,strong) NSDate *date;

@end
