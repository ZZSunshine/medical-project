//
//  EDKGuideCell.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/30.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDKGuideCell : UICollectionViewCell

/**
 * 背景图片
 */
@property (nonatomic,strong) UIImage  *backgroundImg;


// 体验按钮
@property (nonatomic, weak) UIButton *experienceBtn;


// 体验按钮
@property (nonatomic, weak) UIButton *skipBtn;



@end
