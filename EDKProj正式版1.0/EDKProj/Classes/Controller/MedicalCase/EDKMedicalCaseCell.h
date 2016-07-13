//
//  EDKMedicalCaseCell.h
//  EDKProj
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
