//
//  DiseaseSelectTabController.m
//  EDKProj
//
//  Created by 晓飞 on 15/1/6.

#import "DiseaseSelectTabController.h"
#import "AFNetworking.h"
#import "HeaderSearchTabView.h"
#import "DiseaseSelectTabCell.h"
#import "EDKNetworking.h"
#import "PersonConditionNet.h"
#import "DataModel.h"
#import "DiseaseInfo.h"
#import "DiseaseTypeOne.h"
#import "MJRefresh.h"



#define DiseaseSelectTabCellId @"DiseaseSelectTabCellId"
@interface DiseaseSelectTabController()
//数据源疾病列表
@property (nonatomic,strong) NSMutableArray * arrayDiseases;

@property (nonatomic,strong) NSMutableArray * originalDiseases;

@end

@implementation DiseaseSelectTabController

#pragma mark --懒加载
-(NSMutableArray *)arrayDiseases
{
    if (_arrayDiseases ==nil) {
     
        _arrayDiseases =[NSMutableArray array];
    }
    
    return _arrayDiseases;
}

-(NSMutableArray *)originalDiseases
{
    if (_originalDiseases ==nil) {
        _originalDiseases =[NSMutableArray array];
    }
    return _originalDiseases;
}



//创建下拉刷新
-(void)MJRefreshControl
{
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"查看更多疾病信息" forState:MJRefreshStateIdle];
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



-(void)setDiseaseone:(DiseaseTypeOne *)Diseaseone
{
    _Diseaseone = Diseaseone;
    
    self.navigationItem.title = Diseaseone.ci1_name;
    //加载数据 根据传递过来的肿瘤类型
    
    //创建刷新控件..
    [self MJRefreshControl];
    

}

//另外一个画面需要的参数..

-(void)setDiseaseType:(NSString *)diseaseType
{
    _diseaseType =diseaseType;
    self.navigationItem.title = diseaseType;

    [self MJRefreshControl];
    
}


-(void)loadNewData
{
    
    //清除数据
    [self.arrayDiseases removeAllObjects];
    
    NSDictionary * parmarters;
    if (!self.Diseaseone) {
        parmarters=@{@"page":@(1),@"page_size":@(15),@"ci1_id":@(1),@"keyword":@""};
    }
    else
    {
        parmarters=@{@"page":@(1),@"page_size":@(15),@"ci1_id":_Diseaseone.ci1_id,@"keyword":@""};
    }

    [[EDKNetworking sharedNewtWorkTool] POST:DISEASEINFONET parameters:parmarters successBlock:^(id object) {
        
        //获取模型
        DataModel * model = [DataModel dataModelWith:object];
        
        if (model.code.integerValue==0) {
            //获取搜索数据
            [model.data enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                //获取数据，字典转模型
                DiseaseInfo * info =[DiseaseInfo DiseaseInfoWith:obj];
                [self.arrayDiseases addObject:info];
                
            }];
            
            self.originalDiseases = self.arrayDiseases;
            
            
            [self.tableView reloadData];
            //停止刷新
            [self.tableView.mj_header endRefreshing];
        }
        
    } FailBlock:^(NSError *error) {
        
    }];

}



-(void)viewDidLoad
{
    
    [super viewDidLoad];
    //self.tableView.backgroundColor = EDKRandomColor;
    
    HeaderSearchTabView * searchView=[[HeaderSearchTabView alloc] initWithFrame:CGRectMake(0, 44, KWidth, 44)];
    
    //给block 赋值
    searchView.block = ^(NSString * keyWord)
    {
        
        if (keyWord.length >0) {
            //如果取回来关键词 需要 过滤数组刷新
            NSPredicate * p =[NSPredicate predicateWithFormat:@"SELF.ci3_name CONTAINS %@",keyWord];
            
            self.arrayDiseases = [self.arrayDiseases filteredArrayUsingPredicate:p].mutableCopy;
            
            if (self.arrayDiseases.count ==0) {
                self.arrayDiseases = self.originalDiseases;
            }
        }
        else
        {
            self.arrayDiseases = self.originalDiseases;
        }
      
        
        [self.tableView reloadData];
        
    };
    
    //创建headerView
    self.tableView.tableHeaderView =searchView;
    
}

#pragma mark -- 实现数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayDiseases.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建单元格
    DiseaseSelectTabCell * cell = [tableView dequeueReusableCellWithIdentifier:DiseaseSelectTabCellId];
    if (cell == nil) {
        cell =[[DiseaseSelectTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DiseaseSelectTabCellId];
    }
    
    DiseaseInfo * info =self.arrayDiseases[indexPath.row];
    //传入模型
    cell.info = info;
    
    return cell;
   
    
}

#pragma mark --代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DiseaseInfo * info =self.arrayDiseases[indexPath.row];
    //tabelView 选中的时候返回
    //NSString * diseaseType=self.arrayDiseases[indexPath.row];
    
    //选中的时候返回
    
    if (self.returnblock) {
        
        [self.view endEditing:YES];
        //回调
        self.returnblock(info);
        
        //关闭画面
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    
}




























@end
