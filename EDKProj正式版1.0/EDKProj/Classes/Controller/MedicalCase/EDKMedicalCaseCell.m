//
//  EDKMedicalCaseCell.m
//  EDKProj
//
//  Created by 张帅 on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKMedicalCaseCell.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
@interface EDKMedicalCaseCell ()


@end
@implementation EDKMedicalCaseCell


-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected =isSelected;
    
    self.chooseBtn.selected =isSelected;
    
}


@end
