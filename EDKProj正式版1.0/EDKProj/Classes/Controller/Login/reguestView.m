//
//  reguestView.m
//  EDKProj
//

#import "reguestView.h"

@implementation reguestView

-(instancetype)init {
    
    self = [super init];
    
    
    return [[[NSBundle mainBundle]loadNibNamed:@"RegistView" owner:nil options:nil]lastObject];
}

@end
