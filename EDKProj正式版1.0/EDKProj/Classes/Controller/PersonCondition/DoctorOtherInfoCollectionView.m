//
//  DoctorOtherInfoCollectionView.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "DoctorOtherInfoCollectionView.h"
#import "JiuzhengshijianCell.h"
#import "JiuzhengtiaojianCell.h"
#import "YishengjianjieCell.h"

#import "DictorList.h"

#define JiuzhengshijianCellId @"JiuzhengshijianCellId"
#define JiuzhengtiaojianCellId @"JiuzhengtiaojianCellId"
#define YishengjianjieCellId @"YishengjianjieCellId"

//自己当自己的代理，自己当自己的数据源
@interface DoctorOtherInfoCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@end

@implementation DoctorOtherInfoCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self =[super initWithFrame:frame collectionViewLayout:layout];
    
    //创建控件..
    self.pagingEnabled =YES;
    self.bounces =NO;
    self.showsHorizontalScrollIndicator=NO;
    
    self.dataSource =self;
    self.delegate =self;
    
    self.backgroundColor =[UIColor whiteColor];
    
    //注册单元格
    
    [self registerClass:[JiuzhengshijianCell class] forCellWithReuseIdentifier:
        JiuzhengshijianCellId];
    
    [self registerClass:[JiuzhengtiaojianCell class] forCellWithReuseIdentifier:JiuzhengtiaojianCellId];
    
    [self registerClass:[YishengjianjieCell class] forCellWithReuseIdentifier:YishengjianjieCellId];
    
    return self;
}

//三个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(void)setDoctorBase:(DictorList *)doctorBase
{
    _doctorBase =doctorBase;
    
    [self reloadData];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item ==0) {
        
        //创建控件
        JiuzhengtiaojianCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:JiuzhengtiaojianCellId forIndexPath:indexPath];
        
        //NSLog(@"%@",self.doctorBase.doctor_id);
        //传入到cell 当中去
        cell.doctorbase =self.doctorBase;
        
        
        
        return cell;
    }
    else if(indexPath.item ==1)
    {
        YishengjianjieCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:YishengjianjieCellId forIndexPath:indexPath];
        
        cell.doctorbase =self.doctorBase;
        
        return cell;
    }
    else
    {
        JiuzhengshijianCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:JiuzhengshijianCellId forIndexPath:indexPath];
        
        cell.doctorbase =self.doctorBase;

        
        return cell;
    }
    
}

#pragma mark --scrollViewDeleagate
//停止滚动的时候 触发
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //判断滚动到第几个屏幕了
    NSInteger currentIndex= scrollView.contentOffset.x / KWidth;
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoctorContentScroll" object:@(currentIndex)];
    
}

@end
