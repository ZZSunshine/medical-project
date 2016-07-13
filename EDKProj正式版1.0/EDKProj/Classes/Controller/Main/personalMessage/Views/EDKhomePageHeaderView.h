//
//  homePageHeaderView.h
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EDKhomePageHeaderViewPushViewControllerDelegate <NSObject>

- (void)pushViewControllerchangebtn;

@end

@protocol cancelBtnPushViewControllerDelegate <NSObject>

- (void)pushViewControllercancelBtn;

@end

@interface EDKhomePageHeaderView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic,weak)id<EDKhomePageHeaderViewPushViewControllerDelegate> delegate ;

@property (nonatomic,weak)id<cancelBtnPushViewControllerDelegate> delegate2 ;






@end
