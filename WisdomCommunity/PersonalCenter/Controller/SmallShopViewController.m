//
//  SmallShopViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SmallShopViewController.h"

@interface SmallShopViewController ()
{
    UIScrollView *bgScrollView;//背景scrollview

}

@end

@implementation SmallShopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setSShopStyle];
    [self initSShopController];

}
//设置样式
- (void) setSShopStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我要开微店";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//
- (void) initSShopController
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    bgScrollView.scrollEnabled = YES;
    //    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    NSArray *smallArray = @[@"店铺头像:",@"店主姓名:",@"手机号码:",@"店铺名称:",@"店铺介绍:"];
    //
    for (NSInteger i = 0; i < smallArray.count; i ++)
    {
        //提示文字
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor blackColor];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.font = font;
        promptLabel.text = [NSString stringWithFormat:@"%@",smallArray[i]];
        [bgScrollView addSubview:promptLabel];
        if (i==0) {
            promptLabel.frame =CGRectMake(0, ((CYScreanH - 64) * 0.075),(CYScreanW * 0.25) , ((CYScreanH - 64) * 0.06));

        }else
        {
        
            promptLabel.frame =CGRectMake(0, ((CYScreanH - 64) * 0.1 + i * (CYScreanH - 64) * 0.08),(CYScreanW * 0.25) , ((CYScreanH - 64) * 0.06));

        }
        
//        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.left.equalTo(self.view.mas_left).offset(0);
//             make.width.mas_equalTo(CYScreanW * 0.25);
//             if (i == 0)
//             {
//                 make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.075);
//             }
//             else
//                 make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.1 + i * (CYScreanH - 64) * 0.08);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//         }];
    }
    //店铺头像
    self.storeImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.26, (CYScreanH - 64) * 0.05, (CYScreanH - 64) * 0.11, (CYScreanH - 64) * 0.11)];
    self.storeImage.image = [UIImage imageNamed:@"icon_head_weidian"];
    self.storeImage.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:self.storeImage];
    self.storeImage.layer.cornerRadius = self.storeImage.frame.size.width / 2;
    self.storeImage.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOpertationStoreSet)];
    //允许用户交互
    self.storeImage.userInteractionEnabled = YES;
    [self.storeImage addGestureRecognizer:tap];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击上传照片";
    label.font = [UIFont fontWithName:@"Arial" size:13];
    label.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    [bgScrollView addSubview:label];
    label.frame =CGRectMake(_storeImage.right+(CYScreanW * 0.03), ((CYScreanH - 64) * 0.085),(CYScreanW * 0.4) , ((CYScreanH - 64) * 0.04));
    
//    [label mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.equalTo(self.storeImage.mas_right).offset(CYScreanW * 0.03);
//        make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.085);
//        make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//    }];
    UIColor *graColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.00];
    //姓名输入框
    self.nameSSTextField = [[UITextField alloc] init];
    self.nameSSTextField.placeholder = @"请输入您的真实姓名";
    self.nameSSTextField.delegate = self;
    self.nameSSTextField.font = font;
    self.nameSSTextField.returnKeyType = UIReturnKeyDone;
    self.nameSSTextField.layer.cornerRadius = 5;
    self.nameSSTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.nameSSTextField.layer.borderWidth = 1;
    self.nameSSTextField.textColor = graColor;
    self.nameSSTextField.backgroundColor = [UIColor clearColor];
    self.nameSSTextField.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:self.nameSSTextField];
    _nameSSTextField.frame= CGRectMake((CYScreanW * 0.26), ((CYScreanH - 64) * 0.18), CYScreanW*0.7,((CYScreanH - 64) * 0.06) );
//    [self.nameSSTextField mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.26);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.18);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
    //手机号码
    self.phoneSSTextField = [[UITextField alloc] init];
    self.phoneSSTextField.placeholder = @"请输入您的手机号";
    self.phoneSSTextField.delegate = self;
    self.phoneSSTextField.font = font;
    self.phoneSSTextField.returnKeyType = UIReturnKeyDone;
    self.phoneSSTextField.layer.cornerRadius = 5;
    self.phoneSSTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.phoneSSTextField.layer.borderWidth = 1;
    self.phoneSSTextField.textColor = graColor;
    self.phoneSSTextField.backgroundColor = [UIColor clearColor];
    self.phoneSSTextField.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:self.phoneSSTextField];
    _phoneSSTextField.frame =CGRectMake((CYScreanW * 0.26), ((CYScreanH - 64) * 0.26), CYScreanW*0.7,((CYScreanH - 64) * 0.06) );
    
