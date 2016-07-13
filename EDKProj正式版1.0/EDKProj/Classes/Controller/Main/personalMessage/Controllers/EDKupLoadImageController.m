//
//  EDKupLoadImageController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.

#import "EDKupLoadImageController.h"
#import "EDKupLoadImage.h"

@interface EDKupLoadImageController ()

@end

@implementation EDKupLoadImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人头像";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(storeClick)];

   

    
    self.view.backgroundColor = [UIColor redColor];
    EDKupLoadImage *setView = [[EDKupLoadImage alloc]init] ;
    setView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
    [self.view addSubview:setView];
    
    // Do any additional setup after loading the view.
}


- (void)storeClick {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
