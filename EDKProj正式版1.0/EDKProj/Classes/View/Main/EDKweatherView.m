//
//  EDKweatherView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/31.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKweatherView.h"
#import "EDKNetworking.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

//百度天气key


#define kBDWeather_KEY @"17IvzuqmKrK1cGwNL6VQebF9"
#define kGetWeather_URL(city) ([NSString stringWithFormat: @"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=%@", city, kBDWeather_KEY])


@interface EDKweatherView ()

@property (nonatomic,strong) UIImageView *img;

@property (nonatomic,strong) UILabel *lab;

@property (nonatomic,strong) UILabel *dateLabel;

//
@property (nonatomic,strong) NSDictionary *weatherDataDict;

@end



@implementation EDKweatherView
#pragma mark 懒加载
- (NSDictionary *)weatherDataDict {

    if (!_weatherDataDict) {
        
        _weatherDataDict = [[NSDictionary alloc]init];
    }
    return _weatherDataDict;
}


//1 重写init方法
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        //1 创建 中间的分割线
//        UIView *centerLine = [[UIView alloc]initWithFrame:CGRectMake(KWidth * 0.5, 3, 0.5, 28)];
//        
//        centerLine.backgroundColor = [UIColor lightGrayColor];
//        
//        [self addSubview:centerLine];
        
        //2 左边的按钮(天气图标)
        self.img = [[UIImageView alloc]init];
        
        [self addSubview:self.img];
        
        //3 右边显示的天气信息
        self.lab = [[UILabel alloc]init];
        
        self.lab.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:self.lab];
        
         self.dateLabel= [[UILabel alloc]init];
        
        self.dateLabel.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:self.dateLabel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self loadWeatherData];
        });
    }
    return self;
}

#pragma mark 加载天气数据

- (void)loadWeatherData {
    
    // 1 urlString
    NSString *urlString = kGetWeather_URL(@"北京");
    
    // 百分号转义
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //2 创建管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        self.weatherDataDict = dict;
        
        //赋值
        // 1 图片
        NSDictionary *dateDict = dict[@"results"][0][@"weather_data"][0];
        
        NSString *urlString = dateDict[@"dayPictureUrl"];
        
        NSLog(@"%@",urlString);
        
        NSURL *url = [NSURL URLWithString:urlString];

        [self.img sd_setImageWithURL:url];
        
        [self.img sizeToFit];
        
        //2 温度
        NSString *temper = dateDict[@"date"];
        
       // NSLog(@"%@",temper);  周四 03月31日 (实时：14℃)
        
        //字符串转为数组
        NSArray *arr = [temper componentsSeparatedByString:@" "];
        
        NSString *arrthree = arr[2];
        
        NSLog(@"%@",arrthree);
        
        NSString *temperlab1 = [arrthree substringFromIndex:4];
        
        NSString *temperlab =[temperlab1 substringToIndex:(temperlab1.length -1)];
        
        NSLog(@"%@",temperlab);
        
        self.lab.text = [NSString stringWithFormat:@"温度:%@",temperlab];
        
        [self.lab sizeToFit];
        
        //3 日期
        self.dateLabel.text = dict[@"date"];
        
        [self.dateLabel sizeToFit];
        
        [self reloadInputViews];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络错误");
    }];
    
}

//3 布局
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //布局
    self.img.frame = CGRectMake(KWidth * 0.75 - 10, 8, 20, 20);
    
    self.lab.frame = CGRectMake(KWidth - 20 -self.lab.width, 5, self.lab.width, self.lab.height);
    
    CGFloat marginY = CGRectGetMaxY(self.lab.frame);
    
    self.dateLabel.frame = CGRectMake(KWidth -15 - self.dateLabel.width, marginY +3, self.dateLabel.width, self.dateLabel.height);
}

@end
