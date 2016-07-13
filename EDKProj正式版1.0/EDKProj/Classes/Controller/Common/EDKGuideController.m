//
//  EDKGuideController.m
//  EDKProj
//
//  Created by wuliang on 16/3/30.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKGuideController.h"
#import "EDKGuideCell.h"
#import "UIView+CZExtension.h"
#import "EDKMainViewController.h"
#import "EDKNavController.h"
#import "MMDrawerController.h"
#import "EDKPersonalMessageController.h"

@interface EDKGuideController ()<UIScrollViewDelegate>

// 数组 用来存放所有的背景图片的
@property (nonatomic, strong) NSArray *bgImgsArr;

// 轮播点
@property (nonatomic, weak) UIImageView *LunBOPointView;



@end

@implementation EDKGuideController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // 1.关闭弹簧效果
    self.collectionView.bounces = YES;
    // 2.关闭横条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 3.设置分页效果
    self.collectionView.pagingEnabled = YES;
    
    // 注册cell
    [self.collectionView registerClass:[EDKGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //self.collectionView.delegate =self;
    
    // 3.打文字
    UIImageView *LunBOPointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"轮播点1"]];
    
    LunBOPointView.y = self.collectionView.height - 50;
    
    LunBOPointView.x = ( self.collectionView.width - LunBOPointView.width ) * 0.5;
    
    self.LunBOPointView = LunBOPointView;
    
    [self.collectionView addSubview:LunBOPointView];
    
    
}


- (instancetype)init
{
    // 1.创建流水布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    // 1.2 设置item的大小
    flow.itemSize = [UIScreen mainScreen].bounds.size;
    // 1.3 设置滑动方向
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 1.4 调整间距
    flow.minimumLineSpacing = 0;
    
    
    return [super initWithCollectionViewLayout:flow];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.bgImgsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    EDKGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 1.2 如果是最后一个item，就显示按钮
    if (indexPath.item == self.bgImgsArr.count - 1) {
        
        cell.experienceBtn.hidden = NO;
        
        cell.skipBtn.hidden = YES;
        
    } else {
        
        cell.experienceBtn.hidden = YES;
        
        cell.skipBtn.hidden = NO;
    }
    
    // 赋值
    cell.backgroundImg = self.bgImgsArr[indexPath.row];
    
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX > 2 * KWidth + 10) {
        
        [UIView animateWithDuration:1 animations:^{
            
            self.collectionView.alpha =0;
            
        } completion:^(BOOL finished) {
            
            //切换控制器
            EDKMainViewController *mainVC = [[EDKMainViewController alloc]init];
            
            EDKNavController * navVc =[[EDKNavController alloc] initWithRootViewController:mainVC];
            
            EDKPersonalMessageController * personVc =[[EDKPersonalMessageController alloc] init];
            
            
            MMDrawerController * mmVc = [[MMDrawerController alloc] initWithCenterViewController:navVc leftDrawerViewController:personVc];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[EDKNavController alloc]initWithRootViewController:mmVc];
            
        }];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    CGFloat offsetX = scrollView.contentOffset.x;
    //EDKLog(@"%lf",offsetX);
    
    // 1.1 计算索引
    CGFloat index = offsetX / scrollView.width;
    
    //当选中的图片 是最后一张的时候
//    if (offsetX > 2 * KWidth) {
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            self.collectionView.alpha =0.5;
//        } completion:^(BOOL finished) {
//           
//            [UIView animateWithDuration:0.5 animations:^{
//                self.collectionView.alpha =0;
//            } completion:^(BOOL finished) {
//                
//            }];
//            
//        }];
//    }
    
    // 1.2 判断方向
    CGFloat startX = 0;
    
    if (self.LunBOPointView.x > offsetX) {
        
        //向右移动
        startX = offsetX;
        
    } else {
        
        //向左移动

        startX = offsetX;
    }
    
    //NSLog(@"%@", @(index));
    
    //NSLog(@"--%f", startX);
    //NSLog(@"---%f", self.LunBOPointView.x);
    self.LunBOPointView.x = startX + ( self.collectionView.width - self.LunBOPointView.width ) * 0.5;
    
    // 拼接图片名称
    NSString *LunBoPointImgName = [NSString stringWithFormat:@"轮播点%@", @(index + 1)];
    

    
    // 2.需要切换图片
    self.LunBOPointView.image = [UIImage imageNamed:LunBoPointImgName];

    
    
    // 2.2 多走一个屏幕的宽度
//    self.LunBOPointView.x = startX + KWidth;
    
    
    
//    self.LunBOPointView.y = self.collectionView.height - 78;
    
    [self.collectionView reloadData];
    
}



#pragma mark - 懒加载
- (NSArray *)bgImgsArr {
    if (!_bgImgsArr) {
        
        _bgImgsArr = @[
                       [UIImage imageNamed:@"引导页1"],
                       [UIImage imageNamed:@"引导页2"],
                       [UIImage imageNamed:@"引导页3"]
                       
                       ];
        
    }
    return _bgImgsArr;
}





@end
