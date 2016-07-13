//
//  HeaderSearchTabView.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "HeaderSearchTabView.h"
#define searchImage @"放大镜"

@interface HeaderSearchTabView()
@property (nonatomic,strong) UITextField * txtSearch;
@property (nonatomic,strong) UIButton * btnSearch;
@property (nonatomic,strong) UIView * lineView;

@end

@implementation HeaderSearchTabView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    //搜索框，搜索按钮，横线
    self.txtSearch =[[UITextField alloc] init];
    
    //一旦文本框值发生改变
    [self.txtSearch addTarget:self action:@selector(searchValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.btnSearch =[UIButton buttonWithType:UIButtonTypeCustom];
  
    [self.btnSearch setImage:[UIImage imageNamed:searchImage] forState:UIControlStateNormal];
    
//    [self.btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];

    [self.btnSearch sizeToFit];
    
    self.lineView =[[UIView alloc] init];
    self.lineView.backgroundColor =[UIColor colorWithHexString:@"#E6E6E6"];
    
    
    [self addSubview:self.txtSearch];
    [self addSubview:self.btnSearch];
    [self addSubview:self.lineView];
    

    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.txtSearch.frame=CGRectMake(12, 0, KWidth- 50, 40);
    self.btnSearch.frame =CGRectMake(CGRectGetMaxX(self.txtSearch.frame), 0, 44, 34);
    self.lineView.frame =CGRectMake(0, 40, KWidth, 1);
    
}



-(void)searchValueChanged:(UITextField *)sender
{
    //EDKLog(@"点击了搜索!");
    //需要使用block 回调 来筛选数据
    NSString * keyWord= self.txtSearch.text;
    
        
    if (self.block) {
        //回调
        self.block(keyWord);
        
    }
    

}

-(void)btnSearchClick
{
    
}

@end
