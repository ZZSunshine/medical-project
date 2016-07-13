//
//  JiuzhengshijianCell.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "JiuzhengshijianCell.h"
#import "EDKNetworking.h"
#import "DictorList.h"
#import "DoctorZuozhenInfo.h"
#import "DoctorZuoZhenDetial.h"
#import "DoctorDutys.h"
#import "daySelectButton.h"

#define StringBackColor @"#4F5348"
#define BtnWeekColor @"#2FDCA0"
#define WeekViewColor @"#75E3ED"
#define DaysSeconds 24 * 60 * 60

#define YOUHAOIMAGE @"三类医院"
#define YUEMANCOLOR @"#3073ED"

@interface JiuzhengshijianCell()<UIScrollViewDelegate>

@property (nonatomic,strong) UIActivityIndicatorView * activity;
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UILabel * headerlabel;
@property (nonatomic,strong) UIView * hospitalView;
@property (nonatomic,strong) UIView * zuozhenView;

@property (nonatomic,weak) UIScrollView * dutyScrollView;
@property (nonatomic,weak) UILabel * centerLabel;

@property (nonatomic,strong) DoctorZuoZhenDetial * zuozhenDetial;
@end

@implementation JiuzhengshijianCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    //创建控件
    //self.backgroundColor = EDKRandomColor;
    
    //创建头部视图 显示坐诊信息 :
    _headerView=[[UIView alloc] init];
    
    [self.contentView addSubview:_headerView];
    _headerlabel =[[UILabel alloc] init];
    
    _headerlabel.text =@"可提前三周预约,每日8:00更新票源 \n坐诊信息:";
    _headerlabel.numberOfLines =0;
    _headerlabel.font =[UIFont systemFontOfSize:14];
    _headerlabel.frame =CGRectMake(10, 10, KWidth-20, 40);
    _headerView.frame =CGRectMake(0, 0, KWidth, 45);
    
    [self.headerView addSubview:_headerlabel];
    
    
    //中间可以选择医院的信息
    _hospitalView =[[UIView alloc] init];
    self.hospitalView.backgroundColor =[UIColor colorWithHexString:StringBackColor alpha:0.15];
    [self.contentView addSubview:_hospitalView];
    
    //坐诊时间表..
    _zuozhenView =[[UIView alloc] init];
    
    [self.contentView addSubview:_zuozhenView];
    
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



