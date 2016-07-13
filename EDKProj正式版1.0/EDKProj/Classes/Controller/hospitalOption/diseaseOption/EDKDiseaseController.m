//
//  EDKDiseaseController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.

#import "EDKDiseaseController.h"
#import "EDKBureausView.h"
#import "EDKSearchBureasController.h"
#import "EDKDiseaseOptionController.h"

@interface EDKDiseaseController ()

@end

@implementation EDKDiseaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 设置标题
    self.navigationItem.titleView = [self titleView];
    
    // 创建tableView
    
    [self createBottomView];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
}
#pragma mark 标题栏view

- (UIView *)titleView {
    
    //0 bottomView
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 35)];
    
    //1 创建view
    UITextField *optionHostral = [[UITextField alloc]init];
    bottomView.layer.cornerRadius = 15;
    bottomView.layer.masksToBounds = YES;
    //1.2 设置属性
    optionHostral.placeholder = @"输入疾病查找";
    optionHostral.font = [UIFont systemFontOfSize:15];
    
    optionHostral.backgroundColor = [UIColor whiteColor];
    
    optionHostral.frame = CGRectMake(2, 2, 240, 30);
    
    //2.1 创建搜索按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    
    [btn sizeToFit];
    
    btn.frame = CGRectMake(bottomView.width - 30, 1, 28, 28);
    
    [btn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //添加
    [bottomView addSubview:optionHostral];
    [bottomView addSubview:btn];
    
    return bottomView;
}

//搜索按钮
- (void)searchBtn {
    
    //1 控制器
    EDKSearchBureasController *controller = [[EDKSearchBureasController alloc]init];
    
    //2 传入数据
    controller.dataArray = @[@"高血压",@"高脂肪",@"高血脂",@"高血糖"].mutableCopy;
    
    //3 跳转
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark 创建下面的View

- (void)createBottomView {
    
    //    CGFloat marginY = CGRectGetMaxY(self.topView.frame);
    //
    //    EDKBureausView *bottomView = [[EDKBureausView alloc]initWithFrame:CGRectMake(0, marginY, KWidth, KHeight - 64 - 70)];
    
    //1 创建对象
    EDKBureausView *bottomView = [[EDKBureausView alloc]initWithFrame:CGRectMake(0, 64, KWidth, KHeight - 64)];
    
    bottomView.leftTableView.contentOffset = CGPointMake(0, -64);
    //执行block方法
    bottomView.rightTableView.hostralBlock = ^(NSString *str) {
        
        //
        EDKDiseaseOptionController *diseaseOption = [[EDKDiseaseOptionController alloc]init];
        
        [self.navigationController pushViewController:diseaseOption animated:YES];
        
    };
    
    [self.view addSubview:bottomView];
    
}


@end