//    [self.phoneSSTextField mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.26);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.26);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
    //手机店铺名
    self.storeNameTextField = [[UITextField alloc] init];
    self.storeNameTextField.placeholder = @"请输入您的店铺名称";
    self.storeNameTextField.delegate = self;
    self.storeNameTextField.returnKeyType = UIReturnKeyDone;
    self.storeNameTextField.font = font;
    self.storeNameTextField.layer.cornerRadius = 5;
    self.storeNameTextField.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.storeNameTextField.layer.borderWidth = 1;
    self.storeNameTextField.textColor = graColor;
    self.storeNameTextField.backgroundColor = [UIColor clearColor];
    self.storeNameTextField.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:self.storeNameTextField];
    _storeNameTextField.frame =CGRectMake((CYScreanW * 0.26), ((CYScreanH - 64) * 0.34), CYScreanW*0.7,((CYScreanH - 64) * 0.06) );

//    [self.storeNameTextField mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.26);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.34);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];

    //店铺介绍
    self.storePromptTextView = [[UITextView alloc] init];
    self.storePromptTextView.textColor = [UIColor lightGrayColor];//设置提示内容颜色
    self.storePromptTextView.text = NSLocalizedString(@"这个人很懒，什么都没有留下...", nil);//提示语
    self.storePromptTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.storePromptTextView.delegate = self;
    self.storePromptTextView.font = font;
    self.storePromptTextView.returnKeyType = UIReturnKeyDone;
    self.storePromptTextView.layer.cornerRadius = 5;
    self.storePromptTextView.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
    self.storePromptTextView.layer.borderWidth = 1;
    self.storePromptTextView.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:self.storePromptTextView];
    _storePromptTextView.frame =CGRectMake((CYScreanW * 0.26), ((CYScreanH - 64) * 0.42), CYScreanW*0.7,((CYScreanH - 64) * 0.2) );

//    [self.storePromptTextView mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.26);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.42);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.3);
//     }];
    //提交
    UIButton *submitButton = [[UIButton alloc] init];
    submitButton = [[UIButton alloc] init];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 5;
    submitButton.backgroundColor = [UIColor colorWithRed:0.302 green:0.549 blue:0.898 alpha:1.00];
    [submitButton addTarget:self action:@selector(submitStore) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:submitButton];
    
    submitButton.frame =CGRectMake((CYScreanW * 0.03), _storePromptTextView.bottom+((CYScreanH - 64) * 0.1), CYScreanW*0.94, ((CYScreanH - 64) * 0.08));
    
    [bgScrollView setContentSize:CGSizeMake(CYScreanW,submitButton.bottom+CYScreanW*0.55)];

    
    
//    [submitButton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.storePromptTextView.mas_bottom).offset((CYScreanH - 64) * 0.1);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
//     }];
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameSSTextField resignFirstResponder];
    [self.phoneSSTextField resignFirstResponder];
    [self.storeNameTextField resignFirstResponder];
    [self.storePromptTextView resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"这个人很懒，什么都没有留下...", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"这个人很懒，什么都没有留下...", nil);
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
            textView.text=NSLocalizedString(@"这个人很懒，什么都没有留下...", nil);
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
        textView.text=NSLocalizedString(@"这个人很懒，什么都没有留下...", nil);
    }
}
//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing");
    return YES;
}
//响应函数
-(void)tapOpertationStoreSet
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
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           //取消之后直接返回上一层
                                           [self.navigationController popViewControllerAnimated:YES];
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
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourctType = 0;
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex) {
            case 1:
                sourctType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                sourctType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                break;
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            sourctType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    //跳转到相机或者相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourctType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
//保存图片
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
//IOS7以上的都要调用方法，选择完成后调用该方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];//可编辑
    //保存图片至本地，上传图片到服务器需要使用
    [self saveImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //设置图片显示
    [self.storeImage setImage:image];
    //上传图片 //异步加载
    [MBProgressHUD showLoadToView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         self.uploadImageUrl = [CYLRDataReuest uploadImage:savedImage withView:self.view];
    });
}
//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交开店请求
- (void) submitStore
{
    if (self.nameSSTextField.text.length && self.phoneSSTextField.text.length && self.storeNameTextField.text.length && self.storePromptTextView.text.length)
    {
        if (!self.uploadImageUrl.length)
        {
            [MBProgressHUD showError:@"请上传店铺头像" ToView:self.view];
            return;
        }
        if (![CYWhetherPhone isValidPhone:self.phoneSSTextField.text])
        {
            [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
            return;
        }
        [MBProgressHUD showLoadToView:self.view];
        //切换数据
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/applySeller",POSTREQUESTURL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        dict[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        dict[@"master"]      =  [NSString stringWithFormat:@"%@",self.nameSSTextField.text];
        dict[@"phone"]       =  [NSString stringWithFormat:@"%@",self.phoneSSTextField.text];
        dict[@"shopName"]    =  [NSString stringWithFormat:@"%@",self.storeNameTextField.text];
        dict[@"intro"]       =  [NSString stringWithFormat:@"%@",self.storePromptTextView.text];
        dict[@"imgAddr"]     =  self.uploadImageUrl;
        dict[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
        NSLog(@"dict = %@",dict);
        
        [manager POST:requestUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
                 [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"失败:%@", error.description);
         }];
    }
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
}

@end
