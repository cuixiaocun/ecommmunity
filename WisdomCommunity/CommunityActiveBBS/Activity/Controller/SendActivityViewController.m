//
//  SendActivityViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SendActivityViewController.h"
#import "YBImgPickerViewController.h"
#import "ShowBigPicController.h"

@interface SendActivityViewController ()<YBImgPickerViewControllerDelegate>
{
    UIScrollView *bgScrollView;
    int timeCount;//上传图片请求
    UIView *bottomView;
    
}
@property (nonatomic, copy)NSString *nameEvent;//活动名称
@property (nonatomic, copy)NSString *dateTimer;//存储活动时间
@property (nonatomic, copy)NSString *address;//存储活动地址
@property (nonatomic, copy)NSString *activityCenter;//存储活动内容
@property (nonatomic, copy)NSString *imageAddress;//图片地址
@property (nonatomic, copy)NSString *comNo;
@property (nonatomic, strong)UIButton *launchedButton;
@property (nonatomic, strong)UIButton *endButton;
@property (nonatomic, strong)UIButton *beginButton;
@property (nonatomic, assign)BOOL isFirst;
@end

@implementation SendActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tupian:) name:@"tupian" object:nil];
    _uploadImageVArray =[[NSMutableArray alloc]init];
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH-44)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    //bgScrollView.backgroundColor =[UIColor redColor];
    bgScrollView.scrollEnabled = YES;
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];

    _picArr =[[NSMutableArray alloc]init];
    _picUrlArr =[[NSMutableArray alloc]init];
    _picIdArr =[[NSMutableArray alloc]init];

   
    
    [self setSendAStyle];
    [self initSendAController];
//    [self initPictureControllers];
    [self initPictureView];
    
}
//设置样式
- (void) setSendAStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布活动";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//初始化控件
- (void) initSendAController
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:11];
    //标题
    self.activityTitleTextField = [[UITextField alloc] init];
    self.activityTitleTextField.placeholder = @"标题#活动名称#";
    self.activityTitleTextField.delegate = self;
    self.activityTitleTextField.returnKeyType = UIReturnKeyDone;
    self.activityTitleTextField.textColor = [UIColor colorWithRed:0.376 green:0.376 blue:0.376 alpha:1.00];
    self.activityTitleTextField.backgroundColor = [UIColor clearColor];
    self.activityTitleTextField.textAlignment = NSTextAlignmentLeft;
    [bgScrollView addSubview:self.activityTitleTextField];
    _activityTitleTextField.frame =CGRectMake((CXCWidth * 30), 0,CYScreanW-60*CXCWidth ,99*CXCWidth);
    
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [bgScrollView addSubview:segmentationImmage];
    segmentationImmage.frame =CGRectMake(30*CXCWidth,_activityTitleTextField.bottom,CYScreanW ,1*CXCWidth);
    
    
    //活动内容
    self.activityTextView = [[UITextView alloc] init];
    self.activityTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.activityTextView.text=NSLocalizedString(@"描述一下活动内容", nil);//提示语
    self.activityTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.activityTextView.delegate = self;
    self.activityTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.activityTextView.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:self.activityTextView];
    _activityTextView.frame =CGRectMake(30*CXCWidth, (segmentationImmage.bottom)+CXCWidth*30, 690*CXCWidth, 200*CXCWidth);
    //中间信息
    UIView *zhongView = [[UIView alloc]initWithFrame:CGRectMake(0,_activityTextView.bottom+10*CXCWidth,CYScreanW, 250*CXCWidth)];
    [bgScrollView addSubview:zhongView];
