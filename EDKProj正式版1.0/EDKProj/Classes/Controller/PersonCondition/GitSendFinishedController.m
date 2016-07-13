//
//  GitSendFinishedController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.

#import "GitSendFinishedController.h"
#import "MMDrawerController.h"
@interface GitSendFinishedController ()

@property (weak, nonatomic) IBOutlet UILabel *lblImgTitle;


@property(nonatomic,weak) IBOutlet UILabel
* lblJifenLabel;

@property (weak, nonatomic) IBOutlet UIButton *btnGoToPersonCenter;

@property (weak, nonatomic) IBOutlet UIButton *btnGoToIndex;

@end

@implementation GitSendFinishedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置圆角
    [self setPropertites];
    
    //加载数据
    [self loadData];
    
}


-(void)loadData
{
    NSString * doctorName=self.parmaters[@"doctorName"];
    
    //self.lblSendDoctorName.text =[NSString stringWithFormat:@"赠送给%@医生",doctorName];
    
    NSNumber * fee=self.parmaters[@"fee"];
    self.lblJifenLabel.text = [NSString stringWithFormat:@"%@医生已收到您的礼物,您已经获得%@ 积分",doctorName,fee];
    
    NSString * gitype= self.parmaters[@"giftype"];
    self.lblImgTitle.text =[NSString stringWithFormat:@"%@",gitype];
    
    
    
    
}


-(void)setPropertites
{
    self.lblImgTitle.layer.cornerRadius = self.lblImgTitle.height /2;
    self.lblImgTitle.layer.masksToBounds =YES;
    self.lblImgTitle.layer.borderWidth =5;
    self.lblImgTitle.layer.borderColor =[UIColor colorWithHexString:backImgColor].CGColor;
    
    //    self.txtSendMsg
  
    //设置圆角
    self.btnGoToIndex.layer.cornerRadius = self.btnGoToIndex.height /5;
    self.btnGoToIndex.layer.masksToBounds =YES;
    
    [self.btnGoToIndex setBackgroundColor:[UIColor colorWithHexString:backImgColor]];
    [self.btnGoToIndex setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.btnGoToPersonCenter.layer.cornerRadius = self.btnGoToPersonCenter.height /5;
    self.btnGoToPersonCenter.layer.masksToBounds =YES;
    
    [self.btnGoToPersonCenter setBackgroundColor:[UIColor colorWithHexString:backImgColor]];
    [self.btnGoToPersonCenter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.lblJifenLabel.font =[UIFont systemFontOfSize:14];
    self.lblJifenLabel.numberOfLines =0;
    
}


- (IBAction)goToPersonCenter:(UIButton *)sender {
    
    //返回个人中心
    //发送通知 来通知首页 展开
    [[NSNotificationCenter defaultCenter]postNotificationName:@"popToIndexPersonCenter" object:nil];
    
    //返回根控制器
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)backToIndex:(id)sender {
    
    //返回到根控制器..
    //返回首页
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
