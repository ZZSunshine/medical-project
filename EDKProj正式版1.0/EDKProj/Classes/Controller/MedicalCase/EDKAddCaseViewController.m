//
//  ZSAddCaseViewController.m
//  EDKProj
//
//  Created by 张帅 on 16/3/26.
//  Copyright © 2016年 杨文磊Mac. All rights reserved.
//

#import "EDKAddCaseViewController.h"
#import "EDKCustomBtn.h"
#import "EDKCustomTextView.h"
#import "DiseaseSelectTabController.h"
#import "AFNetworking.h"
#import "UIColor+Hex.h"
#import "DiseaseTypeOne.h"
#import "DiseaseInfo.h"

#define KMargin 10
#define KLabelW 70
#define KlabelH 15
#define KFont 16
#define KBtnH 18
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height
@interface EDKAddCaseViewController ()<UIActionSheetDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIView *upView;
//创建nameLabel
@property(nonatomic,strong)UILabel *nameLabel;
//创建显示姓名label
@property (nonatomic,strong)UILabel *showNameLabel;
//疾病类型 label
@property (nonatomic,strong)UILabel *diseaseLabel;
//选择疾病类型 label
@property (nonatomic,strong)UILabel *selDiseaseLabel;
//底部imageView
@property (nonatomic,strong)UIImageView *backGroundImgView;
//重新选择按钮
@property (nonatomic,strong)UIButton *reChooseBtn;
//病症描述label
@property (nonatomic,strong)UILabel *diseaseDescLab;
//描述症状TextView
@property (nonatomic,strong)EDKCustomTextView *desTextView;
//选择症状按钮
@property (nonatomic,strong)UIButton *hurtBtn;
//textField底部背景UIImageView
@property (nonatomic,strong)UIImageView *textBackView;
//中间View  midView
@property (nonatomic,strong)UIView *midView;
//病例图片label
@property (nonatomic,strong)UILabel *addCasePictureLab;
//上传图片按钮
@property (nonatomic,strong)UIButton *uploadCaseBtn;
//uploadCaseView
@property (nonatomic,strong)UIView *uploadCaseView;
//@property (nonatomic,strong)UIImageView *imge;
//添加病例图片image
@property (nonatomic,strong)UIImageView *imgView;

//传过去的数组
@property (nonatomic,strong)NSMutableArray *arr;

@property (nonatomic,copy)NSString *fullPath;

@property(nonatomic,strong) DiseaseTypeOne * diseaseOne;

@end

@implementation EDKAddCaseViewController
//懒加载数组
- (NSMutableArray *)arr{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

//创建nameLabel
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
     _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMargin, KMargin, KLabelW, KlabelH)];
    _nameLabel.text = @"用户姓名:";
    _nameLabel.font = [UIFont systemFontOfSize:KFont];
    _nameLabel.textColor = [UIColor grayColor];
    }
    return _nameLabel;
}
//创建显示姓名label
- (UILabel *)showNameLabel{
    if (_showNameLabel== nil) {
        _showNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+KMargin, KMargin, KLabelW, KlabelH)];
        _showNameLabel.text = @"王大锤";
        _showNameLabel.textColor = [UIColor grayColor];
        _showNameLabel.font = [UIFont systemFontOfSize:KFont];
    }
    return _showNameLabel;
}
//创建疾病类型 label
- (UILabel *)diseaseLabel{
    if (_diseaseLabel== nil) {
        _diseaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMargin,CGRectGetMaxY(self.nameLabel.frame)+3*KMargin, KLabelW, KlabelH)];
        _diseaseLabel.text = @"疾病类型:";
        _diseaseLabel.textColor = [UIColor grayColor];
        _diseaseLabel.font = [UIFont systemFontOfSize:KFont];
    }
    return _diseaseLabel;
}
//底部imageView
- (UIImageView *)backGroundImgView{
    if (_backGroundImgView == nil) {
        _backGroundImgView = [[UIImageView alloc]initWithFrame:CGRectMake( CGRectGetMaxX(self.diseaseLabel.frame)+KMargin, CGRectGetMaxY(self.showNameLabel.frame)+2*KMargin, KWIDTH-4*KMargin-self.diseaseLabel.frame.size.width, 4*KMargin)];
        _backGroundImgView.image = [UIImage imageNamed:@"chat_bottom_textfield"];
    }
    return _backGroundImgView;
}
//选择疾病类型 label
- (UILabel *)selDiseaseLabel{
    if (_selDiseaseLabel == nil) {
        _selDiseaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.diseaseLabel.frame)+KMargin, CGRectGetMaxY(self.showNameLabel.frame)+2*KMargin, KWIDTH-10*KMargin-self.diseaseLabel.frame.size.width, 4*KMargin)];
    }
    return _selDiseaseLabel;
}
//重新选择按钮
- (UIButton *)reChooseBtn{
    if (_reChooseBtn == nil) {
        _reChooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selDiseaseLabel.frame), CGRectGetMaxY(self.showNameLabel.frame)+2*KMargin, 6*KMargin, 4*KMargin)];
        [_reChooseBtn setTitle:@"重新选择" forState:UIControlStateNormal];
        [_reChooseBtn setTitleColor:[UIColor colorWithHexString:@"66dbc1"] forState:UIControlStateNormal];
        [_reChooseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _reChooseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       
    }
    return _reChooseBtn;
}
//症状描述label
- (UILabel *)diseaseDescLab{
    if (_diseaseDescLab == nil) {
        _diseaseDescLab = [[UILabel alloc]initWithFrame:CGRectMake(KMargin,KMargin+3, KLabelW, KlabelH)];
        _diseaseDescLab.text =@"病症描述:";
        _diseaseDescLab.textColor = [UIColor grayColor];
        _diseaseDescLab.font = [UIFont systemFontOfSize:16];
     
    }
    return _diseaseDescLab;
}
//描述疾病TextView
- (EDKCustomTextView *)desTextView {
    if (_desTextView == nil) {
        _desTextView = [[EDKCustomTextView alloc]initWithFrame:CGRectMake(KMargin+1, CGRectGetMaxY(self.hurtBtn.frame)+KMargin+1, KWIDTH-2*KMargin-2, (KHEIGHT-64)/3-4*KMargin-3*KBtnH-2)];

        _desTextView.placeholder = @" 请您选择合适的标签并简要描述... ";
        _desTextView.layer.borderWidth =1;
    }
    return _desTextView;
}
//textField底部背景UIImageView