//    zhongView.backgroundColor =[UIColor grayColor];
    zhongView.userInteractionEnabled =YES;
    zhongView.tag = 101;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth, 30*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
    [btn setImage:[UIImage imageNamed:@"icon_insert_pic"] forState:UIControlStateNormal];
    btn.userInteractionEnabled =YES;
    [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
    btn.tag =200;
    [zhongView addSubview:btn];
    
//    UIButton *xBtn = [[UIButton alloc]initWithFrame:CGRectMake(-40*CXCWidth, -40*CXCWidth, 80*CXCWidth, 80*CXCWidth)];
//    [xBtn setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
//    [xBtn setImageEdgeInsets:UIEdgeInsetsMake(20*CXCWidth, 20*CXCWidth, 20*CXCWidth, 20*CXCWidth)];
//    xBtn.userInteractionEnabled =YES;
//    [xBtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
//    xBtn.tag =22200;
//    [btn addSubview:xBtn];
    

    
    
    
    
    //地址及以下
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,zhongView.bottom,CYScreanW, 520*CXCWidth)];
//    bottomView.backgcroundColor =[UIColor redColor];
    [bgScrollView addSubview:bottomView];
    
    UIImageView *addImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*CXCWidth, 30*CXCWidth, 32*CXCWidth, 42*CXCWidth)];
    [addImgV setImage:[UIImage imageNamed:@"icon_publish_location_before"]];
    [bottomView addSubview:addImgV];
    
    self.addressTextField = [[UITextField alloc] init];
    self.addressTextField.placeholder = @"活动地点";
    self.addressTextField.delegate = self;
    self.addressTextField.font = [UIFont systemFontOfSize:14];
    self.addressTextField.returnKeyType = UIReturnKeyDone;
    self.addressTextField.textColor = TextGroColor;
    self.addressTextField.backgroundColor = [UIColor clearColor];
    _addressTextField.frame =CGRectMake(addImgV.right+20*CXCWidth,10*CXCWidth , 550*CXCWidth, 90*CXCWidth);
    
    self.addressTextField.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:self.addressTextField];
    //横线
    UIImageView *segmentationTImmage = [[UIImageView alloc] init];
    segmentationTImmage.backgroundColor = BGColor;
    [bottomView addSubview:segmentationTImmage];
    segmentationTImmage.frame =CGRectMake(0,_addressTextField.bottom, CYScreanW,20*CXCWidth );
    [bottomView addSubview:segmentationTImmage];
    
    //时间
    for (int i=0; i<2; i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, segmentationTImmage.bottom+100*CXCWidth*i, CYScreanW, 100*CXCWidth)];
        [bottomView addSubview:btn];
        btn.tag =800+i;
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = TextGroColor;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:14];
        timeLabel.frame =CGRectMake(30*CXCWidth, 0,200*CXCWidth ,99*CXCWidth );
        [btn addSubview:timeLabel];
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *DateTime = [formatter stringFromDate:date];
        UILabel *dateLabel =[[UILabel alloc]init];
        dateLabel.textColor = TextGroColor;
        dateLabel.font = [UIFont fontWithName:@"Arial" size:14];
        dateLabel.text =[NSString stringWithFormat:@"%@",DateTime];
        dateLabel.frame =CGRectMake(400*CXCWidth, 0,280*CXCWidth ,99*CXCWidth );
        dateLabel.textAlignment =NSTextAlignmentRight;
        [btn addSubview:dateLabel];
        dateLabel.tag =900+i;

        
        UIImageView *imagV3 = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 99*CXCWidth,710*CXCWidth,1*CXCWidth)];
        [imagV3 setBackgroundColor:BGColor];
        [btn addSubview:imagV3];

        UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(690*CXCWidth, 25*CXCWidth,30*CXCWidth , 50*CXCWidth)];
        [btn addSubview:jiantou];
        [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];
        
        
        if (i==0) {
            [btn addTarget:self action:@selector(endButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            timeLabel.text =@"开始时间";
            UIImageView *segmentationTImmage = [[UIImageView alloc] init];
            segmentationTImmage.backgroundColor = BGColor;
            [bottomView addSubview:segmentationTImmage];
            segmentationTImmage.frame =CGRectMake(0,dateLabel.bottom, CYScreanW,1*CXCWidth );
            [bottomView addSubview:segmentationTImmage];

        }else
        {
            [btn addTarget:self action:@selector(endButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            timeLabel.text =@"结束时间";

            
        }

        
    }
    
    
    
    UIButton *sendButton = [[UIButton alloc] init];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    sendButton.layer.cornerRadius = 3;
    
    [sendButton addTarget:self action:@selector(launchedDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendButton];
    sendButton.frame =CGRectMake(30*CXCWidth,segmentationTImmage.bottom+200*CXCWidth+106*CXCWidth,690*CXCWidth,100*CXCWidth);
    
    
    [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
    
}
-(void)shanchu:(UIButton *)btn
{
    [_picIdArr removeObjectAtIndex:btn.tag-44400];
    [self xianshi];


}
//- (void)rili
//{
//  
//    //日历
//    self.dataSendView = [[CYDataView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.1, CYScreanW * 0.9, (CYScreanH - 64) * 0.65)];
//    self.dataSendView.layer.borderColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.812 alpha:1.00].CGColor;
//    self.dataSendView.layer.borderWidth = 1;
//    self.dataSendView.backgroundColor = [UIColor colorWithRed:0.294 green:0.533 blue:0.871 alpha:1.00];
//    __weak typeof(self)weakSelf = self;
//    self.dataSendView.dateBlock = ^(NSString *date){
//        if (weakSelf.isFirst == YES) {
//            NSDate *dateda = [NSDate date]; // 获得时间对象
//            NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
//            [forMatter setDateFormat:@"yyyy-MM-dd"];
//            
//            NSString *nowdata = [forMatter stringFromDate:dateda];
//            NSLog(@"dateStr = %@,date = %@",weakSelf.begindata,date);
//            if ([[CYSmallTools compareOneDay:nowdata withAnotherDay:date] isEqualToString:@"1"]) {
//                [MBProgressHUD showError:@"开始日期不能小于今天" ToView:weakSelf.view];
//            }else{
//                weakSelf.begindata = date;
//                weakSelf.dateTimer = date;
//                [weakSelf.beginButton setTitle:date forState:UIControlStateNormal];
//                weakSelf.endButton.userInteractionEnabled = YES;
//            }
//        }else{
//            if ([[CYSmallTools compareOneDay:weakSelf.begindata withAnotherDay:date] isEqualToString:@"1"]) {
//                [MBProgressHUD showError:@"结束日期不能小于开始日期" ToView:weakSelf.view];
//            }else{
//                weakSelf.dateTimer = [NSString stringWithFormat:@"%@~%@",weakSelf.dateTimer,date];
//                [weakSelf.endButton setTitle:date forState:UIControlStateNormal];
//            }
//        }
//    };
//    
//    
//    
//    
//}
- (void)initPictureView
{
   

}
- (void)endButtonDidClicked:(UIButton *)btn{
    
    [_pickview remove];
    
    NSDate *date=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:1];
    //        isBegin =NO;
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickview.delegate=self;
    _pickview .tag = btn.tag-100;
    [_pickview show];
    
    //隐藏键盘
    [self.activityTitleTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.activityTextView resignFirstResponder];
    //切换状态
  }

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (pickView.tag ==700) {
        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        
        NSInteger time1 = timr;
        
        
        
        
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformat=[[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        
        if(time1+60<time2){
            
            
            [ProgressHUD showError:@"时间已过期,请重新选择"];
            return;
            
        }else
        {
            UILabel *label = [self.view viewWithTag:900];
            
            [label setText:[dateFormatter stringFromDate:cellDate] ];
        }
        
        
    }else
    {
        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        
        NSInteger time1 = timr;
        
        
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];

        if(time1+60<time2){
            
            
            [ProgressHUD showError:@"时间已过期,请重新选择"];
            return;
            
        }else
        {
            UILabel *label = [self.view viewWithTag:901];
            
            [label setText:[dateFormatter stringFromDate:cellDate] ];
        }
        
        
    }
    
}


-(void) postShadowTap:(UITapGestureRecognizer *)sender
{
}
// - - -- - -- -  -- - - - - -- - - -textField或者textView代理 - -- - - - -- - - -- - - -- - - -- - - -- -
//点击return 按钮 去掉

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.activityTitleTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.activityTextView resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"描述一下活动内容", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"描述一下活动内容", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if ([textView.text isEqualToString:@""])
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text=NSLocalizedString(@"描述一下活动内容", nil);
        }

        return NO;
    }

    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"描述一下活动内容", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
//响应函数
-(void)tapSOpertationSet
{
    if (IOS7)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //判断是否支持相机，模拟器没有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                            {
                                                //相机
                                                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                                                imagePickerController.delegate = self;
                                                imagePickerController.allowsEditing = YES;
                                                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                [self presentViewController:imagePickerController animated:YES completion:^{}];
                                            }];
            [alertController addAction:defaultAction];
        }
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:^{
                imagePickerController.delegate = self;
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           
                                       }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:defaultAction1];
        //弹出试图，使用UIViewController的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIActionSheet *sheet;
        //判断是否支持相机，模拟器没有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        }
        else
        {
            sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        [sheet showInView:self.view];
    }
    
}
//保存图片
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击发布按钮
- (void)launchedDidClicked:(UIButton *)sender
{
        [self LaunchedCampaignRequest];
    
}


