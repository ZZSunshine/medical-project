//
//  homePageHeaderView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 晓飞. All rights reserved.
//


#import "EDKhomePageHeaderView.h"






@interface EDKhomePageHeaderView()



@property (weak, nonatomic) IBOutlet UIButton *materialSetButton;

@end


@implementation EDKhomePageHeaderView

- (instancetype)init
{
    self = [super init] ;
   
    
     return [[[NSBundle mainBundle]loadNibNamed:@"EDKhomePageHeaderView" owner:nil options:nil]lastObject];
  
    
}
//- (UIImageView *)setImageHeader {
//   
//    
//}

- (IBAction)materialSetButtonClick {
    EDKLog(@"----");
    [self.delegate pushViewControllerchangebtn];
    
}

- (IBAction)cancelBtnClick {
    

    
    [self.delegate2 pushViewControllercancelBtn];
}



@end






