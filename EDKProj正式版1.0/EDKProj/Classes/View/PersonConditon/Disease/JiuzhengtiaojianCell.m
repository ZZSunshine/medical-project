//
//  JiuzhengtiaojianCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "JiuzhengtiaojianCell.h"
#import "EDKNetworking.h"
#import "DoctorReceiving.h"
#import "DictorList.h"

@interface JiuzhengtiaojianCell()

@property (nonatomic,strong) UIActivityIndicatorView * activity;

@property (nonatomic,strong) UILabel * settingLabel;
@property (nonatomic,strong) UILabel * extraLabel;
@end

@implementation JiuzhengtiaojianCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    //创建控件
    //self.backgroundColor = EDKRandomColor;
    
    
    self.settingLabel =[[UILabel alloc] init];
    self.settingLabel.textColor =[UIColor blackColor];

    [self.contentView addSubview:_settingLabel];
    self.settingLabel.numberOfLines =0;
    self.settingLabel.textAlignment =NSTextAlignmentLeft;
    self.settingLabel.font =[UIFont systemFontOfSize:15];
    
    self.activity =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.contentView.width -44) * 0.5, (self.contentView.height -44) * 0.5, 44, 44)];
    
    self.activity.activityIndicatorViewStyle =UIActivityIndicatorViewStyleGray;
    
    [self.contentView addSubview:self.activity];
    
    
    return self;
}

-(void)setDoctorbase:(DictorList *)doctorbase
{
    _doctorbase =doctorbase;
    
    //加载数据..
    [self loadData];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置frame
    self.settingLabel.frame =CGRectMake(10, 0, 300, 150);
    
}

-(void)loadData
{
    
//    NSDictionary * parmaters= @{@"doctor_id":self.doctorbase.doctor_id};

    //NSLog(@"%@",self.doctorbase.doctor_id);
    NSDictionary * parmaters= @{@"doctor_id":self.doctorbase.doctor_id};
    
    [self.activity startAnimating];
    self.activity.hidden=NO;
    
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORJZTJNET parameters:parmaters successBlock:^(id object) {
       
        //NSLog(@"%@",object);
        
        NSDictionary * dataDict= object;
        if ([dataDict[@"code"] integerValue]==0) {
            
            NSDictionary * receivingData= dataDict[@"data"];
            //转模型
            DoctorReceiving * receive = [DoctorReceiving DoctorReceivingWith:receivingData];
            //刷新视图
            NSString * settingString=[receive.receiving_settings componentsJoinedByString:@"\n"];
            
            self.settingLabel.text = [NSString stringWithFormat:@"接诊条件\n%@",settingString];
            //更新视图
            
            [self.activity stopAnimating];
            self.activity.hidesWhenStopped =YES;
        }
        else
        {
            self.settingLabel.text = [NSString stringWithFormat:@"暂无接诊条件"];
            [self.activity stopAnimating];
            self.activity.hidesWhenStopped =YES;
        }
        
        
        
    } FailBlock:^(NSError *error) {
        
    }];
}


@end