#pragma mark 发起活动网络请求(先上传图片)
- (void)LaunchedCampaignRequest
{
    timeCount=1;
    
    
    for(NSInteger i = 0; i < self.picUrlArr.count; i++)
    {
        NSData * imageData = [self.picUrlArr objectAtIndex: i];
        [_uploadImageVArray addObject:@""];
        
        [self uploadImage:imageData withInt:i];
        
    }
    if(_picIdArr.count==0)
    {
        [self postTheAction ];
    
    }
    
    
    
    
    
 }


#pragma mark 图片上传请求
//上传图片
- (void) uploadImage:(NSData *)imageDate withInt:(NSInteger)index
{
    
    
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",POSTREQUESTURL];
    NSLog(@"postUrl = %@",postUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
        NSData *eachImgData = UIImageJPEGRepresentation(_picIdArr[index], 0.1);
        
        
//        使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
//
        [formData appendPartWithFileData :eachImgData name : @"file" fileName : fileName mimeType : @"image/jpg/png/jpeg" ];
//        使用日期生成图片名称
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
//        //二进制文件，接口key值，文件路径，图片格式
//        [formData appendPartWithFileData:imageDate name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"请求成功:%@", responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"图片请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
//            [_uploadImageVArray insertObject:[[JSON objectForKey:@"param"] objectForKey:@"url"] atIndex:index];
            [_uploadImageVArray replaceObjectAtIndex:index withObject:[[JSON objectForKey:@"param"] objectForKey:@"url"]];
            
            NSLog(@"%@",self.uploadImageVArray);
            
            if (timeCount==_picIdArr.count) {
                
                
                [self postTheAction];
                
                
            }
            timeCount++;

        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}

- (void)postTheAction
{
    self.nameEvent = self.activityTitleTextField.text;
    self.address = self.addressTextField.text;
    self.activityCenter = self.activityTextView.text;
    UILabel *begain =[self.view viewWithTag:900];
    UILabel *end =[self.view viewWithTag:901];

    
    if ([begain.text isEqualToString:@""]||[end.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"活动日期不能为空" ToView:self.view];
        return;
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormatter dateFromString:begain.text];
    NSDate *date2 = [dateFormatter dateFromString:end.text];
    if ([[NSString stringWithFormat:@"%d",[self compareOneDay:date1 withAnotherDay:date2]] isEqualToString:@"1"]) {

        [MBProgressHUD showError:@"起始时间不得晚于结束时间" ToView:self.view];
        return;
    
    }else if ([[NSString stringWithFormat:@"%d",[self compareOneDay:date1 withAnotherDay:date2]] isEqualToString:@"-1"]){
        NSLog(@"date1 < date2");
    }else{
        NSLog(@"date1 = date2");
    }
    
    
    if ([self.nameEvent isEqualToString:@""] || self.nameEvent == nil ) {
        [MBProgressHUD showError:@"活动名称不能为空" ToView:self.view];
        return;
    }
    if ([self.address isEqualToString:@""] || self.address == nil) {
        [MBProgressHUD showError:@"活动地址不能为空" ToView:self.view];
        return;
    }
    if ([self.activityCenter isEqualToString:@""] || self.activityCenter == nil) {
        [MBProgressHUD showError:@"活动内容不能为空" ToView:self.view];
        return;
    }
    for (NSString *str in self.uploadImageVArray) {
        NSInteger index = [self.uploadImageVArray indexOfObject:str];
        if (![str isEqualToString:@""]) {
            if (index == 0) {
                self.imageAddress = [NSString stringWithFormat:@"%@",str];
            }else{
                self.imageAddress = [NSString stringWithFormat:@"%@,%@",self.imageAddress,str];
            }
        }
    }
    
    _dateTimer =[NSString stringWithFormat:@"%@~%@",begain.text,end.text];
    
    //个人数据
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:self.nameEvent forKey:@"title"];
    [parames setObject:_dateTimer forKey:@"acTime"];
    [parames setObject:_address forKey:@"address"];
    [parames setObject:@"1" forKey:@"flag"];
    [parames setObject:_activityCenter forKey:@"content"];
    if (![self.imageAddress isEqualToString:@""] && self.imageAddress != nil) {
        [parames setObject:_imageAddress forKey:@"imgAddress"];
    }
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/addActivity",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [MBProgressHUD showLoadToView:self.view];
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"请求成功");
             [MBProgressHUD showError:@"发布成功" ToView:self.navigationController.view];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)xuanzhong
{
    //    UIActionSheet *photoSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    //    [photoSheet showInView:self.view];
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    
    //    [next showInViewContrller:self choosenNum:0 delegate:self];
    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr];
    
    
    
}
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //oneDay > anotherDay
        return 1;
    }
    else if (result == NSOrderedAscending){
        //oneDay < anotherDay
        return -1;
    }
    //oneDay = anotherDay
    return 0;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];//进入照相界面
            
        }
            break;
        case 1:
        {
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            [self presentViewController:pickerImage animated:YES completion:nil];//进入照相界面
        }
            break;
            
        default:
            break;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 把头像图片存到本地
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];   // 保存文件的名称
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:filePath atomically:YES];
    
    CGSize originalSize = image.size;
    
    CGFloat maxSize = 250;
    
    CGFloat width =originalSize.width;
    CGFloat height=originalSize.height ;
    
    
    if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
        width = maxSize;
        height = width*originalSize.height /originalSize.width;
    }
    
    if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
        height = maxSize;
        width= height*originalSize.width /originalSize.height;
    }
    
    
    CGSize newSize = CGSizeMake(width, height);
    
    UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
    
    [_picIdArr addObject:sacelImg];
    [_picUrlArr addObject:imageData];
    
    
   
    
