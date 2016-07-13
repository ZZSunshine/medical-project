//
//  materialSet.h
//  EDKProj
//
//  Created by XUYIBIN on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EDKMaterialSetPushViewControllerDelegate <NSObject>

- (void)pushViewControllerchangeheadImage;

@end


@interface EDKMaterialSet : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardID;

@property (weak, nonatomic) IBOutlet UILabel *phoneNUM;

@property (nonatomic,weak)id<EDKMaterialSetPushViewControllerDelegate> delegate ;

@end
