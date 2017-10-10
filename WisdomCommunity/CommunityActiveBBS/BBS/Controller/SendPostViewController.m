//
//  SendPostViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SendPostViewController.h"
#import "YBImgPickerViewController.h"
#import "ShowBigPicController.h"

@interface SendPostViewController ()<YBImgPickerViewControllerDelegate>

{
    UIScrollView *bgScrollView;
    int timeCount;//上传图片请求
    UIView *bottomView;

}
@end

@implementation SendPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _uploadImageVArray =[[NSMutableArray alloc]init];
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH-44)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
//    bgScrollView.backgroundColor =BGColor;
    bgScrollView.scrollEnabled = YES;
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];
    
    _picArr =[[NSMutableArray alloc]init];
    _picUrlArr =[[NSMutableArray alloc]init];
    _picIdArr =[[NSMutableArray alloc]init];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tupian:) name:@"tupian" object:nil];
    [self setSPosetStyle];
    [self initSPosetController];

}
//设置样式
- (void) setSPosetStyle
{
    //样式
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发帖";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化控件
- (void) initSPosetController
{
    
    
    //标题
    self.postTitleTextField = [[UITextField alloc] init];
    self.postTitleTextField.placeholder = @"#请输入主题名称#";
    self.postTitleTextField.delegate = self;
    _postTitleTextField.font =[UIFont systemFontOfSize:14];
    
    self.postTitleTextField.returnKeyType = UIReturnKeyDone;
    self.postTitleTextField.textColor = [UIColor colorWithRed:0.376 green:0.376 blue:0.376 alpha:1.00];
    self.postTitleTextField.backgroundColor = [UIColor clearColor];
    self.postTitleTextField.textAlignment = NSTextAlignmentLeft;
    [bgScrollView addSubview:self.postTitleTextField];
    _postTitleTextField.frame =CGRectMake((CXCWidth * 30), 0,CYScreanW-60*CXCWidth ,99*CXCWidth);
 
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [bgScrollView addSubview:segmentationImmage];
    segmentationImmage.frame =CGRectMake(30*CXCWidth,_postTitleTextField.bottom,CYScreanW ,1*CXCWidth);
    
    //帖子内容
    self.postContentTextView = [[UITextView alloc] init];
    self.postContentTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.postContentTextView.text=NSLocalizedString(@"想说就说，写下这一刻所想", nil);//提示语
    self.postContentTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.postContentTextView.delegate = self;
    self.postContentTextView.font = [UIFont fontWithName:@"Arial" size:14];
    self.postContentTextView.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:self.postContentTextView];
    _postContentTextView.frame =CGRectMake(30*CXCWidth, (segmentationImmage.bottom)+CXCWidth*30, 690*CXCWidth, 200*CXCWidth);
    
    //中间信息
    UIView *zhongView = [[UIView alloc]initWithFrame:CGRectMake(0,_postContentTextView.bottom+10*CXCWidth,CYScreanW, 250*CXCWidth)];
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
    
    
    
    //地址及以下
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,zhongView.bottom,CYScreanW,1000*CXCWidth)];
    [bgScrollView addSubview:bottomView];
    bottomView.backgroundColor =BGColor;
    UIView *addImgV =[[UIView alloc]initWithFrame:CGRectMake(0*CXCWidth, 0*CXCWidth, CXCScreanH, 140*CXCWidth)];
    addImgV.backgroundColor =[UIColor whiteColor];
    [bottomView addSubview:addImgV];
    //热点
    self.hotButton = [[UIButton alloc] init];
    self.hotButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.hotButton setTitle:@"热点" forState:UIControlStateNormal];
    [self.hotButton setTitleColor:[UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1.00] forState:UIControlStateNormal];
    [self.hotButton setTitleColor:[UIColor colorWithRed:0.00 green:0.333 blue:0.741 alpha:1.00] forState:UIControlStateSelected];
    [self.hotButton setImage:[UIImage imageNamed:@"icon_topic"] forState:UIControlStateNormal];
    [self.hotButton setImage:[UIImage imageNamed:@"icon_topic_pre"] forState:UIControlStateSelected];

    
    [self.hotButton addTarget:self action:@selector(LabelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.hotButton];
    _hotButton.frame =CGRectMake(20*CXCWidth,45*CXCWidth, 140*CXCWidth, 50*CXCWidth);
    
    self.hotButton.selected = YES;
    self.PostLabelStr = @"1";
   
    

    
    //分享
    self.shareButton = [[UIButton alloc] init];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    self.shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.shareButton setTitleColor:[UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1.00] forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor colorWithRed:0.00 green:0.333 blue:0.741 alpha:1.00] forState:UIControlStateSelected];
    [self.shareButton setImage:[UIImage imageNamed:@"fatie_icon_share_pre"] forState:UIControlStateSelected];
    [self.shareButton setImage:[UIImage imageNamed:@"fatie_icon_share"] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(LabelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.shareButton];
    self.shareButton.selected = NO;
      _shareButton.frame =CGRectMake(20*CXCWidth+140*CXCWidth,45*CXCWidth,140*CXCWidth, 50*CXCWidth);

    //集市
    self.bazaarButton = [[UIButton alloc] init];
    [self.bazaarButton setTitle:@"集市" forState:UIControlStateNormal];
    self.bazaarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bazaarButton setTitleColor:[UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1.00] forState:UIControlStateNormal];
    [self.bazaarButton setTitleColor:[UIColor colorWithRed:0.00 green:0.333 blue:0.741 alpha:1.00] forState:UIControlStateSelected];
    [self.bazaarButton addTarget:self action:@selector(LabelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.bazaarButton];
    [self.bazaarButton setImage:[UIImage imageNamed:@"fatie_icon_jishi"] forState:UIControlStateNormal];
    [self.bazaarButton setImage:[UIImage imageNamed:@"fatie_icon_jish_pre"] forState:UIControlStateSelected];
    self.bazaarButton.frame =CGRectMake(20*CXCWidth+140*CXCWidth*2,45*CXCWidth, 140*CXCWidth, 50*CXCWidth);


    

    self.bazaarButton.selected = NO;
  
    //发布
    UIButton *sendButton = [[UIButton alloc] init];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    sendButton.layer.cornerRadius = 3;

    [sendButton addTarget:self action:@selector(launchedDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendButton];
    sendButton.frame =CGRectMake(30*CXCWidth,200*CXCWidth+106*CXCWidth,690*CXCWidth,100*CXCWidth);
    [bgScrollView setContentSize:CGSizeMake(CYScreanW,sendButton.bottom+CYScreanW*0.1)];
    
    
}
-(void)shanchu:(UIButton *)btn
{
    [_picIdArr removeObjectAtIndex:btn.tag-44400];
    [self xianshi];
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
        [self sendPostButton ];
        
    }
    
    
    
    
    
}