-(void)loadData
{
    //    NSDictionary * parmaters= @{@"doctor_id":self.doctorbase.doctor_id};
    
    //NSLog(@"%@",self.doctorbase.doctor_id);
    NSDictionary * parmaters= @{@"doctor_id":self.doctorbase.doctor_id};
    
    [self.activity startAnimating];
    self.activity.hidden=NO;

    
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORJZSJNET parameters:parmaters successBlock:^(id object) {
        
        //NSLog(@"%@",object);
        
        NSDictionary * dataDict= object;
        if ([dataDict[@"code"] integerValue]==0) {
            
            NSDictionary * receivingData= dataDict[@"data"];

            //EDKLog(@"%@",receivingData);
            
            DoctorZuozhenInfo * info =[DoctorZuozhenInfo zuozhenInfoWith:receivingData];
            
            
            //解析控件创建..
            
            //根据坐诊医院数组来判断 多少个控件
            if (info.zuozhen_infos) {
                //移除以后再添加
                [self.hospitalView removeFromSuperview];
                
                self.hospitalView =[[UIView alloc] init];
                self.hospitalView.backgroundColor =[UIColor colorWithHexString:StringBackColor alpha:0.15];
                [self.contentView addSubview:self.hospitalView];
                
              
                
                CGFloat marginY =3;
                CGFloat marginX =10;
                CGFloat lineHeight =18;
                
                CGFloat maxY = 0;
                //创建控件 需要判断 数据 来计算有 几组控件.. 主要用来显示医院信息
                for (NSInteger i=0; i<info.zuozhen_infos.count; i++) {
                    //
                    
                    DoctorZuoZhenDetial * detial = info.zuozhen_infos[i];
                    self.zuozhenDetial =detial;
                    
                    UIImageView * iconImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位"]];
                    [iconImageView sizeToFit];
                    iconImageView.frame =CGRectMake(marginX, marginY + i * (marginY+iconImageView.height) , lineHeight, lineHeight);
                    
                    //需要判断字符串的长度
                    
                    UILabel * titlabel =[[UILabel alloc] initWithFrame:CGRectMake(marginX * 2 + iconImageView.width, i * (marginY+iconImageView.height), 200, lineHeight)];
                    titlabel.font =[UIFont systemFontOfSize:14];
                    titlabel.textColor =[UIColor blackColor];
                    
                    NSString * fee =[NSString stringWithFormat:@"￥%@",detial.zuozhen_fee];
                    
                    CGRect feeRect = [fee boundingRectWithSize:CGSizeMake(90, lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
                    
                    UILabel * feelabel =[[UILabel alloc] initWithFrame:CGRectMake(KWidth - feeRect.size.width- 40, i * (marginY+iconImageView.height), feeRect.size.width, iconImageView.height)];
                    feelabel.font =[UIFont systemFontOfSize:14];
                    feelabel.textColor =[UIColor blackColor];
                    
                   
                    titlabel.text = detial.zuozhen_hospital_name;
                    feelabel.text = fee;
                    
                    [self.hospitalView addSubview:iconImageView];
                    [self.hospitalView addSubview:titlabel];
                    [self.hospitalView addSubview:feelabel];
                    
                    //如果是最后一个了
                    if (i == info.zuozhen_infos.count-1) {
                        maxY = CGRectGetMaxY(titlabel.frame) + marginY ;
                    }
                    
                }
                
                //往文字下面添加..
                self.hospitalView.frame =CGRectMake(20, self.headerView.bottom +10, KWidth-25, maxY);
                self.hospitalView.layer.cornerRadius =  maxY /5;
                self.hospitalView.layer.masksToBounds=YES;

                
            
                //先从ContentView 当中移除
                [self.zuozhenView removeFromSuperview];
                
                self.zuozhenView = [[UIView alloc] init];
                self.zuozhenView.frame =CGRectMake(0, self.hospitalView.bottom + 10, KWidth,400);
                [self.contentView addSubview:self.zuozhenView];
                
                //创建一个view 来记录 第几周的视图
                UIView * weekView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 40)];
                weekView.backgroundColor =[UIColor colorWithHexString:WeekViewColor alpha:0.15];
                
                
                //创建按钮往左
                UIButton * leftButton =[[UIButton alloc] initWithFrame:CGRectMake(KWidth * 0.5 -80-20, 0, 40, 40)];
                [leftButton setTitleColor:[UIColor colorWithHexString:BtnWeekColor] forState:UIControlStateNormal];
                [leftButton setTitle:@"<" forState:UIControlStateNormal];
                [leftButton addTarget:self action:@selector(leftWeekAction) forControlEvents:UIControlEventTouchUpInside];
                
                //显示第几周
                UILabel * centerLabel =[[UILabel alloc] init];
                centerLabel.centerX = KWidth * 0.5-40;
                centerLabel.width = 80;
                centerLabel.height =40;
                centerLabel.font =[UIFont systemFontOfSize:18];
                centerLabel.textColor =[UIColor colorWithHexString:BtnWeekColor];
                centerLabel.text =@"第一周";
                
                self.centerLabel = centerLabel;
                
                //往右的按钮
                UIButton * rightButton =[[UIButton alloc] initWithFrame:CGRectMake(centerLabel.right, 0, 40, 40)];
                [rightButton setTitleColor:[UIColor colorWithHexString:BtnWeekColor] forState:UIControlStateNormal];
                [rightButton setTitle:@">" forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(rightWeekAction) forControlEvents:UIControlEventTouchUpInside];
                
                [weekView addSubview:leftButton];
                [weekView addSubview:rightButton];
                [weekView addSubview:centerLabel];
                
                [self.zuozhenView addSubview:weekView];
                
                //先创建 上午中午下午的 label;
                //定义日期控件的大小
                CGFloat weekLabelW = 25;
                CGFloat weekLabelH = 25;
                CGFloat DutyButtonH =60;
                
                UILabel * firstWLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, weekView.bottom, weekLabelW, weekLabelH)];
                firstWLabel.backgroundColor =[UIColor colorWithHexString:@"#75E3ED" alpha:0.15];
                firstWLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
                firstWLabel.layer.borderWidth =0.5;
                
                UILabel * moringLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, firstWLabel.bottom, weekLabelW, DutyButtonH)];
                moringLabel.numberOfLines=0;
                moringLabel.text=@"上午";
                moringLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
                moringLabel.layer.borderWidth =0.5;
                
                UILabel * noonLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, moringLabel.bottom, weekLabelW, DutyButtonH)];
                noonLabel.text=@"中午";
                noonLabel.numberOfLines=0;
                noonLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
                noonLabel.layer.borderWidth =0.5;
                
                UILabel * afternoonLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, noonLabel.bottom, weekLabelW, DutyButtonH)];
                afternoonLabel.text=@"下午";
                afternoonLabel.numberOfLines=0;
                afternoonLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
                afternoonLabel.layer.borderWidth =0.5;
                
                [self.zuozhenView addSubview:firstWLabel];
                [self.zuozhenView addSubview:moringLabel];
                [self.zuozhenView addSubview:noonLabel];
                [self.zuozhenView addSubview:afternoonLabel];
                
                //创建一个scrollView 可以滚动
                UIScrollView * dutyScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(weekLabelW, weekView.bottom, KWidth- weekLabelW, afternoonLabel.bottom - weekView.bottom)];
                
                self.dutyScrollView =dutyScrollView;
                
                dutyScrollView.delegate =self;
                
                //一个scrollView 显示一周的信息
                
                //dutyScrollView.backgroundColor =EDKRandomColor;
                
                CGFloat DutyButtonW = dutyScrollView.width / 7;
                
                //创建排班表的Button
                NSNumber * period = info.period;
                NSString * start_date =info.start_date;
                
                NSInteger screenCount =  period.integerValue / 7;
                
                dutyScrollView.contentSize= CGSizeMake(dutyScrollView.width * screenCount, dutyScrollView.height);
                dutyScrollView.pagingEnabled=YES;
                dutyScrollView.bounces = NO;
                dutyScrollView.showsHorizontalScrollIndicator=NO;
                
                //把滚动视图加入...
                [self.zuozhenView addSubview:dutyScrollView];
                
                //根据返回的数据来判断显示可排班的日历
                NSDateFormatter * formatter= [[NSDateFormatter alloc]init];
                formatter.dateFormat=@"yyyy-MM-dd";
                NSDate * startDate =[formatter dateFromString:start_date];

                
                //定义一个可变的数组来接收
                NSMutableArray * dutysMutableArray = info.duties.mutableCopy;
                
                //循环添加控件 ，先添加抬头
                for (NSInteger i=0; i<period.integerValue; i++) {
                    
                    //获取新的日期 根据老日期
                    
                    CGFloat x  = i * DutyButtonW;
                    
                    NSDate * newDate = [startDate dateByAddingTimeInterval: i* DaysSeconds];
                    NSString * nowDateString =[formatter stringFromDate:newDate];
                    
                    NSString * weekdayString = [self getWeekDaysWithDate:newDate];
                    
                    UILabel * weekTitleLabel =[[UILabel alloc] initWithFrame:CGRectMake(x, 0, DutyButtonW, weekLabelH)];
                    
                    weekTitleLabel.font =[UIFont systemFontOfSize:10];
                    weekTitleLabel.numberOfLines =0;
                    
                    weekTitleLabel.textAlignment = NSTextAlignmentCenter;
                    weekTitleLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
                    weekTitleLabel.layer.borderWidth=0.5;
                    weekTitleLabel.text =weekdayString;
                    
                    //创建三行button //上 中 下 午
                    daySelectButton * dutyBtnMorn =[[daySelectButton alloc] initWithFrame:CGRectMake(x, weekTitleLabel.bottom, DutyButtonW, DutyButtonH)];
                    dutyBtnMorn.layer.borderColor =[UIColor lightGrayColor].CGColor;
                    dutyBtnMorn.layer.borderWidth=0.5;
                    dutyBtnMorn.titleLabel.font =[UIFont systemFontOfSize:12];
                    [dutyBtnMorn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    dutyBtnMorn.currentDateString =[NSString stringWithFormat:@"%@ 上午",nowDateString];
                    //dutyBtnMorn.backgroundColor =EDKRandomColor;
                    
                    //设置是不可点击的
                    dutyBtnMorn.enabled =NO;
                    
                    daySelectButton * dutyBtnNoon =[[daySelectButton alloc] initWithFrame:CGRectMake(x, dutyBtnMorn.bottom, DutyButtonW, DutyButtonH)];
                    dutyBtnNoon.layer.borderColor =[UIColor lightGrayColor].CGColor;
                    dutyBtnNoon.layer.borderWidth=0.5;
                    //dutyBtnNoon.backgroundColor =EDKRandomColor;
                    dutyBtnNoon.titleLabel.font =[UIFont systemFontOfSize:12];
                    [dutyBtnMorn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                    dutyBtnNoon.currentDateString =[NSString stringWithFormat:@"%@ 中午",nowDateString];
                    
                    //设置是不可点击的
                    dutyBtnNoon.enabled =NO;
                    
#pragma mark --约满的模拟
                    if (i % 5 ==0) {
                        [dutyBtnNoon setTitle:@"约满" forState:UIControlStateNormal];
                         [dutyBtnMorn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [dutyBtnNoon setBackgroundColor:[UIColor colorWithHexString:YUEMANCOLOR alpha:0.7]];
                    }
                    
                    daySelectButton * dutyBtnAfter =[[daySelectButton alloc] initWithFrame:CGRectMake(x, dutyBtnNoon.bottom, DutyButtonW, DutyButtonH)];
                    dutyBtnAfter.layer.borderColor =[UIColor lightGrayColor].CGColor;
                    dutyBtnAfter.layer.borderWidth=0.5;
                    //dutyBtnAfter.backgroundColor =EDKRandomColor;
                     dutyBtnAfter.titleLabel.font =[UIFont systemFontOfSize:12];
                    [dutyBtnAfter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                    dutyBtnNoon.currentDateString =[NSString stringWithFormat:@"%@ 下午",nowDateString];
                    
                    //设置是不可点击的
                    dutyBtnAfter.enabled =NO;
#pragma mark --约满的模拟
                    if (i % 6 ==1) {
                        [dutyBtnAfter setTitle:@"约满" forState:UIControlStateNormal];
                        [dutyBtnAfter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [dutyBtnAfter setBackgroundColor:[UIColor colorWithHexString:YUEMANCOLOR alpha:0.7]];
                    }
                    
                    [dutyScrollView addSubview:weekTitleLabel];
                    [dutyScrollView addSubview:dutyBtnMorn];
                    [dutyScrollView addSubview:dutyBtnNoon];
                    [dutyScrollView addSubview:dutyBtnAfter];
                    
                    //循环的方式 判断一下  排班应该放在哪个位置
                    if (dutysMutableArray) {
                        
                        for (NSInteger i=0; i<dutysMutableArray.count; i++) {
                            DoctorDutys * duty = dutysMutableArray[i];
                            if ([duty.duty_date isEqualToString:nowDateString]) {
                                
                                //如果匹配到了
                                //在上午 中显示内容
                                [dutyBtnMorn setTitle:@"有号" forState:UIControlStateNormal];
                                [dutyBtnMorn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                [dutyBtnMorn setImage:[UIImage imageNamed:YOUHAOIMAGE] forState:UIControlStateNormal];
                                [dutyBtnMorn setBackgroundColor:[UIColor colorWithHexString:WeekViewColor alpha:0.15]];
                                dutyBtnMorn.enabled =YES
                                ;
                                //添加点击事件
                                [dutyBtnMorn addTarget:self action:@selector(canDateClick:) forControlEvents:UIControlEventTouchUpInside];
                                
                                //并且 移除该条信息
                                [dutysMutableArray removeObject:duty];
                                break;
                            }
                        }
                    }
                    
                }

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

-(void)leftWeekAction
{
    //NSLog(@"往左点击");
    //
    if (self.dutyScrollView) {
        //设置
        self.centerLabel.text =@"第一周";
        [self.dutyScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
}

-(void)rightWeekAction
{
    //NSLog(@"往右点击");
    //
    if (self.dutyScrollView) {
        //设置
        self.centerLabel.text =@"第二周";
        [self.dutyScrollView setContentOffset:CGPointMake(self.dutyScrollView.width, 0) animated:YES];
        
    }
}

-(void)canDateClick:(daySelectButton *)sender
{
    NSLog(@"点击了预约");
    
    //弹出一个view 点击以后可以点击确认.. 跳转到另外一个画面
    //发送一个通知
    
    if (self.zuozhenDetial) {
        
    
        //获取一些参数传递过去
        NSMutableDictionary * parmaters =[NSMutableDictionary dictionary];
        
        parmaters[@"selectday"] = sender.currentDateString;
        parmaters[@"zuozhenDetial"] = self.zuozhenDetial;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"alerDateSelectAction" object:parmaters];
        
    }
  
    
}

#pragma mark --代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //scrollView 减速的时候触发
    NSInteger currentIndex = scrollView.contentOffset.x/scrollView.width;
    
    if (currentIndex ==0) {
        self.centerLabel.text =@"第一周";
    }
    else
    {
        self.centerLabel.text =@"第二周";
    }
}


-(NSString *)getWeekDaysWithDate:(NSDate *)date
{
    //获取日期
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    //返回周几 \n 几月几日
    NSString * dateString =[NSString stringWithFormat:@"%@\n%02ld月%02ld日",arrWeek[week-1],month,day];
    
    return dateString;
//    m_labDate.text=[NSString stringWithFormat:@"%d年%d月",year,month];
//    m_labToday.text=[NSString stringWithFormat:@"%d",day];
//    m_labWeek.text=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
}

@end
