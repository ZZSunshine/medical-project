//
//  EDKMaterialSetViewController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.

#import "EDKMaterialSetViewController.h"
#import "EDKMaterialSet.h"
#import "EDKupLoadImageController.h"

#define kUserNameKey @"usernamekey"
#define kCredentialsNumKey @"credentialsnumkey"
#define kPhoneNumKey @"phonenumkey"
#define kGenderValueKey @"gendervaluekey"

@interface EDKMaterialSetViewController ()<EDKMaterialSetPushViewControllerDelegate>

@end

@implementation EDKMaterialSetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息修改";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(closeDissMiss)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    EDKMaterialSet *setView = [[EDKMaterialSet alloc]init] ;
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kUserNameKey];
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:kGenderValueKey];
    NSString *phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneNumKey];
    NSString *credentialsnum = [[NSUserDefaults standardUserDefaults] objectForKey:kCredentialsNumKey];
    
    setView.nameLabel.text = username;
    setView.sexLabel.text = gender;
    setView.phoneNUM.text = phoneNum;
    setView.cardID.text = credentialsnum;
    
    setView.delegate = self ;
    setView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
    [self.view addSubview:setView];
    
        
}

-(void)closeDissMiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewControllerchangeheadImage
{
    EDKupLoadImageController *vc = [[EDKupLoadImageController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)okBtn
{
    
    
}

@end
