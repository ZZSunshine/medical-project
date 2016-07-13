//
//  materialSet.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "EDKMaterialSet.h"

@interface EDKMaterialSet ()
@property (weak, nonatomic) IBOutlet UITextField *ageTest;
@property (weak, nonatomic) IBOutlet UITextField *heightTest;
@property (weak, nonatomic) IBOutlet UITextField *weightTest;
@property (weak, nonatomic) IBOutlet UITextField *liveIDTest;
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;


@end



@implementation EDKMaterialSet

- (instancetype)init
{
    self = [super init] ;
    
    return [[[NSBundle mainBundle]loadNibNamed:@"EDKMaterialSet" owner:nil options:nil]lastObject];
    

        
}


- (IBAction)clicKHeadImageBtn {
    
    [self.delegate pushViewControllerchangeheadImage];
    
}



@end
