//
//  ConditionSelectController.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/25.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "ConditionSelectController.h"
#import "TextFiledCommon.h"
#import "ButtonNormal.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CoreLabel.h"
#import "DiseaseSelectTabController.h"
#import "TabMutiController.h"
#import "DiseaseTypeOne.h"
#import "DiseaseInfo.h"
#import "EDKNetworking.h"
#import "DirectorSelectTabController.h"

#define lblHeaderX 24
#define lblHeaderY 12
#define margin 12
#define lblHeaderW 70
#define lblHeaderH 30
#define lblFooterW 240

#define txtX 24
#define txtH 36
#define marginTxt 8
#define btnH 36
#define btnW 36

#define unselectArrayImg @"右拉伸箭头灰色"
#define selectArrayImg @"右拉伸箭头绿色"

@interface ConditionSelectController()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UILabel * name_headlbl;
@property (nonatomic,strong) UILabel * namelbl;
@property (nonatomic,strong) UILabel * disease_headlbl;
@property (nonatomic,strong) UILabel * diseaselbl;

@property (nonatomic,strong) CoreLabel * marryLbl;

@property (nonatomic,strong) TextFiledCommon * txtDiseaseinfo; //选择疾病细分
@property (nonatomic,strong) TextFiledCommon * txtIsdiagnosed; //是否确诊
@property (nonatomic,strong) TextFiledCommon * txtIsCared; //是否参与过治疗
@property (nonatomic,strong) TextFiledCommon * txtbingfazheng; //并发症
@property (nonatomic,strong) TextFiledCommon * txtCaredType; //治疗方式

@property (nonatomic,weak) ButtonNormal * btnDiseaseinfo;
@property (nonatomic,weak) ButtonNormal * btnIsdiagnosed;
@property (nonatomic,weak) ButtonNormal * btnIsCared;
@property (nonatomic,weak) ButtonNormal * btnbingfazheng;
@property (nonatomic,weak) ButtonNormal * btnCaredType;

//确认按钮
@property (nonatomic,strong) ButtonNormal * btnConfirm;//确认按钮

@property (nonatomic,strong) TPKeyboardAvoidingScrollView * scrollView;

@property (nonatomic,strong) UITextField * inputText;

@property (nonatomic,strong) UIPickerView * pickerView;

//是否是疑似疾病选项
@property (nonatomic,strong) NSArray * isDiagnosedArray;
//是否是 接收过治疗
@property (nonatomic,strong) NSArray * isCaredArray;
//接收治疗的类型
@property (nonatomic,strong) NSArray * caredTypeArray;

@property (nonatomic,strong) UIToolbar * toolbar;

@property (nonatomic,assign) NSInteger currentPickerIdx;

//获取模型
@property (nonatomic,strong) DiseaseInfo * disinfo;

@end

@implementation ConditionSelectController

#pragma mark --懒加载
-(TPKeyboardAvoidingScrollView *)scrollView
{
    if (_scrollView ==nil) {
        
        _scrollView  =[[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}

-(DiseaseInfo *)disinfo
{
    if (_disinfo ==nil) {
        
        _disinfo =[[DiseaseInfo alloc] init];
    }
    
    return _disinfo;
    
}

/**
 *  返回工具栏
 *
 *
 */
-(UIToolbar *)toolbar
{
    if (_toolbar ==nil) {
        
        UIToolbar * toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        
        UIBarButtonItem * item1=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelInput)];
        
        //创建一个弹簧项目 用来撑开barButton 之间的间距
        UIBarButtonItem * flexedItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //使用普通样式
        UIBarButtonItem * itemFinish=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishInput)];
        
        
        toolBar.items=@[item1,flexedItem,itemFinish];
        
        _toolbar =toolBar;
    }
    return _toolbar;
}

-(UIPickerView *)pickerView
{
    if (_pickerView ==nil) {
        
        _pickerView =[[UIPickerView alloc] init];
        _pickerView.dataSource =self;
        _pickerView.delegate =self;
        
    }
    
    return _pickerView;
}

-(NSArray *)isDiagnosedArray
{
    if (_isDiagnosedArray ==nil) {
        
        _isDiagnosedArray = [NSArray array];
        
        _isDiagnosedArray =@[@"症状疑似",@"确诊症状"];
    }
    return  _isDiagnosedArray;
}

