//
//  EDKBureausController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.


#import "EDKBureausController.h"
#import "EDKBureausView.h"
#import "EDKPostTableViewController.h"



@interface EDKBureausController ()

@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIView *bottomView;


@end

@implementation EDKBureausController

//
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.title = @"选择科室";
    
    //1 设置上面的view
    [self createTopView];
    
    //2 创建下面的View
    [self createBottomView];
    
}

#pragma mark 上面view的设置

- (void)createTopView {
    
    //1 创建上面的view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWidth, 70)];
    
    //1.2 设置属性
    topView.backgroundColor = [UIColor whiteColor];
    
    //1.4 添加重点的切线
    UIView *centerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 69.5, KWidth, 0.5)];
    centerLine.backgroundColor = [UIColor grayColor];
    
    //1.5 添加子控件
    //2 医院名称
    UILabel *hospitalLabel = [[UILabel alloc]init];
    
    hospitalLabel.text = self.hostral.hospitalLabel;
    
    [hospitalLabel sizeToFit];
    
    hospitalLabel.frame = CGRectMake(10, 8, hospitalLabel.width, hospitalLabel.height);
    
    //3 医院等级
    UILabel *gradeLabel = [[UILabel alloc]init];
    
    gradeLabel.text = self.hostral.gradeLabel;
    
    [gradeLabel sizeToFit];
    
    gradeLabel.font = [UIFont systemFontOfSize:13];
    gradeLabel.textColor = [UIColor grayColor];
    
    gradeLabel.frame = CGRectMake(hospitalLabel.width + 18, 10, gradeLabel.width, gradeLabel.height);
    
    //4
    UIImageView *smallIconView = [[UIImageView alloc]init];
    
    smallIconView.image = [UIImage imageNamed:@"定位"];
    
    [smallIconView sizeToFit];
    
    smallIconView.frame = CGRectMake(10, hospitalLabel.height + 25, smallIconView.width, smallIconView.height);
    
    
    //5 医院地址
    UILabel *addressLabel = [[UILabel alloc]init];
    
    addressLabel.text = self.hostral.addressLabel;
    
    [addressLabel sizeToFit];
    
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    addressLabel.frame = CGRectMake(smallIconView.width + 12, hospitalLabel.height + 20, addressLabel.width, addressLabel.height);
    
    //5
    UILabel *distanceLabel = [[UILabel alloc]init];
    
    distanceLabel.text = self.hostral.distanceLabel;
    
    [distanceLabel sizeToFit];
    
    distanceLabel.font = [UIFont systemFontOfSize:13];
    distanceLabel.textColor = [UIColor colorWithHexString:backImgColor];
    
    distanceLabel.frame = CGRectMake(addressLabel.width + 2, hospitalLabel.height + 20, distanceLabel.width, distanceLabel.height);
    
    //按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"查看医院详情" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn sizeToFit];
    
    btn.frame = CGRectMake(topView.width - 10 - btn.width, 8, btn.width, btn.height);
    
    [btn addTarget:self action:@selector(optionsHostroy) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:btn];
    
    //添加
    [topView addSubview:hospitalLabel];
    [topView addSubview:gradeLabel];
    [topView addSubview:smallIconView];
    [topView addSubview:addressLabel];
    [topView addSubview:distanceLabel];
    [topView addSubview:centerLine];
    
    //1.6 在View上添加控件
    [self.view addSubview:topView];
    
    self.topView = topView;
}

- (void)optionsHostroy {
    
    //创建一个新的控制器显示医院的基本的信息
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKHostral" bundle:nil];
    
    UIViewController *controller = [board instantiateInitialViewController];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark 创建下面的View

- (void)createBottomView {
    
    CGFloat marginY = CGRectGetMaxY(self.topView.frame);
    
    EDKBureausView *bottomView = [[EDKBureausView alloc]initWithFrame:CGRectMake(0, marginY, KWidth, KHeight - 64 - 70)];
    
    bottomView.rightTableView.hostralBlock = ^(NSString *str) {
        
        //跳转控制器
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKPostTableViewController" bundle:nil];
        
        EDKPostTableViewController *postController = [board instantiateInitialViewController];
        
        [self.navigationController pushViewController:postController animated:YES];
        
    };
    
    [self.view addSubview:bottomView];
    
    self.bottomView = bottomView;
    
}








@end
