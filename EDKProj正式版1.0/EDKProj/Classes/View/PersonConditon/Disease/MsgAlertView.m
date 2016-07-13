//
//  MsgAlertView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "MsgAlertView.h"
#import "DoctorZuoZhenDetial.h"
#import "EDKsummitMaterial.h"

#define goToControllerName @"EDKsummitMaterial"
@interface MsgAlertView()

@property (strong, nonatomic)  UILabel *lblmsg1;
@property (strong, nonatomic)  UILabel *lblmsg2;
@property (strong, nonatomic)  UILabel *lblmsg3;

@property (strong, nonatomic)  UILabel *lblJjrq;
@property (strong, nonatomic)  UILabel *lblJjfy;
@property (strong, nonatomic)  UILabel *lblJjyy;

@property (strong, nonatomic)  UIButton *btnConfirm;
@property (nonatomic,strong) UIButton * btnClose;

@end


@implementation MsgAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    self.layer.cornerRadius =self.height /5;
    self.layer.masksToBounds =YES;
    
    self.backgroundColor =[UIColor whiteColor];
    
    self.lblmsg1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 15)];
    self.lblmsg2 =[[UILabel alloc] initWithFrame:CGRectMake(10, self.lblmsg1.bottom +5, 70, 15)];
    self.lblmsg3 =[[UILabel alloc] initWithFrame:CGRectMake(10, self.lblmsg2.bottom +5, 70, 15)];
    self.lblmsg1.textColor =[UIColor blackColor];
    self.lblmsg1.font =[UIFont systemFontOfSize:13];
    self.lblmsg2.textColor =[UIColor blackColor];
    self.lblmsg2.font =[UIFont systemFontOfSize:13];
    self.lblmsg3.textColor =[UIColor blackColor];
    self.lblmsg3.font =[UIFont systemFontOfSize:13];
    
    self.lblmsg1.text =@"就诊日期";
    self.lblmsg2.text =@"就诊费用";
    self.lblmsg3.text =@"就诊医院";
    
    self.lblJjrq =[[UILabel alloc] init];
    self.lblJjfy =[[UILabel alloc] init];
    self.lblJjyy =[[UILabel alloc] init];
    
    self.lblJjrq.frame =CGRectMake(self.lblmsg1.right + 5, 10, 150, 15);
    self.lblJjfy.frame =CGRectMake(self.lblmsg2.right + 5, self.lblmsg1.bottom +5, 150, 15);
    self.lblJjyy.frame =CGRectMake(self.lblmsg3.right + 5, self.lblmsg2.bottom +5, 150, 15);
    
    self.lblJjrq.textColor =[UIColor blackColor];
    self.lblJjrq.font =[UIFont systemFontOfSize:13];
    self.lblJjfy.textColor =[UIColor blackColor];
    self.lblJjfy.font =[UIFont systemFontOfSize:13];
    self.lblJjyy.textColor =[UIColor blackColor];
    self.lblJjyy.font =[UIFont systemFontOfSize:13];
    
    
    //添加一个button
    self.btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnConfirm.frame =CGRectMake((self.width - 200) *0.5, self.lblJjyy.bottom +5, 200, 40);
    
    [self.btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    [self.btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnConfirm setBackgroundColor:[UIColor colorWithHexString:backImgColor]];
    
    self.btnConfirm.layer.cornerRadius = self.btnConfirm.height /5;
    self.btnConfirm.layer.masksToBounds=YES;
    
    [self addSubview:self.lblmsg1];
    [self addSubview:self.lblmsg2];
    [self addSubview:self.lblmsg3];
    [self addSubview:self.lblJjrq];
    [self addSubview:self.lblJjfy];
    [self addSubview:self.lblJjyy];
    
    [self addSubview:self.btnConfirm];
    
    [self.btnConfirm addTarget:self action:@selector(btnConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
  
    self.btnClose =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnClose setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
    self.btnClose.frame =CGRectMake(self.width -30, 0, 25, 25);
    
    [self.btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnClose];
    
    return self;
}

//设置属性..
-(void)setParmaters:(NSMutableDictionary *)parmaters
{
    _parmaters = parmaters;
    //取出对应的参数
    NSString * selectString =parmaters[@"selectday"];
    DoctorZuoZhenDetial * detial=parmaters[@"zuozhenDetial"];
    
    self.lblJjrq.text =selectString;
    self.lblJjyy.text = detial.zuozhen_hospital_name;
    self.lblJjfy.text =[NSString stringWithFormat:@"￥%@",detial.zuozhen_fee];

    //设置
    
    
}


-(void)btnConfirmClick:(UIButton *)sender
{
    
    if (self.gotoblock) {
        
        self.gotoblock(goToControllerName);
    }
    //确认的时候跳转到递交病例...
    
//    UIStoryboard * stroyboard =[UIStoryboard storyboardWithName:@"EDKsummitMaterial" bundle:nil];
//    
//    EDKsummitMaterial * edkMaterialVc = [stroyboard instantiateInitialViewController];
    
    
}

- (void)btnCloseClick:(UIButton *)sender {
    
    //需要调用block 来实现从View 上移除
    //发送通知关闭
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MsgAlertCloseView" object:nil];
}

@end
