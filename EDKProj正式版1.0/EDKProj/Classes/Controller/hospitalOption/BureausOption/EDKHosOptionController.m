//
//  EDKHosOptionController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.


#import "EDKHosOptionController.h"
#import "EDKCustomButton.h"
#import "EDKDropListTableView.h"
#import "EDKSearchTableView.h"
#import "EDKPostTableViewController.h"

@interface EDKHosOptionController ()

//左边表
@property (nonatomic,strong) EDKDropListTableView *leftTableView;

//右边表
@property (nonatomic,strong) EDKDropListTableView *rightTableView;

//左边按钮
@property (nonatomic,strong) EDKCustomButton *leftButton;

//右边按钮
@property (nonatomic,strong) EDKCustomButton *rightButton;

//数据源 医院等级
@property (nonatomic,strong) NSMutableArray *gradeArray;

//数据源 医院地址
@property (nonatomic,strong) NSMutableArray *addressArray;
//
@property (nonatomic,strong) UITextField *textField;

//科室名称
@property (nonatomic,strong) UILabel *nameLabel;
@end

@implementation EDKHosOptionController

- (NSMutableArray *)addressArray {
    
    if (!_addressArray) {
        
        //
        _addressArray = [NSMutableArray arrayWithObjects:@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号",@"北京市东城区帅府园一号", nil];
    }
    return _addressArray;
}

- (NSMutableArray *)gradeArray {
    
    if (!_gradeArray) {
        
        _gradeArray = [NSMutableArray arrayWithObjects:@"三级甲等",@"三级乙等",@"二级甲等",@"二级乙等",@"一级甲等",@"一级乙等",@"特级甲等",@"特级乙等", nil];
    }
    return _gradeArray;
}

//重写get
- (NSString *)strName {
    
    return @"消化内科";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [self titleView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //1 上面固定的view
    [self createTextView];
    
    
    //2 中间的view(btn)
    [self createBtnTable];
    
    
    //3 下面的View(tableview)
    [self createTableView];
    
    //4 添加手势识别器
    //UITapGestureRecognizer *recoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigleTap:)];
    
    //[self.view addGestureRecognizer:recoginzer];
    
    
    //4 注册观察着    这里不用通知了,防止不明确那个对象来接受
    //注册观察者
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenTableView:) name:@"hidden" object:nil];
}

#pragma mark 现实手势识别器方法
- (void)sigleTap:(UITapGestureRecognizer *)gesture {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    //遍历keywindow里面的view
    
    for (UIView *view in app.keyWindow.subviews) {
        if ([view isKindOfClass:[EDKDropListTableView class]]) {
            
            //[view removeFromSuperview];
            
            self.rightButton.imageView.transform = CGAffineTransformIdentity;
            self.leftButton.imageView.transform = CGAffineTransformIdentity;
        }
    }
    
}


#pragma mark 执行观察者对象
//- (void)hiddenTableView:(NSNotification *)notify {
//
//    NSString *strM = notify.object;
//
//    //根据穿过来的值进行刷新 加载数据
//    if (self.leftButton.tag == 1) {
//
//        [self leftBtnClick:self.leftButton];
//    }
//    else {
//
//        [self rightBtnClick:self.rightButton];
//    }
//}
//
//- (void)dealloc {
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


#pragma mark 标题栏view

- (UIView *)titleView {
    
    //0 bottomView
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 35)];
    
    //1 创建view
    UITextField *optionHostral = [[UITextField alloc]init];
    bottomView.layer.cornerRadius = 15;
    bottomView.layer.masksToBounds = YES;
    
    //1.2 设置属性
    optionHostral.placeholder = @"输入医院名称查找";
    optionHostral.font = [UIFont systemFontOfSize:15];
    
    optionHostral.backgroundColor = [UIColor whiteColor];
    
    optionHostral.frame = CGRectMake(2, 2, 240, 30);
    
    //2.1 创建搜索按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    
    [btn sizeToFit];
    
    btn.frame = CGRectMake(bottomView.width - 30, 1, 28, 28);
    
    //添加
    [bottomView addSubview:optionHostral];
    [bottomView addSubview:btn];
    
    return bottomView;
}
#pragma mark 上面的view