//    UIButton *btnq= (UIButton*)[self.view viewWithTag:200];
//    [btnq setImage:_picIdArr[0] forState:UIControlStateNormal];
    
    
    

}
-(void)xianshi
{
    UIView *zhong= (UIView*)[self.view viewWithTag:101];
    for (UIView *buton in  [zhong subviews]) {
        
        if ([buton isKindOfClass:[UIButton class]]) {
            [buton removeFromSuperview];
        }
        
    }
    
    NSLog(@"%lu",(unsigned long)_picIdArr.count);
    for (int i=0; i<_picIdArr.count+1; i++) {
        if (i<3) {
            
            zhong.frame =CGRectMake(0,_activityTextView.bottom+CXCWidth*10,CYScreanW, 250*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 520*CXCWidth);
            [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
            
            
        }else
        {
            zhong.frame =CGRectMake(0,_activityTextView.bottom+CXCWidth*10,CYScreanW, 470*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 520*CXCWidth);
            [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
            
            
        }
        if (i<_picIdArr.count) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth+i%3*CXCWidth*235, i<3? 30*CXCWidth:250*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
            [btn setImage:_picIdArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(datu:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag =400+i;
            [ zhong  addSubview:btn];
            
            
            UIButton *xBtn = [[UIButton alloc]initWithFrame:CGRectMake(-40*CXCWidth, -40*CXCWidth, 80*CXCWidth, 80*CXCWidth)];
            [xBtn setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
            [xBtn setImageEdgeInsets:UIEdgeInsetsMake(20*CXCWidth, 20*CXCWidth, 20*CXCWidth, 20*CXCWidth)];
            xBtn.userInteractionEnabled =YES;
            [xBtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
            xBtn.tag =44400+i;
            [btn addSubview:xBtn];
            

            
            
        }else
        {
            if (i<6) {
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth+i%3*CXCWidth*235, i<3? 30*CXCWidth:250*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
                [btn setImage:[UIImage imageNamed:@"icon_insert_pic"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
                btn.tag =400+i;
                [ zhong  addSubview:btn];
                
                
            }
            
        }
        
    }



}
//选图回来
- (void)YBImagePickerDidFinishWithImages:(NSMutableArray *)imageArray {
    //    for (UIImage * image in imageArray) {
    //
    //    }
    [_picIdArr addObjectsFromArray:imageArray ];
    [self xianshi];
    
    
      [self zhuanhuanTupian];
    
    
    //    [self addMorePhoto:photoArr];
}
- (void)zhuanhuanTupian
{
    _picUrlArr = [[NSMutableArray alloc]init];
    _picArr= [[NSMutableArray alloc]init];
    for (int i=0; i<_picIdArr.count; i++) {
        UIImage *image = _picIdArr[i];
        // 把头像图片存到本地
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];   // 保存文件的名称
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [imageData writeToFile:filePath atomically:YES];
        
        CGSize originalSize = image.size;
        
        CGFloat maxSize = 250;
        
        CGFloat width =originalSize.width;
        CGFloat height=originalSize.height ;
        
        
        if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
            width = maxSize;
            height = width*originalSize.height /originalSize.width;
        }
        
        if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
            height = maxSize;
            width= height*originalSize.width /originalSize.height;
        }
        
        
        CGSize newSize = CGSizeMake(width, height);
        
        UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
        
        [_picArr addObject:sacelImg];
        [_picUrlArr addObject:imageData];
        
        
        
    }
    
    
    
    
}
//删除回来
- (void)tupian:(NSNotification *)not
{
    _picIdArr = not.object;
    
    [self xianshi];

    
    [self zhuanhuanTupian];
    
}
- (NSString*)getMyImage:(UIImage*)image{
    CGSize originalSize = image.size;
    
    CGFloat maxSize = 500;
    
    CGFloat width =originalSize.width;
    CGFloat height=originalSize.height;
    if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
        width = maxSize;
        height = width*originalSize.height /originalSize.width;
    }
    
    if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
        height = maxSize;
        width= height*originalSize.width /originalSize.height;
    }
    
    CGSize newSize = CGSizeMake(width, height);
    UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
    
    // 保存图片至本地，方法见下文
    NSData *dd =UIImageJPEGRepresentation(sacelImg, 1.0);
    return [dd base64EncodedStringWithOptions:0];
    
}
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (void)datu:(UIButton *)btn
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ShowBigPicController *showP = [[ShowBigPicController alloc]init];
    showP.picUrlArr =_picIdArr;
    showP.isXiangce = YES;
    
    
    [self.navigationController pushViewController:showP animated:YES];
    
}



@end