-(NSArray *)isCaredArray
{
    if (_isCaredArray ==nil) {
        
        _isCaredArray = [NSArray array];
        
        _isCaredArray =@[@"未接受过治疗",@"接受过治疗"];
    }
    return  _isCaredArray;
}


-(NSArray *)caredTypeArray
{
    if (_caredTypeArray ==nil) {
        
        _caredTypeArray = [NSArray array];
        
        _caredTypeArray =@[@"药物治疗",@"手术治疗",@"保守治疗"];
    }
    return  _caredTypeArray;
}

-(void)cancelInput
{
    [self.view endEditing:YES];
}


//完成输入的时候把对应的的值付给对应的值
-(void)finishInput
{
    NSInteger selectRow=[self.pickerView selectedRowInComponent:0];
    if (selectRow != -1) {
        
        if (self.currentPickerIdx ==0) {
            
            NSString * selectisDiagnosed = self.isDiagnosedArray[selectRow];
            self.txtIsdiagnosed.text =selectisDiagnosed;
            
        }
        else if(self.currentPickerIdx ==1)
        {
            NSString * selectisCared = self.isCaredArray[selectRow];
            self.txtIsCared.text =selectisCared;
            
            if([selectisCared isEqualToString:@"接受过治疗"])
            {
                [self changeCaredTypeWithFlag:1];
            }
            else
            {
                [self changeCaredTypeWithFlag:0];
            }
            
        }
        else if(self.currentPickerIdx ==2)
        {
            NSString * selectCaredType = self.caredTypeArray[selectRow];
            self.txtCaredType.text =selectCaredType;
        }
        
        [self.inputText resignFirstResponder];
       
    }
}


//创建隐藏控件，并且改变下一个控件的frame
-(void)changeCaredTypeWithFlag:(NSInteger)idx
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (idx ==1) {
            
            //显示控件并改变位置
            self.txtCaredType.frame =CGRectMake(txtX, CGRectGetMaxY(self.txtIsCared.frame) +marginTxt, KWidth - 2 * margin -74, txtH);
            
            self.txtCaredType.hidden=NO;
            
            self.btnCaredType.frame = CGRectMake(CGRectGetMaxX(self.txtCaredType.frame) , self.txtCaredType.top, btnW, btnH);
            
            self.btnCaredType.hidden=NO;
            
            self.txtbingfazheng.top =CGRectGetMaxY(self.txtCaredType.frame) + marginTxt;
            
            self.btnbingfazheng.top = self.txtbingfazheng.top;
        }
        else
        {
            //显示控件并改变位置
        
            self.txtCaredType.hidden=YES;
            
            self.btnCaredType.hidden=YES;
            
            self.txtbingfazheng.top =CGRectGetMaxY(self.txtIsCared.frame) + marginTxt;
            
            self.btnbingfazheng.top = self.txtbingfazheng.top;

        }
      
    }];
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    //NSLog(@"显示了");
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title=@"病情详情选择";

//    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"更多2"] forState:UIControlStateNormal];
//    [button sizeToFit];
//    UIBarButtonItem * backItem=[[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem=backItem;
    
    //添加返回按钮的事件
//    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    
    //创建一个看不见的textField
    
    self.inputText =[[UITextField alloc] init];
    [self.scrollView addSubview:self.inputText];
    
    [self createControl];
  
    //设置用户信息
    [self setuserInfo];
    
    //设置疾病类型
    self.diseaselbl.text = self.diseaseOne.ci1_name
    ;
}

#pragma mark --设置用户信息
-(void)setuserInfo
{
    UserInfoInstance * instance =[UserInfoInstance getuserInstance];
    self.namelbl.text =[NSString stringWithFormat:@"%@-%@",[instance getUserName],[instance getCredentialsnumkey]];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    //NSLog(@"显示");
//    if (self.scrollView) {
//        self.scrollView.contentOffset=CGPointMake(0, -64);
//    }
}


