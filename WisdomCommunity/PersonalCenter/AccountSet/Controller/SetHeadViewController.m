//
//  SetHeadViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SetHeadViewController.h"

@interface SetHeadViewController ()

@end

@implementation SetHeadViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setSHeadStyle];
    [self initSHeadController];
    
}
- (void) setSHeadStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置头像";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) initSHeadController
{
    _imageViewR = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.26, (CYScreanH - 64) * 0.15, CYScreanW * 0.48, CYScreanW * 0.48)];
    _imageViewR.backgroundColor = [UIColor clearColor];
    [_imageViewR sd_setImageWithURL:[NSURL URLWithString:self.headString] placeholderImage:nil];
    [self.view addSubview:_imageViewR];
//    _imageViewR.layer.cornerRadius = _imageViewR.frame.size.width / 2;
//    _imageViewR.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOpertationHSet)];
    //允许用户交互
    _imageViewR.userInteractionEnabled = YES;
    [_imageViewR addGestureRecognizer:tap];
    [self tapOpertationHSet];
    UIButton *userPictureButton = [[UIButton alloc] init];
    [userPictureButton setTitle:@"设置头像" forState:UIControlStateNormal];
    [userPictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [userPictureButton addTarget:self action:@selector(setHeadOnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    userPictureButton.layer.cornerRadius = 5;
    userPictureButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [self.view addSubview:userPictureButton];
    [userPictureButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_imageViewR.mas_bottom).offset((CYScreanH - 64) * 0.1);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
         make.height.mas_equalTo(CYScreanH * 0.06);
     }];
}
//响应函数
-(void)tapOpertationHSet
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
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
//IOS7以上的都要调用方法，选择完成后调用该方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//可编辑
    image = [self circleImage:image];
    //保存图片至本地，上传图片到服务器需要使用
    [self saveImage:image withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //设置图片显示
    [_imageViewR setImage:image];
    //上传图片 //异步加载
    [MBProgressHUD showLoadToView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self uploadHeadImage:savedImage];
    });
}
//处理成圆形
-(UIImage*) circleImage:(UIImage*) image
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width , image.size.height );
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
//上传图片
- (void) uploadHeadImage:(UIImage *)image
{
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",POSTREQUESTURL];
    NSData *imageData;
    imageData = UIImageJPEGRepresentation(image, 0.1);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"请求成功:%@", responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [self changePersonalHead:[[JSON objectForKey:@"param"] objectForKey:@"url"]];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}
//修改个人信息
- (void) changePersonalHead:(NSString *)ImageUrl
{
    if (![ImageUrl isEqual:@"error"])
    {
        [MBProgressHUD showLoadToView:self.view];
        NSDictionary *dict = [CYSmallTools getDataKey:PERSONALDATA];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"id"]        =  [dict objectForKey:@"id"];
        parames[@"imgAddress"]  =  [NSString stringWithFormat:@"%@",ImageUrl];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/updateAccInfo",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [CYSmallTools saveData:JSON withKey:ACCOUNTDATA];//记录账号数据
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
    else
        [MBProgressHUD showError:@"请先上传图片" ToView:self.view];
}
//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击事件
-(void) setHeadOnClickButton:(id)sender
{
    [self tapOpertationHSet];
}





@end
