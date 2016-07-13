//
//  EDKMedicalCaseCell.h
//  EDKProj
//
//  Created by 张帅 on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDKMedicalCaseCell : UITableViewCell
//图标
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//病例
@property (weak, nonatomic) IBOutlet UILabel *medicalCase;
//疾病描述
@property (weak, nonatomic) IBOutlet UILabel *desLab;
//时间label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//选择按钮
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;



@property (nonatomic,assign) BOOL isSelected;
@end