- (void) createTextView {
    
    //1 view
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWidth, 38)];
    
    textView.backgroundColor = [UIColor whiteColor];
    //1.1 view 中的子控件
    UILabel *lableone = [[UILabel alloc]init];
    
    lableone.text = @"当前选择:";
    
    [lableone sizeToFit];
    
    lableone.textColor = [UIColor lightGrayColor];
    
    lableone.font = [UIFont systemFontOfSize:14];
    
    lableone.frame = CGRectMake(15, 10, lableone.width, lableone.height);
    
    [textView addSubview:lableone];
    
    //1.2 显示选择的
    UILabel *lableright = [[UILabel alloc]init];
    
    lableright.text = self.strName;
    
    [lableright sizeToFit];
    
    lableright.frame = CGRectMake(15 + lableone.width +5, 10, lableright.width, lableright.height);
    
    [textView addSubview:lableright];
    
    //1.3 分割线
    //底部分割线
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, textView.height- 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    
    bottomLine.backgroundColor = [UIColor grayColor];
    
    [textView addSubview:bottomLine];
    
    [self.view addSubview:textView];
}


#pragma mark 中间的view
- (void)createBtnTable {
    
    //1 创建一个大的view
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 38, self.view.bounds.size.width, 45)];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    
    //底部分割线
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.height- 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    
    bottomLine.backgroundColor = [UIColor grayColor];
    
    [bottomView addSubview:bottomLine];
    
    //中间分割线
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(bottomView.width * 0.5, 3, 0.5, bottomView.height -6)];
    
    centerLine.backgroundColor = [UIColor grayColor];
    
    [bottomView addSubview:centerLine];
    
    
    //2 创建左边自定义的按钮
    
    EDKCustomButton *leftButton = [[EDKCustomButton alloc]initWithFrame:CGRectMake(0, 0, bottomView.width * 0.5, bottomView.height)];
    
    [leftButton setTitle:@"医院等级" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton setImage:[UIImage imageNamed:@"右拉伸箭头灰色"] forState:UIControlStateNormal];
    
    leftButton.backgroundColor = [UIColor clearColor];
    
    //2.1 设置点击事件
    [leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButton = leftButton;
    
    //2.2 添加表
    CGFloat marignY = CGRectGetMaxY(bottomView.frame);
    
    EDKDropListTableView *leftTableView = [[EDKDropListTableView alloc]initWithFrame:CGRectMake(0, marignY, leftButton.width, 0)];
    
    //
    leftTableView.dataArray = self.addressArray;
    
    self.leftTableView = leftTableView;
    
    leftTableView.dropListBlcok = ^(NSString *str) {
        
        //__weak typeof(self) weakSelf;
        //根据穿过来的值进行刷新 加载数据
        if (self.leftButton.tag == 1) {
            
            [self leftBtnClick:self.leftButton];
        }
        else {
            
            [self rightBtnClick:self.rightButton];
        }
        
    };
    
    
    //3 创建右边自定义的按钮
    
    EDKCustomButton *rightButton = [[EDKCustomButton alloc]initWithFrame:CGRectMake(leftButton.width, 0, bottomView.width, bottomView.height)];
    
    rightButton.backgroundColor = [UIColor clearColor];
    
    [rightButton setTitle:@"医院地区" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [rightButton setImage:[UIImage imageNamed:@"右拉伸箭头灰色"] forState:UIControlStateNormal];
    
    //3.1 设置点击事件
    [rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //3.2 添加表
    
    EDKDropListTableView *rightTableView = [[EDKDropListTableView alloc]initWithFrame:CGRectMake(leftButton.width, marignY, leftButton.width, 0)];
    
    //赋值 添加数据
    rightTableView.dataArray = self.gradeArray;
    
    self.rightTableView = rightTableView;
    
    rightTableView.dropListBlcok = ^(NSString *str) {
        
        //防止循环
        //__weak typeof(self) weakSelf = self;
        //根据穿过来的值进行刷新 加载数据
        if (self.leftButton.tag == 1) {
            
            [self leftBtnClick:self.leftButton];
        }
        else {
            
            [self rightBtnClick:self.rightButton];
        }
        
    };
    
    
    self.rightButton = rightButton;
    
    //4 把按钮添加到View上
    [bottomView addSubview:leftButton];
    [bottomView addSubview:rightButton];
    
    [self.view addSubview:bottomView];
}

//两个点击事件
- (void)leftBtnClick:(EDKCustomButton *)sender {
    
    //0为了接受通知设置的一个值
    sender.tag = 1;
    self.rightButton.tag = 0;
    
    //1 先关闭右边
    [UIView animateWithDuration:0.2 animations:^{
        
        self.rightTableView.height = 0;
        self.rightButton.imageView.transform = CGAffineTransformIdentity;
    }];
    
    //2 获取高度
    CGFloat leftheight = self.leftTableView.height;
    
    //2.1 进行判断
    if (leftheight > 0) {
        
        //隐藏
        leftheight = 0;
        [UIView animateWithDuration:0.2 animations:^{
            
            self.leftTableView.height = leftheight;
            // 清除按钮的图片旋转
            sender.imageView.transform = CGAffineTransformIdentity;
            
        }];
        [self.leftTableView removeFromSuperview];
    }
    else {
        [[UIApplication sharedApplication].keyWindow addSubview:self.leftTableView];
        //显示
        [UIView animateWithDuration:0.2 animations:^{
            
            self.leftTableView.height = 230;
            
            [self.leftTableView reloadData];
            sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI * 0.9999/2);
        }];
    }
}

- (void)rightBtnClick:(EDKCustomButton *)sender {
    //0为了接受通知设置的一个值
    sender.tag = 1;
    self.leftButton.tag = 0;
    
    //1 先关闭左边
    [UIView animateWithDuration:0.2 animations:^{
        
        self.leftTableView.height = 0;
        self.leftButton.imageView.transform = CGAffineTransformIdentity;
    }];
    
    //2 获取高度进行判断   显示和隐藏
    CGFloat marginheight = self.rightTableView.height;
    
    if (marginheight > 0) {
        
        //
        marginheight = 0;
        [UIView animateWithDuration:0.2 animations:^{
            
            self.rightTableView.height = marginheight;
            // 清除按钮的图片旋转
            sender.imageView.transform = CGAffineTransformIdentity;
        }];
        [self.rightTableView removeFromSuperview];
    }
    else {
        
        //
        [[UIApplication sharedApplication].keyWindow addSubview:self.rightTableView];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.rightTableView.height = 230;
            [self.rightTableView reloadData];
            
            sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI * 0.9999/2);
            
        }];
    }
}


#pragma mark 下面的view

- (void)createTableView {
    
    //
    EDKSearchTableView *tableView = [[EDKSearchTableView alloc]initWithFrame:CGRectMake(0, 64 + 38 + 45, KWidth, KHeight) style:UITableViewStylePlain];
    //
    tableView.theName = self.textField.text;
    
    tableView.hospitalBlockSuccess = ^(EDKHostral *hostral) {
        
        //
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKPostTableViewController" bundle:nil];
        
        EDKPostTableViewController *post = [board instantiateInitialViewController];
        
        UIApplication *app = [UIApplication sharedApplication];
        
        //遍历keywindow里面的view
        
        for (UIView *view in app.keyWindow.subviews) {
            if ([view isKindOfClass:[EDKDropListTableView class]]) {
                
                [view removeFromSuperview];
                
                self.rightButton.imageView.transform = CGAffineTransformIdentity;
                self.leftButton.imageView.transform = CGAffineTransformIdentity;
            }
        }
        
        [self.navigationController pushViewController:post animated:YES];
    };
    
    [self.view addSubview:tableView];
    
}

@end
