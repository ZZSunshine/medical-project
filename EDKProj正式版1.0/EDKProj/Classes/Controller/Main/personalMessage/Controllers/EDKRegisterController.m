//
//  registerController.m
//  EDKProj
//
// Created by 晓飞 on 16/3/28.

#import "EDKRegisterController.h"
#import "EDKRegisterCells.h"

@interface EDKRegisterController ()

@end

@implementation EDKRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预约挂号列表";
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;
}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EDKRegisterCells *cell = [EDKRegisterCells cellWithTableView:tableView];
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85 ;

}

@end







