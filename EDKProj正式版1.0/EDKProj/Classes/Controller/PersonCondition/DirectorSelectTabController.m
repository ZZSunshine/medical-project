//
//  DirectorSelectTabController.m
//  EDKProj
//
//  Created by 晓飞 on 15/1/6.

#import "DirectorSelectTabController.h"
#import "MJRefresh.h"
#import "EDKNetworking.h"
#import "DictorList.h"
#import "DirctorListTabCell.h"
#import "DoctorBaseViewController.h"

#define DirctorListTabCellId @"DirctorListTabCellId"

@interface DirectorSelectTabController()

@property (nonatomic,strong) NSMutableArray * arrayData;

@property (nonatomic,assign) NSInteger maxPage;

@property (nonatomic,assign) NSInteger currentPageSize;

@end

@implementation DirectorSelectTabController

#pragma mark --懒加载
-(NSArray *)arrayData
{
    if (_arrayData ==nil) {
        _arrayData =[NSMutableArray array];
    }
    return _arrayData;
}

//从上一个画面获取请求参数
-(void)setParmaters:(NSMutableDictionary *)parmaters
{
    _parmaters =parmaters;
    
//    {"ci1_id":1,"ci2_id":3,"ci3_id":3,"diagnosis_type":0,"page_size":15,"is_confirmed":1,"user_id":1000089, "page":1,"has_diagnosis":2}
//    dict[@"ci1_id"] = @(1);
//    dict[@"ci2_id"] = @(3);
//    dict[@"ci3_id"] = @(3);
//    dict[@"diagnosis_type"] = @(0);
//    dict[@"is_confirmed"] = @(1);
//    dict[@"user_id"] = @(1000089);
//    dict[@"has_diagnosis"] = @(2);
    
    [self MJRefreshControl];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    

    self.navigationItem.title =@"选择医生";
    
    
    //加载数据
    //self.view.backgroundColor =EDKRandomColor;
}

//创建下拉刷新
-(void)MJRefreshControl
{
   
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"查看更多医生信息" forState:MJRefreshStateIdle];
    [header setTitle:@"正在加载最新医生信息 ..." forState:MJRefreshStateRefreshing];
    
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
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"点击查看更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载信息..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多消息了..." forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#53D0E5"];
    
    // 设置footer
    self.tableView.mj_footer = footer;

    

}


-(void)loadNewData
{
    
    [self.arrayData removeAllObjects];
    //刚开始和每页显示的是一样的..
    self.currentPageSize =15;
    
    self.maxPage =1;
    
    _parmaters[@"page_size"]=@(15);
    _parmaters[@"page"]=@(self.maxPage);
    //使用类型来传递参数
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORLISTNET parameters:self.parmaters successBlock:^(id object) {
        
        //NSLog(@"%@",object);
        
        DataModel * model= [DataModel dataModelWith:object];
        if (model.code.integerValue ==0) {
            
            //字典转模型
            [model.data enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                DictorList * list=[DictorList DictorListWith:obj];
                
                [self.arrayData addObject:list];
            }];
     
            
            //刷新数据
            
            [self.tableView reloadData];
            //停止刷新
            [self.tableView.mj_header endRefreshing];
            
            self.tableView.mj_footer.state=MJRefreshStateIdle;
        }
        
    } FailBlock:^(NSError *error) {
        
        
    }];
}

//加载更多信息 的时候使用..
-(void)loadMoreData
{

    //判断数据是不是已经到最后了 记录的条数 已经小于没页的条数了
    if (self.currentPageSize < [_parmaters[@"page_size"] integerValue]) {
        
        //self.tableView.mj_footer.hidden=YES;
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
        return;
    }
    
    self.maxPage =self.maxPage +1;
    _parmaters[@"page"]=@(self.maxPage);

    //使用类型来传递参数
    [[EDKNetworking sharedNewtWorkTool] POST:DIRECTORLISTNET parameters:self.parmaters successBlock:^(id object) {
        
        //NSLog(@"%@",object);
        
        DataModel * model= [DataModel dataModelWith:object];
        if (model.code.integerValue ==0) {
            
            //字典转模型
            [model.data enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                DictorList * list=[DictorList DictorListWith:obj];
                
                [self.arrayData addObject:list];
            }];
            
            
            //把当前返回数据的条数 记录下来..
            self.currentPageSize = model.data.count;
            
            //刷新数据
            
            [self.tableView reloadData];

            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
    } FailBlock:^(NSError *error) {
        
        
    }];

}


#pragma mark --数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DirctorListTabCell * cell =[tableView dequeueReusableCellWithIdentifier:DirctorListTabCellId];
    if (cell ==nil) {
        //从xib 加载
        cell =[DirctorListTabCell DirctorListTabCellWithNid];
    }
    DictorList * doctorlist= self.arrayData[indexPath.row];
    cell.dlist =doctorlist;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark --代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取对应的 
    DictorList * doctorlist= self.arrayData[indexPath.row];
    //从storyBoard 直接跳转控制器
    UIStoryboard * doctorBaseBoard=[UIStoryboard storyboardWithName:@"DoctorBaseManage" bundle:nil];
    
    DoctorBaseViewController * doctorVc= [doctorBaseBoard instantiateInitialViewController];
    doctorVc.doctorlist =doctorlist;
    //跳到另外一个画面
    [self.navigationController pushViewController:doctorVc animated:YES];
    

}



@end
