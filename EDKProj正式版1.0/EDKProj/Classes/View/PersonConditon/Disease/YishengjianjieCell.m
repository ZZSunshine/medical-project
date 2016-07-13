//
//  YishengjianjieCell.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 晓飞. All rights reserved.
//


#import "YishengjianjieCell.h"
#import "EDKNetworking.h"
#import "DoctorReceiving.h"
#import "DictorList.h"
#import "DoctorIntroduction.h"

@interface YishengjianjieCell()


@property (nonatomic,strong) UIActivityIndicatorView * activity;
@property (nonatomic,strong) UIView * labesView;
@property (nonatomic,strong) UILabel * introductionLabel;



@end

@implementation YishengjianjieCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    //创建控件
    //self.backgroundColor = EDKRandomColor;
    
    _introductionLabel =[[UILabel alloc] init];
    _labesView =[[UIView alloc] init];
    
    _labesView.backgroundColor =[UIColor colorWithHexString:@"#4F5348" alpha:0.15];
    
    [self.contentView addSubview:_introductionLabel];
    [self.contentView addSubview:_labesView];
    
    _introductionLabel.numberOfLines=0;
    _introductionLabel.font =[UIFont systemFontOfSize:14];
    
    self.activity =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.contentView.width -44) * 0.5, (self.contentView.height -44) * 0.5, 44, 44)];
    
    self.activity.activityIndicatorViewStyle =UIActivityIndicatorViewStyleGray;
    
    [self.contentView addSubview:self.activity];

    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)setDoctorbase:(DictorList *)doctorbase
{
    _doctorbase =doctorbase;
    
    [self loadData];
}

-(void)loadData
{
    
    //    NSDictionary * parmaters= @{@"doctor_id":self.doctorbase.doctor_id};
    
    //NSLog(@"%@",self.doctorbase.doctor_id);
    NSDictionary * parmaters= @{@"doctor_id":self.doctorbase.doctor_id};
    
    [self.activity startAnimating];
    self.activity.hidden=NO;
    
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORYYJJNET parameters:parmaters successBlock:^(id object) {
        
        //NSLog(@"%@",object);
        
        NSDictionary * dataDict= object;
        if ([dataDict[@"code"] integerValue]==0) {
            
            NSDictionary * receivingData= dataDict[@"data"];
            
            DoctorIntroduction * introduction =[DoctorIntroduction doctorIntroductionWith:receivingData];
            introduction.doctor_lables = @[@"中华精神病医院协会副会长",@"海外医疗协会理事",@"中美友好医院福干事长"];
            
            //需要根据数据动态来设置frame 和控件的数量
            if (introduction.doctor_lables) {
                
                //清空内容

                
                //移除以后再添加
                [self.labesView removeFromSuperview];
                
                self.labesView =[[UIView alloc] init];
                self.labesView.backgroundColor =[UIColor colorWithHexString:@"#4F5348" alpha:0.15];
                [self.contentView addSubview:self.labesView];
                

                CGFloat marginY =3;
                CGFloat marginX =10;
                
                CGFloat maxY = 0;
                //创建控件 需要判断 数据 来计算有 几组控件..
                for (NSInteger i=0; i<introduction.doctor_lables.count; i++) {
                    //
                    UIImageView * iconImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头衔"]];
                    [iconImageView sizeToFit];
                    iconImageView.frame =CGRectMake(marginX, marginY + i * (marginY+iconImageView.height) , iconImageView.width, iconImageView.height);
                    
                    UILabel * titlabel =[[UILabel alloc] initWithFrame:CGRectMake(marginX * 2 + iconImageView.width, i * (marginY+iconImageView.height), KWidth - 20, iconImageView.height)];
                    titlabel.font =[UIFont systemFontOfSize:13];
                    titlabel.textColor =[UIColor blackColor];
                    titlabel.text = introduction.doctor_lables[i];
                    
                    [self.labesView addSubview:iconImageView];
                    [self.labesView addSubview:titlabel];
                    
                    //如果是最后一个了
                    if (i == introduction.doctor_lables.count-1) {
                        maxY = CGRectGetMaxY(titlabel.frame) + marginY ;
                    }
                    
                }
                self.labesView.frame =CGRectMake(20, 0, KWidth-40, maxY);
                self.labesView.layer.cornerRadius =  maxY /5;
                self.labesView.layer.masksToBounds=YES;
        
                
                //如果是上面有标签，然后下面 设置描述 的frame
                self.introductionLabel.text = introduction.introduction;
                CGRect stringRect = [introduction.introduction boundingRectWithSize:CGSizeMake(KWidth-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
                
                self.introductionLabel.frame =CGRectMake(marginX, maxY+10, stringRect.size.width, stringRect.size.height+5);
            }
            else
            {
                //给介绍label 设置frame
                self.introductionLabel.text = introduction.introduction;
                CGRect stringRect = [introduction.introduction boundingRectWithSize:CGSizeMake(KWidth-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
                
                self.introductionLabel.frame =CGRectMake(5, 10, stringRect.size.width, stringRect.size.height+5);
            }
            
            
            
            [self.activity stopAnimating];
            self.activity.hidesWhenStopped =YES;
        }
        else
        {

            [self.activity stopAnimating];
            self.activity.hidesWhenStopped =YES;
        }
        
        
        
    } FailBlock:^(NSError *error) {
        
    }];
}


@end
