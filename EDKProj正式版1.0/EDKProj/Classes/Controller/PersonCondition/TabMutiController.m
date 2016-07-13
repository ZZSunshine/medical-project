//
//  TabMutiController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/26.


#import "TabMutiController.h"
#import "MutiIItemSelectCell.h"
#import "EDKNetworking.h"
#import "DataModel.h"
#import "Complication.h"
#import "DiseaseInfo.h"
#import "MJRefresh.h"

#define MutiIItemSelectCellId @"MutiIItemSelectCellId"

@interface TabMutiController()

@property (nonatomic,strong) NSMutableArray * arrayData;

@property (nonatomic,strong) NSMutableArray * returnData;

@end

@implementation TabMutiController
#pragma mark --懒加载
-(NSMutableArray *)arrayData
{
    if (_arrayData ==nil) {
        
        _arrayData =[NSMutableArray array];
    }
    
    return _arrayData;
}


-(NSMutableArray *)returnData
{
    if (_returnData ==nil) {
        
        _returnData =[NSMutableArray array];
    }
    
    return _returnData;
}


//创建下拉刷新
-(void)MJRefreshControl
{
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"查看更多并发症信息" forState:MJRefreshStateIdle];
    [header setTitle:@"正在加载最新信息 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor colorWithHexString:@"#53D0E5"];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableView.mj_header = header;
    
    
    
}

-(void)loadNewData
{
    [self.arrayData removeAllObjects];
    
    //加载数据
    //    NSDictionary * parmarter=@{@"page":@(1),@"page_size":@(15),@"ci2_id":disInfo.ci2_id};
    
    NSDictionary * parmarter=@{@"page":@(1),@"page_size":@(15),@"ci2_id":@(3)};
    //从网络上加载数据
    
    [[EDKNetworking sharedNewtWorkTool] POST:BINGFAZHENGNET parameters:parmarter successBlock:^(id object) {
        
        // NSLog(@"%@",object);
        DataModel * model= [DataModel dataModelWith:object];
        if (model.code.integerValue ==0) {
            
            [model.data enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Complication * comp=[Complication ComplicationWith:obj];
                
                [self.arrayData addObject:comp];
            }];
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            
        }
        
    } FailBlock:^(NSError *error) {
        
        
    }];
}


-(void)setDisInfo:(DiseaseInfo *)disInfo
{
    _disInfo =disInfo;
    
    self.navigationItem.title= @"疾病搜索";
    //先使用假数据来构造
    
    [self MJRefreshControl];
    
}



-(void)viewDidLoad
{
    
    [super viewDidLoad];

    //允许多选
    self.tableView.allowsMultipleSelection =YES;
    
    //确定按钮
    UIButton * btnConfirm=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnConfirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btnConfirm.frame =CGRectMake(0, 0, 50, 25);
    btnConfirm.titleLabel.font =[UIFont systemFontOfSize:15];
    
    btnConfirm.layer.borderColor = [UIColor whiteColor].CGColor;
    btnConfirm.layer.borderWidth = 1;
    
    btnConfirm.layer.cornerRadius =5;
    btnConfirm.layer.masksToBounds =YES;
    
    //在rightItem 创建button 确定
    UIBarButtonItem * rigthItem=[[UIBarButtonItem alloc] initWithCustomView:btnConfirm];
    
    //添加到标题栏去
    self.navigationItem.rightBarButtonItem =rigthItem;

    
}


-(void)confirmClick
{
    //EDKLog(@"确认!");
    
    NSString * arrString=@"";
    //把数组的元素拼接成字符串
    if (self.returnData.count >0) {
        arrString =[self.returnData componentsJoinedByString:@","];
        
    }
    
    if (self.returnblock) {
        self.returnblock(arrString);
    }
    //返回删一个页面
    [self.navigationController popViewControllerAnimated:YES];
   
  
}

#pragma mark -- 实现数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建单元格
    MutiIItemSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:MutiIItemSelectCellId];
    if (cell == nil) {
        cell =[[MutiIItemSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MutiIItemSelectCellId];
    }
    
    cell.selected = NO;
    
    Complication * comp =self.arrayData[indexPath.row];
    //传入模型
    cell.comp = comp;
    
    return cell;
    
    
}

#pragma mark --代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //选中时候的状态
    MutiIItemSelectCell * selectCell=[tableView cellForRowAtIndexPath:indexPath];
    
    Complication * comp= self.arrayData[indexPath.row];
    NSString * title=  comp.complication_name;
    [self containsObject:title andFunNum:0];
    
    selectCell.selected = YES;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中时候的状态
    MutiIItemSelectCell * selectCell=[tableView cellForRowAtIndexPath:indexPath];
    
    Complication * comp= self.arrayData[indexPath.row];
    
    NSString * title=  comp.complication_name;
    
    [self containsObject:title andFunNum:1];
    
    selectCell.selected = NO;

}

-(void)containsObject:(NSString *)title andFunNum:(NSInteger)idx
{
        //增加的方法判断
    __block BOOL flag= NO;
    if (idx ==0) {
        
        if (self.returnData.count ==0) {
            [self.returnData addObject:title];
        }
        
        [self.returnData enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isEqualToString:title]) {
                
                flag =YES;
                *stop = YES;
            }
            
        }];
        
        //如果元素内不包含该元素
        if (!flag) {
            [self.returnData addObject:title];
        }
    }
    else
    {
        //删除数组元素的方法
        [self.returnData enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isEqualToString:title]) {
                
                [self.returnData removeObject:obj];
                *stop =YES;
            }
        }];

    }
    
   // NSLog(@"%@",self.returnData);
    
    
}



@end
