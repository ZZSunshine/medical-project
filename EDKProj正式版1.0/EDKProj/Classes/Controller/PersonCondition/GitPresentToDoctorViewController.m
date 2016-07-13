//
//  GitPresentToDoctorViewController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.

#import "GitPresentToDoctorViewController.h"
#import "EDKCustomTextView.h"
#import "GItPresentToTabController.h"
@interface GitPresentToDoctorViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblImgTitle;
@property (weak, nonatomic) IBOutlet EDKCustomTextView *txtSendMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lblGitToPersonName;

@property (nonatomic,strong) EDKCustomTextView * costmertxtSendMsg;

@property (weak, nonatomic) IBOutlet UILabel *lblfee;
@property (nonatomic,strong) UILabel * lblmsgCount;




#define MAXINPUTLENGH 100

@end

@implementation GitPresentToDoctorViewController

-(UILabel *)lblmsgCount
{
    if (_lblmsgCount ==nil) {
        
        _lblmsgCount =[[UILabel alloc] initWithFrame:CGRectMake(self.txtSendMsg.width - 100, self.txtSendMsg.height-15, 100, 15)];
        _lblmsgCount.font =[UIFont systemFontOfSize:11];
        _lblmsgCount.textColor=[UIColor lightGrayColor];
        
        _lblmsgCount.textAlignment =NSTextAlignmentRight;
        
        //[self.txtSendMsg addSubview:_lblmsgCount];
        
    }
    
    return _lblmsgCount;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置属性
    [self setPropertites];
    
    //加载数据
    [self loadData];
    
    self.txtSendMsg.placeholder=@"您要跟医生说的话:";
    
    
    self.txtSendMsg.delegate =self;
    
    [self.txtSendMsg addSubview:self.lblmsgCount];
    
    [self.txtSendMsg bringSubviewToFront:self.lblmsgCount];
    
    //没输入之前
    [self lastManyChar:0];
    
    //view 添加手势 添加的时候使键盘消失..
    UITapGestureRecognizer * gesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:gesture];

}



-(void)lastManyChar:(NSInteger)inputCharLength
{
    //计算剩余多少字符
    self.lblmsgCount.text =[NSString stringWithFormat:@"还可以输入%ld字符",MAXINPUTLENGH - inputCharLength-1];
}

-(void)tapAction:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    
}

-(void)setPropertites
{
    self.lblImgTitle.layer.cornerRadius = self.lblImgTitle.height /2;
    self.lblImgTitle.layer.masksToBounds =YES;
    self.lblImgTitle.layer.borderWidth =5;
    self.lblImgTitle.layer.borderColor =[UIColor colorWithHexString:backImgColor].CGColor;
    
//    self.txtSendMsg
    self.lblfee.layer.cornerRadius = self.lblfee.height /5;
    self.lblfee.layer.masksToBounds =YES;
    self.lblfee.layer.borderWidth =1;
    self.lblfee.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    self.txtSendMsg.layer.borderWidth =1;
    self.txtSendMsg.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    self.btnConfirm.layer.cornerRadius = self.btnConfirm.height /5;
    self.btnConfirm.layer.masksToBounds =YES;
    
    
  
    
}


-(void)loadData
{
    NSString * doctorName=self.parmaters[@"doctorName"];
    
    self.lblGitToPersonName.text =[NSString stringWithFormat:@"赠送给%@医生",doctorName];
    
    NSNumber * fee=self.parmaters[@"fee"];
    self.lblfee.text = [NSString stringWithFormat:@"￥%@",fee];
    
    NSString * gitType = self.parmaters[@"giftype"];
    self.lblImgTitle.text = gitType;
    
    [self.btnConfirm setTitle:[NSString stringWithFormat:@"赠送%@",gitType] forState:UIControlStateNormal];
    
    self.navigationItem.title =[NSString stringWithFormat:@"赠送%@",gitType];

}


- (IBAction)btnSendToDoctorClick:(id)sender {
    
    //给医生送礼的时候 发送到支付画面..
    
    //需要传递的数据
    //多少费用..

    //使用stroyBoard 的方式创建
    UIStoryboard * payStoryboard =[UIStoryboard storyboardWithName:@"GitSendToPay" bundle:nil];
    
    GItPresentToTabController * gitPayVc =[payStoryboard instantiateInitialViewController];
    
    gitPayVc.parmaters = self.parmaters;
    //传递参数...
    
    [self.navigationController pushViewController:gitPayVc animated:YES];
    
}

#pragma mark -- 代理方法


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSInteger currentLength = range.location;
    if (currentLength < MAXINPUTLENGH) {
        
        //提醒输入..还有多少..
        [self lastManyChar:currentLength];
        
        return YES;
    }
    else
    {
        return NO;
    }

}


@end
