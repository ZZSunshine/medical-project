//
//  IdeaFeedbackController.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKIdeaFeedbackController.h"

@interface EDKIdeaFeedbackController ()

@property (weak, nonatomic) IBOutlet UITextView *testView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIButton *tellPhone;

@end

@implementation EDKIdeaFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    
    self.testView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.testView.layer.borderWidth = 1 ;
    self.testView.layer.cornerRadius = 6 ;
    self.testView.layer.masksToBounds = YES;
    
    self.okBtn.layer.cornerRadius = 6 ;
    self.okBtn.layer.masksToBounds = YES;
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;
    
}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
