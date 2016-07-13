//
//  EDKPostCollectionView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKPostCollectionView.h"
#include "EDKPostCollectionViewCell.h"

#define kCollectionViewCell @"EDKPost"

@interface EDKPostCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation EDKPostCollectionView

#pragma mark 懒加载
- (NSDate *)date {
    if (!_date) {
        
        _date = [NSDate date];
    }
    return _date;
}

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        //1 数据源对象和代理对象
        self.dataSource= self;
        self.delegate = self;
        
        //2 设置属性
        self.showsHorizontalScrollIndicator = NO;
        
        // 取消弹簧效果
        self.bounces = NO;
        
        // 设置翻页
        self.pagingEnabled = YES;
        // 注册 cell
        [self registerClass:[EDKPostCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCell];
        
    }
    
    return self;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.nextDay;
}

//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EDKPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
    // 将 channel 传递给 cell
    NSDate *today = self.date;
    
    cell.date = today;
    
    return cell;
    
}

#pragma mark UICollectionViewDelegate
@end
