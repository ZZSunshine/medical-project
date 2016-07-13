//
//  EDKMessageCheckViewController.h
//  EDKProj
//

#import <UIKit/UIKit.h>

@interface EDKMessageCheckViewController : UIViewController

/* 用户名 */
@property (nonatomic, copy)NSString *nameValue;
/* 证件类型 */
@property (nonatomic, copy)NSString *credentialsTypeValue;
/* 证件号码 */
@property (nonatomic, copy)NSString *credentialsNumValue;
/* 手机号码 */
@property (nonatomic, copy)NSString *phoneNumValue;
/* 现居住地 */
@property (nonatomic, copy)NSString *liveAddressValue;
/* 性别 */
@property (nonatomic, copy)NSString *genderValue;


@end
