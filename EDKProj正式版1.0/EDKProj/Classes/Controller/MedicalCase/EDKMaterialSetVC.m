//
//  EDKMaterialSetVC.m
//  EDKProj
//

#import "EDKMaterialSetVC.h"
#import "EDKMaterialSet.h"
@interface EDKMaterialSetVC ()

@end

@implementation EDKMaterialSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    EDKMaterialSet *setView = [[[NSBundle mainBundle]loadNibNamed:@"EDKMaterialSet" owner:nil options:nil]lastObject];
    setView.frame = self.view.frame;
    [self.view addSubview:setView];
}




@end
