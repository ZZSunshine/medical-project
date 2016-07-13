//
//  EDKSubmitSuggestionViewController.m
//  EDKProj
//
//  Created by 张帅 on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKSubmitSuggestionViewController.h"
#import "EDKCustomTextView.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height
#define KMargin 20
@interface EDKSubmitSuggestionViewController ()<UITextViewDelegate>
@property (nonatomic,strong)EDKCustomTextView *textView;
@property (nonatomic,strong)UILabel *leftInputLab;

@end

@implementation EDKSubmitSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    //创建边框view
    [self createFrameView];
    
    //创建textField
    EDKCustomTextView *textView = [[EDKCustomTextView alloc]initWithFrame:CGRectMake(KMargin+2, KMargin+64, self.view.frame.size.width-2*KMargin-2, self.view.frame.size.height*2/5)];
    //创建textField的占位符
    textView.placeholder = @"请填写您遇到的问题";
    //设置代理
    textView.delegate = self;
    self.textView = textView;
    NSString *str = [NSString stringWithFormat:@"您还可以填写140个字"];
    UILabel *leftInputLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textView.frame)-120-KMargin, CGRectGetMaxY(textView.frame)-KMargin-10,140, 30)];
    //赋值
    self.leftInputLab = leftInputLab;
    leftInputLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    leftInputLab.text = str;
    [self.view addSubview:leftInputLab];
    [self.view bringSubviewToFront:leftInputLab];
    
    //创建联系我们label
    [self createContactUsLabel];
    
}
//创建边框
- (void)createFrameView{
    UIView *leFtView = [[UIView alloc]initWithFrame:CGRectMake(KMargin, KMargin+64, 1, self.view.frame.size.height*2/5)];
    leFtView.backgroundColor = [UIColor blackColor];
    leFtView.alpha = 0.3;
    [self.view addSubview:leFtView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(KMargin, KMargin+64, self.view.frame.size.width-2*KMargin, 1)];
    topView.backgroundColor = [UIColor blackColor];
    topView.alpha = 0.3;
    [self.view addSubview:topView];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(topView.frame), CGRectGetMaxY(topView.frame), 1, self.view.frame.size.height*2/5)];
    rightView.backgroundColor = [UIColor blackColor];
    rightView.alpha = 0.3;
    [self.view addSubview:rightView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(KMargin,CGRectGetMaxY(leFtView.frame), self.view.frame.size.width-2*KMargin, 1)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.3;
   
    [self.view addSubview:bottomView];
    
}

//创建联系我们label
- (void)createContactUsLabel{
    UILabel *contactUsLab = [[UILabel alloc]initWithFrame:CGRectMake(KMargin, CGRectGetMaxY(self.textView.frame)+KMargin, 120, 30)];
    contactUsLab.text = @"欢迎联系我们:";
    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(contactUsLab.frame), CGRectGetMaxY(self.textView.frame)+KMargin, 120, 30)];
    [phoneBtn setImage:[UIImage imageNamed:@"u24"] forState:UIControlStateNormal];
    [phoneBtn setTitle:@"电话联系" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    
    UIButton *submitFeedBack = [[UIButton alloc]initWithFrame:CGRectMake(KMargin,CGRectGetMaxY(phoneBtn.frame)+2*KMargin, KWIDTH-2*KMargin,30)];
    [submitFeedBack setTitle:@"提交反馈" forState:UIControlStateNormal];
    [submitFeedBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitFeedBack setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [submitFeedBack setBackgroundColor:[UIColor greenColor]];
    [submitFeedBack addTarget:self action:@selector(clickToSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitFeedBack];
    [self.view addSubview:phoneBtn];
    [self.view addSubview:contactUsLab];
}
- (void)clickToSubmit:(UIButton *)sender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你提交的反馈我们已收到,我们会尽快回复您" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *aleretAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:aleretAC];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.location > 140){
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的自字符数不能超过140" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
    [alertVC addAction:alertAC];
        
    [self presentViewController:alertVC animated:YES completion:nil];
        return NO;
    }else{
        return YES;
    }
}
//2,显示剩余可输入字数,代码如下:
- (void)textViewDidChange:(UITextView *)textView{
    long count;
    count = 140 - self.textView.text.length+1;
    [self.leftInputLab setText:[NSString stringWithFormat:@"您还可以填写%ld个字", count]];  //_wordCount是一个显示剩余可输入数字的label
}





@end
