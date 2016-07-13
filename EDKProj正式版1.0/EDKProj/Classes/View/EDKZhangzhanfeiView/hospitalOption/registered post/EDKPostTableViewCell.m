//
//  EDKPostTableViewCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKPostTableViewCell.h"

@interface EDKPostTableViewCell ()


// 日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end

@implementation EDKPostTableViewCell

//
+ (EDKPostTableViewCell *)postTableViewCell {
    
    return  [[[NSBundle mainBundle] loadNibNamed:@"EDKPostTableViewCell" owner:nil options:nil] lastObject];;
}

- (IBAction)InfoBtnClick:(UIButton *)sender {
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"info" object:self.dict];
    
}

//重写set方法
- (void)setStrDate:(NSString *)strDate {
    
    _strDate = strDate;
    
    //赋值
    if (strDate) {
        
        self.dateLabel.text = strDate;
    }
    
}





- (void)awakeFromNib {
    // Initialization code
}

@end
