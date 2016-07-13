//
//  EDKBureausView.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKBureausView.h"
#import "EDKLeftTableView.h"

@implementation EDKBureausView

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //1 设置属性
        self.backgroundColor = [UIColor whiteColor];
        
        //2.2 添加两个tableview
        
        //左边
        EDKLeftTableView * leftTableView = [[EDKLeftTableView alloc]initWithFrame:CGRectMake(0, 0, self.width * 0.3, self.height) style:UITableViewStylePlain];
        
        self.leftTableView = leftTableView;
        [self addSubview:leftTableView];
        
        NSLog(@"%lf",leftTableView.frame.origin.y);
        
        //右边
        EDKRightTableView *rightTableView = [[EDKRightTableView alloc]initWithFrame:CGRectMake(leftTableView.width, 0, self.width - leftTableView.width, self.height) style:UITableViewStylePlain];
        
        self.rightTableView = rightTableView;
        
        [self addSubview:rightTableView];
        
        //执行block
        leftTableView.selectedBur = ^(NSDictionary *dict) {
            
            if (rightTableView.selecteddespe) {
                
                rightTableView.selecteddespe(dict);
            }
        };
        
        // 3 添加一条分割线
        UIView *centerLine = [[UIView alloc]initWithFrame:CGRectMake(self.width * 0.3, 0, 0.5, self.height)];
        
        centerLine.backgroundColor = [UIColor grayColor];
        
        [self addSubview:centerLine];
        
    }
    return self;
}
@end
