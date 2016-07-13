//
//  EDKApplyController.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/28.

#import "EDKApplysController.h"
#import "EDKApplyCell.h"
#import "EDKDetailController.h"

@interface EDKApplysController ()

@end

@implementation EDKApplysController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"名医通申请";
    
    UIBarButtonItem * backItem =[[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    self.navigationItem.leftBarButtonItem =backItem;
    self.navigationItem.hidesBackButton =YES;

}

-(void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EDKApplyCell *cell = [EDKApplyCell cellWithTableView2:tableView];
    
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85 ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKDetail" bundle:nil];
    
    EDKDetailController *vc = [board instantiateInitialViewController];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
