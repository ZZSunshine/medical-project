//
//  EDKSearchBureasController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.


#import "EDKSearchBureasController.h"
#import "EDKDropListTableView.h"
#import "EDKHosOptionController.h"

@interface EDKSearchBureasController ()

@property (nonatomic,strong) EDKDropListTableView *tableView;

@end

@implementation EDKSearchBureasController
#pragma mark 懒加载
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithObjects:@"消化内科",@"神经内科",@"感染内科",@"肾病内科",@"普通内科",@"心血管内科", nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 设置标题
    self.navigationItem.title = @"科室搜索";
    
    //2 创建搜索的view
    
    [self createTopView];
    
    //3 添加一个tableView
    EDKDropListTableView *searchView = [[EDKDropListTableView alloc]initWithFrame:CGRectMake(0, 109, self.view.width, self.view.height - 109)];
    
    searchView.dataArray = self.dataArray;
    
    self.tableView = searchView;
    
    searchView.dropList = ^(NSString *dict) {
        
        EDKHosOptionController *hosOption = [[EDKHosOptionController alloc]init];
        
        [self.navigationController pushViewController:hosOption animated:YES];
    };
    
    
    [self.view addSubview:searchView];
    
}
- (void)createTopView {
    
    //1 创建view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 44)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    //2 创建下划线
    UIView *Line = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + topView.height, self.view.width, 0.5)];
    
    Line.backgroundColor = [UIColor grayColor];
    //
    [self.view addSubview:Line];
    
    //3 添加一个文本输入框 和一个按钮
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(2, 5, topView.width * 6/7, 30)];
    
    [topView addSubview:textField];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    searchBtn.frame = CGRectMake(KWidth * 6/7, 5,KWidth * 1/7 ,30);
    
    [topView addSubview:searchBtn];
}

- (void)searchBtnClick {
    //刷新
    [self.tableView reloadData];
}


@end
