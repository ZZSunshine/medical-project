//
//  CommonFlowLayout.m
//  EDKProj
//
//  Created by 杨文磊Mac on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "CommonFlowLayout.h"

@implementation CommonFlowLayout

+(instancetype)InstanceFlowLayOutWithCollectionName:(NSString *)name andItemSize:(CGSize)size
{
    CommonFlowLayout * layout= [[self alloc] init];
    
    if ([name isEqualToString:@"DoctorOtherInfoCollectionView"]) {
     
        //设置滚动方向
        layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        layout.itemSize =size;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing =0 ;
        layout.minimumLineSpacing =0;
    }
   
    
    
    return  layout;
}

@end