//创建控件 ,添加事件
-(void)createControl
{
    
    //需要从 首页传递过来...

    
    self.name_headlbl =[[UILabel alloc] initWithFrame:CGRectMake(lblHeaderX, lblHeaderY, lblHeaderW, lblHeaderH)];
    self.name_headlbl.text=@"用户信息:";
    self.name_headlbl.font =[UIFont systemFontOfSize:14];
    
    self.namelbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.name_headlbl.frame)+marginTxt, lblHeaderY, lblFooterW, lblHeaderH)];
    
    self.namelbl.text=@"测试用户...++++++++++++124214";
    self.namelbl.font =[UIFont systemFontOfSize:14];
    
    
    self.disease_headlbl =[[UILabel alloc] initWithFrame:CGRectMake(lblHeaderX, CGRectGetMaxY(self.namelbl.frame) +marginTxt, lblHeaderW, lblHeaderH)];
    self.disease_headlbl.text =@"疾病类型:";
    self.disease_headlbl.font =[UIFont systemFontOfSize:14];
    
    
    self.diseaselbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.disease_headlbl.frame)+marginTxt, self.disease_headlbl.top, lblFooterW, lblHeaderH)];
    self.diseaselbl.text =@"";
    self.diseaselbl.font =[UIFont systemFontOfSize:14];
    
    [self.scrollView addSubview:_name_headlbl];
    [self.scrollView addSubview:_namelbl];
    [self.scrollView addSubview:_disease_headlbl];
    [self.scrollView addSubview:_diseaselbl];
    

    
    //创建文本框
   
    self.txtDiseaseinfo =[[TextFiledCommon alloc] initWithFrame:CGRectMake(txtX, CGRectGetMaxY(self.disease_headlbl.frame) +margin, KWidth - 2 * margin -74, txtH)];
    self.txtDiseaseinfo.enabled =NO;
    
    self.txtIsdiagnosed =[[TextFiledCommon alloc] initWithFrame:CGRectMake(txtX, CGRectGetMaxY(self.txtDiseaseinfo.frame) +marginTxt, KWidth - 2 * margin -74, txtH)];
    self.txtIsdiagnosed.enabled =NO;
    
    self.txtIsCared =[[TextFiledCommon alloc] initWithFrame:CGRectMake(txtX, CGRectGetMaxY(self.txtIsdiagnosed.frame) +marginTxt, KWidth - 2 * margin -74, txtH)];
    self.txtIsCared.enabled =NO;
    
    self.txtbingfazheng =[[TextFiledCommon alloc] initWithFrame:CGRectMake(txtX, CGRectGetMaxY(self.txtIsCared.frame) +marginTxt, KWidth - 2 * margin -74, txtH)];
    self.txtbingfazheng.enabled =NO;
 
    [self.scrollView addSubview:_txtDiseaseinfo];
    [self.scrollView addSubview:_txtIsdiagnosed];
    [self.scrollView addSubview:_txtIsCared];
    [self.scrollView addSubview:_txtbingfazheng];
    
    //疾病信息
    ButtonNormal * btnDiseaseinfo = [[ButtonNormal alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.txtDiseaseinfo.frame) , self.txtDiseaseinfo.top, btnW, btnH) andTitle:@">"];
    
    btnDiseaseinfo.enabled=YES;
    
    [btnDiseaseinfo addTarget:self action:@selector(diseaseInfoClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnDiseaseinfo =btnDiseaseinfo;
    
    
    //是否疑似
    ButtonNormal * btnIsdiagnosed= [[ButtonNormal alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.txtDiseaseinfo.frame) , self.txtIsdiagnosed.top, btnW, btnH) andTitle:@">"];
    btnIsdiagnosed.enabled=NO;

    [btnIsdiagnosed addTarget:self action:@selector(isdiagnosedClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnIsdiagnosed = btnIsdiagnosed;
    
    //是否接受过治疗
    ButtonNormal * btnIsCared= [[ButtonNormal alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.txtDiseaseinfo.frame) , self.txtIsCared.top, btnW, btnH) andTitle:@">"];
    btnIsCared.enabled=NO;
    
    [btnIsCared addTarget:self action:@selector(IsCaredClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnIsCared =btnIsCared;
    
    //是否有并发症
    ButtonNormal * btnbingfazheng = [[ButtonNormal alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.txtDiseaseinfo.frame) , self.txtbingfazheng.top, btnW, btnH) andTitle:@">"];
    btnbingfazheng.enabled=NO;
    
    [btnbingfazheng addTarget:self action:@selector(bingfazhengClick) forControlEvents:UIControlEventTouchUpInside];
    self.btnbingfazheng =btnbingfazheng;

    
    [self.scrollView addSubview:btnDiseaseinfo];
    [self.scrollView addSubview:btnIsdiagnosed];
    [self.scrollView addSubview:btnIsCared];
    [self.scrollView addSubview:btnbingfazheng];
    
    
    
    //创建提示文字
    self.marryLbl =[[CoreLabel alloc] initWithFrame:CGRectMake(100, self.scrollView.bottom -150, 200, 20)];
    [self.scrollView addSubview:self.marryLbl];

    
    self.marryLbl.font =[UIFont systemFontOfSize:13];
    
    
    
    self.btnConfirm= [[ButtonNormal alloc] initWithFrame:CGRectMake(margin, self.scrollView.bottom- 120, KWidth- 2 *margin, 40) andTitle:@"就诊申请"];
    
    self.btnConfirm.enabled=NO;
    self.btnConfirm.layer.cornerRadius = 5;
    self.btnConfirm.layer.masksToBounds=YES;
    
    [self.btnConfirm addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:self.btnConfirm];
    
    
    
    //添加隐藏的控件
    self.txtCaredType =[[TextFiledCommon alloc] initWithFrame:CGRectMake(txtX, CGRectGetMaxY(self.txtIsCared.frame) +marginTxt, KWidth - 2 * margin -74, txtH)];
    self.txtCaredType.enabled =NO;
    self.txtCaredType.hidden =YES;
    
    [self.scrollView addSubview:self.txtCaredType];
    
    ButtonNormal * btnCaredType= [[ButtonNormal alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.txtCaredType.frame) , self.txtCaredType.top, btnW, btnH) andTitle:@">"];
    btnCaredType.enabled=YES;
    btnCaredType.hidden =YES;
    
    [btnCaredType addTarget:self action:@selector(caredTypeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnCaredType = btnCaredType;
    
    [self.scrollView addSubview:self.btnCaredType];
}


-(void)confirmCanClick
{
    
    NSString * diseaseInfo = self.txtDiseaseinfo.text;
    NSString * Isdiagnosed =self.txtIsdiagnosed.text;
    NSString * IsCared =self.txtIsCared.text;
    //NSString * bingfazheng =self.txtbingfazheng.text;
    
    if (diseaseInfo.length > 0 && Isdiagnosed.length >0 && IsCared.length >0) {
        
        if ([IsCared isEqualToString:@"接受过治疗"]) {
            NSString * caredType = self.txtCaredType.text;
            if (caredType.length >0) {
                self.btnConfirm.enabled =YES;
            }
            else
            {
                self.btnConfirm.enabled =NO;
            }
            
        }
        else
        {
            self.btnConfirm.enabled =YES;
        }

    }
    else
    {
        self.btnConfirm.enabled =NO;
    }

    
    
}

//选择疾病细分
-(void)diseaseInfoClick
{
    DiseaseSelectTabController * searchVc=[[DiseaseSelectTabController alloc] init];
    
    self.txtDiseaseinfo.enabled = YES;
    //传值过去
    
    //根据cid1 来判断类型
    
    //这个model 是首页传过来的
//    self.diseaseOne =[[DiseaseTypeOne alloc] init];
//    //
//    self.diseaseOne.ci1_id=@(1);
//    
//    self.diseaseOne.ci1_name=@"癌症类疾病";
    
    
    
    searchVc.Diseaseone = self.diseaseOne;
    
    __weak typeof(self) wself =self;
    
    searchVc.returnblock = ^(id model)
    {
        DiseaseInfo * info =model;
        //获取模型设置值
        wself.disinfo = info;
        //赋值
        wself.txtDiseaseinfo.text = info.ci3_name;
        
        wself.btnIsdiagnosed.enabled =YES;
        
        //判断确认按钮是不是可用
        [self confirmCanClick];
        
        
    };
    
    //用push 的方法
    [self.navigationController pushViewController:searchVc animated:YES];
    
  
}

//是否是疑似症状
-(void)isdiagnosedClick
{
    
    [self becomePickViewWithName:@"isdiagnosed"];
    //判断确认按钮是不是可用
    [self confirmCanClick];
}
//是否接收过治疗
-(void)IsCaredClick
{
    [self becomePickViewWithName:@"iscared"];
    //判断确认按钮是不是可用
    [self confirmCanClick];
}

//治疗方式
-(void)caredTypeClick
{
    [self becomePickViewWithName:@"caredType"];
    //判断确认按钮是不是可用
    [self confirmCanClick];
}


//确认按钮
-(void)btnConfirmClick
{
    //组合一个parmater 发送到医生选择画面
    //本来应该 根据用户选择的信息传递的 。没有数据..
    NSMutableDictionary * dict =[NSMutableDictionary dictionary];
    dict[@"ci1_id"] = @(1);
    dict[@"ci2_id"] = @(3);
    dict[@"ci3_id"] = @(3);
    dict[@"diagnosis_type"] = @(0);
    dict[@"is_confirmed"] = @(1);
    dict[@"user_id"] = @(1000089);
    dict[@"has_diagnosis"] = @(2);
    
    DirectorSelectTabController * dictorVc=[[DirectorSelectTabController alloc] init];
    dictorVc.parmaters = dict;
    
    [self.navigationController pushViewController:dictorVc animated:YES];
    
    //跳转控制器
    //EDKLog(@"跳转到医生选择画面");
}

-(void)becomePickViewWithName:(NSString *)btnName
{
    if ([btnName isEqualToString:@"isdiagnosed"]) {
        self.txtIsdiagnosed.enabled = YES;
        self.btnIsCared.enabled =YES;
        self.currentPickerIdx =0;
    }
    else if([btnName isEqualToString:@"iscared"])
    {
        self.txtIsCared.enabled = YES;
        self.btnCaredType.enabled =YES;
        self.btnbingfazheng.enabled =YES;
        self.currentPickerIdx =1;
    }
    else
    {
        self.txtCaredType.enabled = YES;
        self.currentPickerIdx =2;
    }
    //弹出键盘
    //让键盘显示 dataPacker
    
    self.inputText.inputAccessoryView=self.toolbar;
    self.inputText.inputView = self.pickerView;
    
    [self.inputText becomeFirstResponder];

}


-(void)bingfazhengClick
{
    TabMutiController * mutiVc=[[TabMutiController alloc] init];
    
    mutiVc.returnblock = ^ (NSString * returnString)
    {
        //返回值
        self.txtbingfazheng.text =returnString;
        
        //当所有的选择完以后 请求网络，来匹配医生..
        
        [self requestDoctorData];
        
        //判断确认按钮是不是可用
        [self confirmCanClick];
    };
    self.txtbingfazheng.enabled = YES;
    //传值过去
    
    mutiVc.disInfo = self.disinfo;

    //用push 的方法
    [self.navigationController pushViewController:mutiVc animated:YES];

}

#pragma mark --加载请求到的医生的数据
-(void)requestDoctorData
{
    //根据选择的数来来匹配医生
    
//    {"ci1_id":1,"ci2_id":3,"ci3_id":3,"diagnosis_type":0,"is_confirmed":1,"user_id":1000089, "has_diagnosis":2}
    
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    dict[@"ci1_id"] = @(1);
    dict[@"ci2_id"] = @(3);
    dict[@"ci3_id"] = @(3);
    dict[@"diagnosis_type"] = @(0);
    dict[@"is_confirmed"] = @(1);
    dict[@"user_id"] = @(1000089);
    dict[@"has_diagnosis"] = @(2);

    [[EDKNetworking sharedNewtWorkTool] POST:MATCHDIRECTORNET parameters:dict successBlock:^(id object) {
        
        
        NSDictionary * dictCount =object;
        if ([dictCount[@"code"] integerValue] ==0) {
         
            NSInteger dorctor_count = [dictCount[@"data"][@"doctor_count"] integerValue];
            
            NSString * countString = [NSString stringWithFormat:@"%ld",dorctor_count];
            self.marryLbl.text=[NSString stringWithFormat:@"已为您匹配到%ld为医生!",dorctor_count];
            
            
            [self.marryLbl addAttr:CoreLabelAttrColor value:[UIColor greenColor] range:NSMakeRange(6, countString.length)];
    
            [self.marryLbl updateLabelStyle];
        }
        else
        {
            self.marryLbl.text=[NSString stringWithFormat:@"已为您匹配到%d为医生!",0];
            self.marryLbl.textColor=[UIColor blackColor];
            
        }
       
        
        
    } FailBlock:^(NSError *error) {
        
    }];
}


-(void)backAction
{
    EDKLog(@"返回");
}

#pragma mark --pickview的数据源方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组当中有几个
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.currentPickerIdx ==0) {
        
        return self.isDiagnosedArray.count;
    }
    else if(self.currentPickerIdx ==1)
    {
        return self.isCaredArray.count;
    }
    else
    {
        return self.caredTypeArray.count;
    }
    
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.currentPickerIdx ==0) {
        
        return self.isDiagnosedArray[row];
    }
    else if(self.currentPickerIdx ==1)
    {
        
        return self.isCaredArray[row];
    }
    else
    {
        return self.caredTypeArray[row];
    }
    
}

#pragma mark -- pickview代理方法


@end
