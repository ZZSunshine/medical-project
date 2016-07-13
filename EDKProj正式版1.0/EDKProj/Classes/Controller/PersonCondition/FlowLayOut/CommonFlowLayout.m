//
//  CommonFlowLayout.m
//  EDKProj
//
//  Created by 晓飞 on 15/1/6.

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
