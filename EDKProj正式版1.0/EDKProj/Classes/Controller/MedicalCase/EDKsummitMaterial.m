//
//  EDKsummitMaterial.m
//  EDKProj
//
//  Created by 张帅 on 16/3/27.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKsummitMaterial.h"
#import "EDKCustomBtn.h"
#import "EDKMedicalCaseViewController.h"
#import "EDKAlreadySubmitCheck.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height
#define KMargin 10
#define BKmargin 26
#define KBtnH 20
@interface EDKsummitMaterial ()<UIActionSheetDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *personalHistoryView;
@property (weak, nonatomic) IBOutlet UILabel *personalHistoryLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *desDiseaseView;

@property (weak, nonatomic) IBOutlet UILabel *desDisLab;
@property (nonatomic,strong) NSMutableArray *mutableArr;

@end

@implementation EDKsummitMaterial
//懒加载控件

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(clickToJumpToAlreadySubmit)];
    self.navigationItem.title = @"递交资料";
    //创建不良习惯按钮
    [self createBadCustomBtn];
    //创建添加图片的scrollView
    [self createScrollView];
    //创建症状描述按钮的view
    [self createDesDiseaseView];
}
//跳转到已提交审核界面
- (void)clickToJumpToAlreadySubmit{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"EDKAlreadySubmitCheck" bundle:nil];
    EDKsummitMaterial *AlreadysubmitCheckVC = [board instantiateInitialViewController];
    [self.navigationController pushViewController:AlreadysubmitCheckVC  animated:YES];
}

- (void)createBadCustomBtn{
    NSArray * badCustomBtnArr = @[@"无不良嗜好",@"喝酒",@"抽烟",@"烫头",@"毒品接触",@"添加其他按钮"];
    CGFloat w = self.personalHistoryLab.width+self.personalHistoryLab.frame.origin.x+BKmargin;
    CGFloat h = 5;
    //for 循环创建button
    for (int i=0; i<badCustomBtnArr.count; i++) {
        EDKCustomBtn *badCustomBtn = [EDKCustomBtn buttonWithType:UIButtonTypeCustom];
        //设置Tag
        badCustomBtn.tag = 100 + i;
        //      badCustomBtn.backgroundColor = [UIColor purpleColor];
        [badCustomBtn addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [badCustomBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat length = [badCustomBtnArr[i] boundingRectWithSize:CGSizeMake(KWIDTH-self.personalHistoryLab.frame.size.width-self.personalHistoryLab.frame.origin.x-BKmargin, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //设置button字体
        [badCustomBtn setTitle:badCustomBtnArr[i] forState:UIControlStateNormal];
        badCustomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [badCustomBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [badCustomBtn setBackgroundImage:[UIImage imageNamed:@"u22"] forState:UIControlStateNormal];
        [badCustomBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
        //设置button的frame
        badCustomBtn.frame = CGRectMake(6 + w, h, length + 18, KBtnH);
        if(6 + w + length + 18 > KWIDTH){
            w = self.personalHistoryLab.width+self.personalHistoryLab.frame.origin.x+BKmargin;
            h = h + badCustomBtn.frame.size.height + 6;
            badCustomBtn.frame = CGRectMake(6 + w, h, length + 18, KBtnH);
        }
        w = badCustomBtn.frame.size.width + badCustomBtn.frame.origin.x;
        
        [self.personalHistoryView addSubview:badCustomBtn];
    }

}
- (IBAction)clickToJumpToMedicalCase:(UIButton *)sender {
//    EDKMedicalCaseViewController *EDKmedicalCaseVC = [[EDKMedicalCaseViewController alloc]init];
    
    [self.navigationController popViewControllerAnimated:YES];
}



//创建添加图片的ScrollView
- (void)createScrollView{
    self.scrollView.contentSize = CGSizeMake(3*KWIDTH, self.scrollView.frame.size.height);
    //在scrollView里添加ImageView
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (int i = 0; i<9; i++) {
        UIButton *pictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*((KWIDTH-5*KMargin)/3+KMargin),KMargin,(KWIDTH-5*KMargin)/3,80)];
        pictureBtn.backgroundColor = [UIColor grayColor];
        [pictureBtn setBackgroundImage:[UIImage imageNamed:@"noPicture"] forState:UIControlStateNormal];
        pictureBtn.tag = i;
        [self.scrollView addSubview:pictureBtn];
        [mutableArr addObject:pictureBtn];
    }
    self.mutableArr = mutableArr;
}

//点击按钮上传照片
- (IBAction)clickToUploadPicture:(UIButton *)sender {

    //选取照片上传
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

// 图片选择结束之后，走这个方法，字典存放所有图片信息
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.mutableArr enumerateObjectsUsingBlock:^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!obj.selected) {
            [obj setBackgroundImage:image forState:UIControlStateSelected];
            obj.selected = YES;
            *stop = YES;
        }
        
    }];
   
    }


//创建症状描述按钮的view
- (void)createDesDiseaseView{
    NSArray *textArr = @[@"脱水",@"营养不良",@"咽喉疼痛",@"贫血",@"胸部灼热感",@"进行性咽下困难"];
    CGFloat w = self.desDisLab.width+KMargin;
    CGFloat h = KMargin;
    //for 循环创建button
    for (int i=0; i<textArr.count; i++) {
        EDKCustomBtn *diseaseBtn = [EDKCustomBtn buttonWithType:UIButtonTypeCustom];
        //设置Tag
        diseaseBtn.tag = 100 + i;
        //      diseaseBtn.backgroundColor = [UIColor purpleColor];
        [diseaseBtn addTarget:self action:@selector(chickDiseaseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [diseaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [textArr[i] boundingRectWithSize:CGSizeMake(KWIDTH-self.desDisLab.frame.size.width-2*KMargin, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //设置button字体
        [diseaseBtn setTitle:textArr[i] forState:UIControlStateNormal];
        diseaseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [diseaseBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [diseaseBtn setBackgroundImage:[UIImage imageNamed:@"u22"] forState:UIControlStateNormal];
        [diseaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
        //设置button的frame
        diseaseBtn.frame = CGRectMake(KMargin + w, h, length + 18, KBtnH);
        if(KMargin + w + length + 18 > KWIDTH){
            w = self.desDisLab.width+KMargin;
            h = h + diseaseBtn.frame.size.height + KMargin;
            diseaseBtn.frame = CGRectMake(KMargin + w, h, length + 18, KBtnH);
        }
        w = diseaseBtn.frame.size.width + diseaseBtn.frame.origin.x;
     
        [self.desDiseaseView addSubview:diseaseBtn];
}
}
//实现按钮点击方法
- (void)handleClick:(EDKCustomBtn *)sender{
    if (!sender.selected) {
        sender.selected = YES;
        [sender setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateSelected];
    }else{
        sender.selected = NO;
    }

}
//实现点击病症描述按钮实现方法
- (void)chickDiseaseBtn:(EDKCustomBtn *)sender{
    if (!sender.selected) {
        sender.selected = YES;
        [sender setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateSelected];
    }else{
        sender.selected = NO;
    }

}

@end
