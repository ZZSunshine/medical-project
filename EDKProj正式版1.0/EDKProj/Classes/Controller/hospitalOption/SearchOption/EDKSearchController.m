//
//  EDKSearchController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.


#import "EDKSearchController.h"
#import "EDKSearchTableView.h"
#import "EDKBureausController.h"

@interface EDKSearchController ()

//tableView
@property (nonatomic,strong) EDKSearchTableView *tableView;

//文本框
@property (nonatomic,strong) UITextField *textField;


@end

@implementation EDKSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"医院搜索";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1 创建一个上面的视图
    [self createTopView];
    
    // 2 添加一个tableView
    EDKSearchTableView *searchView = [[EDKSearchTableView alloc]initWithFrame:CGRectMake(0, 109, self.view.width, self.view.height - 109) style:UITableViewStylePlain];
    
    searchView.hospitalBlockSuccess = ^(EDKHostral *hostral) {
        
        EDKBureausController *bueaus = [[EDKBureausController alloc]init];
        
        bueaus.hostral = hostral;
        
        [self.navigationController pushViewController:bueaus animated:YES];
    };
    
    
    self.tableView = searchView;
    
    [self.view addSubview:searchView];
    
}
- (void)createTopView {
    
    //1 创建view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 44)];
    
    //topView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:topView];
    
    //2 创建下划线
    UIView *Line = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + topView.height, self.view.width, 0.5)];
    
    Line.backgroundColor = [UIColor grayColor];
    //
    [self.view addSubview:Line];
    
    //3 添加一个文本输入框 和一个按钮
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(2, 5, topView.width * 6/7, 30)];
    
    self.textField = textField;
    
    [topView addSubview:textField];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    searchBtn.frame = CGRectMake(KWidth * 6/7, 5,KWidth * 1/7 ,30);
    
    [topView addSubview:searchBtn];
}

- (void)searchBtnClick {
    
    self.tableView.theName = self.textField.text;
    //刷新
    [self.tableView reloadData];
}

#pragma mark 重写set方法
- (void)setTheName:(NSString *)theName {
    
    _theName = theName;
    self.textField.text = theName;
    
    [self searchBtnClick];
}

@end
