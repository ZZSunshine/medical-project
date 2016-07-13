//
//  SystemMessageCollectionViewController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/29.

#import "SystemMessageCollectionViewController.h"
#import "SystemMessageModel.h"
#import "SystemMessageCell.h"


@interface SystemMessageCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray *messageArr;

@end

@implementation SystemMessageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpTabarUI];

    [self.collectionView registerClass:[SystemMessageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 获取布局
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    // 设置大小
    flowLayout.itemSize = CGSizeMake(350, 80);
    
    flowLayout.minimumLineSpacing = 20;
    
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
    
    // 取消滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
}


// 懒加载名医通数组
-(NSArray *)messageArr {
    
    
    if (!_messageArr) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"SystemMessageCell.plist" ofType:nil];
        
        _messageArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *nmArray = [NSMutableArray array];
        
        for (NSDictionary *dict in _messageArr) {
            
            SystemMessageModel *model = [SystemMessageModel cellWithDict:dict];
            
            [nmArray addObject:model];
        }
        
        _messageArr = nmArray;
        
    }
    
    return _messageArr;
}




#pragma mark 返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

#pragma mark 返回多少行(格子)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.messageArr.count;
}

#pragma mark 返回怎么样cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 创建cell
    
    SystemMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    SystemMessageModel *model = self.messageArr[indexPath.item];
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"系统消息框"]];
    
    cell.Model = model;

    // 返回cell
    return cell;

    
}



#pragma mark - Tabar布局
- (void)setUpTabarUI {
    

    //设置title
    self.title = @"系统通知";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SystemMessageModel *model = self.messageArr[indexPath.row];
    
    EDKLog(@"%@",model.title);
    
}


@end
