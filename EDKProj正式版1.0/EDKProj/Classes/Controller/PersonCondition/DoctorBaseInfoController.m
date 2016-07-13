//
//  DoctorBaseInfoController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "DoctorBaseInfoController.h"
#import "DictorList.h"
#import "EDKNetworking.h"


@interface DoctorBaseInfoController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIImageView *doctroImageView;

@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *doctorKeshiLabel;

@property (weak, nonatomic) IBOutlet UILabel *doctorTitleName;

@property (weak, nonatomic) IBOutlet UILabel *doctorHospitalLbel;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMsg;

@property (weak, nonatomic) IBOutlet UIView *daoshiView;

@property (weak, nonatomic) IBOutlet UILabel *daoshiNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *btnOpreationCount;

@property (weak, nonatomic) IBOutlet UIButton *btnFlowerCount;
@property (weak, nonatomic) IBOutlet UIButton *btnBannerCount;
@property (weak, nonatomic) IBOutlet UIButton *btnJztj;
@property (weak, nonatomic) IBOutlet UIButton *btnYsjj;
@property (weak, nonatomic) IBOutlet UIButton *btnJjsj;
@property (nonatomic,strong) UIActivityIndicatorView * actiview;
//创建一个自定义collectionView

@property(nonatomic,strong) UIView * currentLineView;

@end

@implementation DoctorBaseInfoController
#pragma mark --懒加载
-(UIActivityIndicatorView *)actiview
{
    if (_actiview ==nil) {
        
        _actiview =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((KWidth - 44) *0.5, (KHeight - 44) *0.5, 44, 44)];
        
        _actiview.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
        
        [self.view addSubview:_actiview];
        
    }
    
    return _actiview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setDoctorlist:(DictorList *)doctorlist
{
    _doctorlist =doctorlist;
    
    //加载数据
    
    
    
}

-(void)laodData
{
//    {"user_id":1000089,"doctor_id":300000315}
    NSMutableDictionary * parmaters=[NSMutableDictionary dictionary];
    parmaters[@"user_id"] =@(1000089);
    parmaters[@"doctor_id"]=self.doctorlist.doctor_id;
 
    //开始加载
    self.actiview.hidden = NO;
    [self.actiview startAnimating];
    
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORBASEINFONET parameters:parmaters successBlock:^(id object) {
        
        
        
        [self.actiview stopAnimating];
        self.actiview.hidesWhenStopped=YES;
        
    } FailBlock:^(NSError *error) {
        
    }];
    
    
    
}




@end