//病例图片label
- (UILabel *)addCasePictureLab {
    if (_addCasePictureLab  == nil) {
        _addCasePictureLab  = [[UILabel alloc]initWithFrame:CGRectMake(KMargin,2*KMargin, KLabelW, KlabelH)];
        _addCasePictureLab.text =@"病例图片:";
        _addCasePictureLab.textColor = [UIColor grayColor];
        _addCasePictureLab.font = [UIFont systemFontOfSize:KFont];
    }
    return _addCasePictureLab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建最上部分
    [self createUpView];
    //创建中间部分
    [self createMidView];
    //创建上传病例View
    [self creatUploadCaseView];
    //创建底部View
    [self createBottomView];
    self.navigationItem.title = @"添加病例";

}
#pragma mark --创建上半部分
- (void)createUpView{
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH,(KHEIGHT-64)*1/6)];
//    upView.backgroundColor = [UIColor blueColor];
    //添加nameLabel
    [upView addSubview:self.nameLabel];
    //添加显示姓名label
    [upView addSubview:self.showNameLabel];
    //添加疾病类型label
    [upView addSubview:self.diseaseLabel];
    //选择疾病类型TxetField
    [upView addSubview:self.selDiseaseLabel];
    //底部imageView
    [upView addSubview:self.backGroundImgView];
    //重新选择按钮
    [upView addSubview:self.reChooseBtn];
    //重新选择按钮添加点击事件
    [self.reChooseBtn addTarget:self action:@selector(clickToChooseDisease:) forControlEvents:UIControlEventTouchUpInside];
    [upView bringSubviewToFront:self.selDiseaseLabel];
    [self.view addSubview:upView];
    self.upView = upView;
   
}

