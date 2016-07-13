//
//  DirctorListTabCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//


#import "DirctorListTabCell.h"
#import "DictorList.h"
#import "UIImageView+WebCache.h"
#import "IconimageButton.h"
@interface DirctorListTabCell()

@property (weak, nonatomic) IBOutlet UIImageView *portraitImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalNaemLbl;
@property (weak, nonatomic) IBOutlet UILabel *doctorTitleNamelbl;

@property (weak, nonatomic) IBOutlet IconimageButton *btnOpreationCount;

@property (weak, nonatomic) IBOutlet IconimageButton *btnFlowerCount;

@property (weak, nonatomic) IBOutlet IconimageButton *btnFlagCount;
@property (weak, nonatomic) IBOutlet UIView *staticView;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;

@end

@implementation DirctorListTabCell

+(instancetype)DirctorListTabCellWithNid
{
    return [[NSBundle mainBundle]loadNibNamed:@"DirctorListTabCell" owner:nil options:nil].lastObject;
}

-(void)setDlist:(DictorList *)dlist
{
    _dlist  = dlist;
    
    //圆角图片
    self.portraitImgView.layer.cornerRadius = 10;
    self.portraitImgView.layer.masksToBounds =YES;
    
    [self.portraitImgView sd_setImageWithURL:[NSURL URLWithString:dlist.doctor_portrait] placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    self.nameLabel.text =dlist.doctor_name;
    self.doctorTitleNamelbl.text =dlist.doctor_title_name;
    self.hospitalNaemLbl.text =dlist.doctor_hospital_name;
    
    [self.btnOpreationCount setImage:[UIImage imageNamed:@"手术刀"] forState:UIControlStateNormal];
    [self.btnOpreationCount setTitle:[NSString stringWithFormat:@"%@",dlist.operation_count] forState:UIControlStateNormal];
    
//    [self.btnOpreationCount setTitleColor:[UIColor colorWithHexString:@"#53D0E5"] forState:UIControlStateNormal];
    
    [self.btnFlowerCount setImage:[UIImage imageNamed:@"赠送鲜花"] forState:UIControlStateNormal];
    [self.btnFlowerCount setTitle:[NSString stringWithFormat:@"%@",dlist.flower] forState:UIControlStateNormal];
    
//    [self.btnFlowerCount setTitleColor:[UIColor colorWithHexString:@"#53D0E5"] forState:UIControlStateNormal];
    
    [self.btnFlagCount setImage:[UIImage imageNamed:@"赠送锦旗"] forState:UIControlStateNormal];
    [self.btnFlagCount setTitle:[NSString stringWithFormat:@"%@",dlist.banner] forState:UIControlStateNormal];
    
//    [self.btnFlagCount setTitleColor:[UIColor colorWithHexString:@"#53D0E5"] forState:UIControlStateNormal];
    
    self.accuracyLabel.text = dlist.accuracy;
    
}


@end
