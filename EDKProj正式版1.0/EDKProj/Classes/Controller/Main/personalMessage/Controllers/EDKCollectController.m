//
//  EDKCollectController.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/29.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKCollectController.h"
#import "EDKCollectCell01.h"
#import "EDKCollectCell02.h"

@interface EDKCollectController ()

@property(nonatomic,strong)UISegmentedControl *SCControl ;


@end

@implementation EDKCollectController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *arrayItem = [[NSArray alloc]initWithObjects:@"关注的医院",@"关注的医生", nil];
    UISegmentedControl *SCControl = [[UISegmentedControl alloc]initWithItems:arrayItem];
    SCControl.tintColor = [UIColor grayColor];
    SCControl.selectedSegmentIndex = 0;

    self.navigationItem.titleView = SCControl ;
    
    self.SCControl = SCControl ;
    
    
    [SCControl addTarget:self action:@selector(selectUISegmented:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;


}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectUISegmented:(UISegmentedControl *)sender
{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.SCControl.selectedSegmentIndex) {
        EDKCollectCell02 *cell = [EDKCollectCell02 cellWithTableView:tableView];
        
        return cell ;
    }else{
        EDKCollectCell01 *cell = [EDKCollectCell01 cellWithTableView:tableView];
        return cell ;
    }
  }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71 ;
    
}


@end