#pragma mark -- 重新选择 跳转回来...
//实现重新选择按钮方法
- (void)clickToChooseDisease:(UIButton *)reChoose{
    
    //这个model 是首页传过来的
    self.diseaseOne =[[DiseaseTypeOne alloc] init];
    //
    self.diseaseOne.ci1_id=@(1);
    //
    self.diseaseOne.ci1_name=@"疾病选择";
    
    DiseaseSelectTabController *searchVc = [[DiseaseSelectTabController alloc]init];
    searchVc.Diseaseone = self.diseaseOne;
    
    __weak typeof(self) wself =self;
    searchVc.returnblock = ^(id model)
    {
        DiseaseInfo * info =model;
        
        NSString * cname =info.ci3_name;
        wself.selDiseaseLabel.text =cname;
        
    };
    
    [self.navigationController pushViewController:searchVc animated:YES];
}
#pragma mark --创建中间的View
- (void)createMidView{
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame), KWIDTH, (KHEIGHT-64)*1/3)];

    //添加病症描述label
    [midView addSubview:self.diseaseDescLab];
    //创建数组保存按钮内容
    NSArray *textArr = @[@"脱水",@"营养不良",@"咽喉疼痛",@"贫血",@"胸部灼热感",@"进行性咽下困难"];
    CGFloat w = self.diseaseDescLab.width+KMargin;
    CGFloat h = KMargin;
    //for 循环创建button
    for (int i=0; i<textArr.count; i++) {
        EDKCustomBtn *diseaseBtn = [EDKCustomBtn buttonWithType:UIButtonTypeCustom];
        //设置Tag
        diseaseBtn.tag = 100 + i;
        [diseaseBtn addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [diseaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGFloat length = [textArr[i] boundingRectWithSize:CGSizeMake(KWIDTH-self.diseaseDescLab.frame.size.width-2*KMargin, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //设置button字体
        [diseaseBtn setTitle:textArr[i] forState:UIControlStateNormal];
        diseaseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [diseaseBtn setTitleColor:[UIColor colorWithHexString:@"#66dbc1"] forState:UIControlStateSelected];
        [diseaseBtn setBackgroundImage:[UIImage imageNamed:@"btntoSelect"] forState:UIControlStateNormal];
        [diseaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
        //设置button的frame
        diseaseBtn.frame = CGRectMake(KMargin + w, h, length + 18, KBtnH);
        if(KMargin + w + length + 18 > KWIDTH){
            w = self.diseaseDescLab.width+KMargin;
            h = h + diseaseBtn.frame.size.height + KMargin;
            diseaseBtn.frame = CGRectMake(KMargin + w, h, length + 18, KBtnH);
        }
        w = diseaseBtn.frame.size.width + diseaseBtn.frame.origin.x;
        self.hurtBtn = diseaseBtn;
        [midView addSubview:diseaseBtn];
    }
    //添加textField背景ImageView
    [midView addSubview:self.textBackView];
//   把症状TextField放在前面
    [midView addSubview:self.desTextView];
    [midView bringSubviewToFront:self.desTextView];
    self.midView = midView;
    [self.view addSubview:midView];
}
//设置按钮的状态
- (void)handleClick:(UIButton *)sender{
    if (!sender.selected) {
        sender.selected = YES;
        [sender setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateSelected];
    }else{
        sender.selected = NO;
    }
}

//创建上传病例View
#pragma mark --创建上传病例View
- (void)creatUploadCaseView{
    UIView *uploadCaseView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.midView.frame), KWIDTH, (KHEIGHT-64)*1/3)];
    //添加病例图片label
    [uploadCaseView addSubview:self.addCasePictureLab];
    //上传图片按钮
     UIButton *uploadCaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addCasePictureLab.frame)+2*KMargin, KMargin, KWIDTH-4*KMargin-KLabelW, 45)];
    [uploadCaseBtn setBackgroundImage:[UIImage imageNamed:@"uploadCasePicture"] forState:UIControlStateNormal];
    [uploadCaseBtn setImage:[UIImage imageNamed:@"uploadCasePicture"] forState:UIControlStateNormal];
    
    uploadCaseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [uploadCaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    self.uploadCaseBtn = uploadCaseBtn;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KWIDTH*1/4, CGRectGetMaxY(self.uploadCaseBtn.frame)+2*KMargin, KWIDTH/2, 100)];
    
    imgView.image =[UIImage imageNamed:@"noPicture"];
    
    self.imgView = imgView;
    
    [uploadCaseView addSubview:imgView];
    
    [uploadCaseView addSubview:uploadCaseBtn];

    //点击按钮上传照片
    [uploadCaseBtn addTarget:self action:@selector(clickToUploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    
    //赋值
    self.uploadCaseView = uploadCaseView;
    [self.view addSubview:uploadCaseView];
}

#pragma mark --创建底部视图
- (void)createBottomView{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.uploadCaseView.frame), KWIDTH, (KHEIGHT-64)*1/6-2*KMargin)];
    UIButton *ensureBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMargin, KMargin, KWIDTH-2*KMargin, bottomView.frame.size.height-3*KMargin)];
     [ensureBtn setBackgroundImage:[UIImage imageNamed:@"ensureNormal"] forState:UIControlStateNormal];
    //给确认按钮添加点击事件
    [ensureBtn addTarget:self action:@selector(clickToAddCase:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:ensureBtn];
    [self.view addSubview:bottomView];
}
//点击确认按钮提交病例图片到病例管理

- (void)clickToAddCase:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd hh-mm";
    NSString *dateStr = [formatter stringFromDate:date];
    if (self.fullPath.length == 0) {
        
        
    }else{
        NSDictionary *dict = @{@"img":self.fullPath,@"date":dateStr};
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray * arrOrigial = [NSMutableArray array];
        arrOrigial=[defaults objectForKey:@"arrKey"];
        
        NSMutableArray * tempArr=[NSMutableArray array];
        if (!arrOrigial) {
            
            arrOrigial = [NSMutableArray array];
            [arrOrigial addObject:dict];
            [defaults setObject:arrOrigial forKey:@"arrKey"];
            
        }
        else
        {
            [arrOrigial enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempArr addObject:obj];
            }];
            [tempArr addObject:dict];
            
            [defaults setObject:tempArr forKey:@"arrKey"];
        }
        
        [defaults synchronize];
        
        //发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clickToAddCase" object:arrOrigial userInfo:nil];
        
    }
}


//点击按钮上传照片
- (void)clickToUploadPicture:(EDKCustomBtn *)sender{

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
    
    self.imgView.image = image;
    
    //01.21 应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    
    // 保存图片至本地，方法见下文
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSString *imageName = [NSString stringWithFormat:@"currentImage%@.png",dateStr];
    
    [self saveImage:image withName:imageName];
}

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    self.fullPath = fullPath;
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

@end






