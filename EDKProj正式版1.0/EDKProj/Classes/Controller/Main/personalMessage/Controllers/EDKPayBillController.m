//
//  EDKPayBillController.m
//  EDKProj
//
//  Created by XUYIBIN on 16/3/28.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKPayBillController.h"
#import "EDKPayBillCells.h"

@interface EDKPayBillController ()




@end

@implementation EDKPayBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付明细";
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;
    
}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    static NSString *reuseId = @"reuseId";
    
    EDKPayBillCells *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell){
        
        cell = [[EDKPayBillCells alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73 ;
    
}

@end
