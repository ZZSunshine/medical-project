//
//  EDKMedicalCaseCell.m
//  EDKProj
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