-(void)xuanzhong
{
    //    UIActionSheet *photoSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    //    [photoSheet showInView:self.view];
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    
    //    [next showInViewContrller:self choosenNum:0 delegate:self];
    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr];
    
    
    
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
            
            zhong.frame =CGRectMake(0,_postContentTextView.bottom+CXCWidth*10,CYScreanW, 250*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 1000*CXCWidth);
            [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
            
            
        }else
        {
            zhong.frame =CGRectMake(0,_postContentTextView.bottom+CXCWidth*10,CYScreanW, 470*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 1000*CXCWidth);
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



//标签按钮
- (void) LabelSelectButton:(UIButton *)sender
{
    if (sender == self.hotButton)
    {
        self.hotButton.selected    = YES;
        self.shareButton.selected  = NO;
        self.bazaarButton.selected = NO;
        self.PostLabelStr = @"1";
    }
    else if (sender == self.shareButton)
    {
        self.hotButton.selected    = NO;
        self.shareButton.selected  = YES;
        self.bazaarButton.selected = NO;
        self.PostLabelStr = @"2";
    }
    else
    {
        self.hotButton.selected    = NO;
        self.shareButton.selected  = NO;
        self.bazaarButton.selected = YES;
        self.PostLabelStr = @"3";
    }
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//- (BOOL)stringContainsEmoji:(NSString *)string
//{
//    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"])
//    {return YES;}
//    else
//    {return NO;}
//}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.postTitleTextField resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"想说就说，写下这一刻所想", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"想说就说，写下这一刻所想", nil);
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
            textView.text=NSLocalizedString(@"想说就说，写下这一刻所想", nil);
        }
        
        return NO;
    }
if([self stringContainsEmoji:text])
{

    [MBProgressHUD showError:@"请不要输入表情" ToView:self.navigationController.view];
    [textView resignFirstResponder];

    return NO;
}
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"想说就说，写下这一刻所想", nil);
    }
}

//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
//响应函数
-(void)tapOpertationSet
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
//上传图片
- (void) uploadImage:(NSData *)imageDate withInt:(NSInteger)index
{
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",POSTREQUESTURL];
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *eachImgData = UIImageJPEGRepresentation(_picIdArr[index], 0.1);
        //        使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //
        [formData appendPartWithFileData :eachImgData name : @"file" fileName : fileName mimeType : @"image/jpg/png/jpeg" ];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"请求成功:%@", responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
           [self.uploadImageVArray replaceObjectAtIndex:index withObject:[[JSON objectForKey:@"param"] objectForKey:@"url"]];
            if (timeCount==_picIdArr.count) {
                
                
                [self sendPostButton];
                
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发布帖子
- (void) sendPostButton
{
    if (self.postTitleTextField.text.length && self.postContentTextView.text.length)
    {
        [MBProgressHUD showLoadToView:self.view];
        NSLog(@"self.uploadImageVArray = %@",self.uploadImageVArray);
        NSString *imageString;
        for (NSString *string in self.uploadImageVArray)
        {
            if (string.length > 6)//不为空
            {
                if (imageString.length) {
                    imageString = [NSString stringWithFormat:@"%@,%@",imageString,string];
                }
                else
                    imageString = [NSString stringWithFormat:@"%@",string];
            }
        }
        //个人数据
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"title"]       =  [NSString stringWithFormat:@"%@",self.postTitleTextField.text];
        parames[@"content"]     =  [NSString stringWithFormat:@"%@",self.postContentTextView.text];
        parames[@"category"]    =  [NSString stringWithFormat:@"%@",self.PostLabelStr];
        parames[@"imgAddress"]  =  imageString;
        parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/addNote",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
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
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
}

- (BOOL)stringContainsEmoji:(NSString *)string
{
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"])
    {return YES;}
    else
    {return NO;}
}
@end
