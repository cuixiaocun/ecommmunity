//
//  ComplaintsSuggestionsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComplaintsSuggestionsViewController.h"
#import "YBImgPickerViewController.h"
#import "ShowBigPicController.h"

@interface ComplaintsSuggestionsViewController ()<YBImgPickerViewControllerDelegate>
{

    UIScrollView *bgScrollView;//背景scrollview
    int timeCount;//上传图片请求
    UIView *bottomView;
    

}

@end

@implementation ComplaintsSuggestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _picArr =[[NSMutableArray alloc]init];
    _picUrlArr =[[NSMutableArray alloc]init];
    _picIdArr =[[NSMutableArray alloc]init];
    _uploadImageVArray =[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tupian:) name:@"tupian" object:nil];
    
    

    [self setSuggestionStyle];
    [self initSuggestionController];
    
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//设置样式
- (void) setSuggestionStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"投诉建议";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//初始化控件
- (void) initSuggestionController
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    bgScrollView.scrollEnabled = YES;
    //    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];
    NSArray *leftArr =@[@"投诉人",@"手机",@"投诉类型"];
    NSArray *rightArr =@[@"请输入报修人姓名",@"请输入联系电话",@"请输入楼宇号"];
    
    for (int i=0; i<3; i++) {
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.frame =CGRectMake(30*CXCWidth,i*96*CXCWidth, 300*CXCWidth, 96*CXCWidth);
        promptLabel.textColor = TEXTColor;
        [bgScrollView addSubview:promptLabel];
        
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.frame =CGRectMake(25*CXCWidth,95*CXCWidth*(i+1), CYScreanW, 1*CXCWidth);
        [bgScrollView addSubview:segmentationImmage];
        //提示文字
        promptLabel.font = [UIFont systemFontOfSize:14];
        promptLabel.text =leftArr[i];
        //内容（右边）
        if(i<2)
        {
            UITextField *rightLabel = [[UITextField alloc] initWithFrame:CGRectMake(300*CXCWidth,i*96*CXCWidth , 420*CXCWidth, 96*CXCWidth)];
            rightLabel.textColor = TextGroColor;
            rightLabel.tag =110+i;
            rightLabel.placeholder =rightArr[i];
            rightLabel.textAlignment =NSTextAlignmentRight;
            rightLabel.font = [UIFont fontWithName:@"Arial" size:14];
            rightLabel.delegate =self;
            [bgScrollView addSubview:rightLabel];
            segmentationImmage.backgroundColor = BGColor;
            [bgScrollView addSubview:segmentationImmage];
            
        if(i==0)
        {
            _complaintsTextField =rightLabel;
            _complaintsTextField.placeholder = @"请输入姓名";
            
        }else if (i==1)
        {
            _phoneSTextField=rightLabel;
            _phoneSTextField.placeholder = @"请输入联系电话";
        }
    }
        
        if (i==2)
        {
            //大按钮
            UIButton *cell = [[UIButton alloc]init];
            {
                cell.frame = CGRectMake(250*CXCWidth, 0+96*CXCWidth*i, CYScreanW-250*CXCWidth, 100*CXCWidth);
            [cell addTarget:self action:@selector(selectTypeButton:) forControlEvents:UIControlEventTouchUpInside];
            cell.backgroundColor = [UIColor whiteColor];
            [bgScrollView addSubview:cell];
                
            //右边文字
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0*CXCWidth, 0, 430*CXCWidth, 95*CXCWidth)];
            label2.textColor = TextGroColor;
            label2.text =@"请选择投诉类型";
            label2.textAlignment =NSTextAlignmentRight;
            label2.font = [UIFont systemFontOfSize:13];
            [cell addSubview:label2];
            label2.tag =110+i;
            
            UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(450*CXCWidth, 40*CXCWidth,20*CXCWidth , 20*CXCWidth)];
            [imgV setImage:[UIImage imageNamed:@"icon_drop_down"]];
            [cell addSubview:imgV];
            
            
            UIImageView *imagV3 = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 96*(i+1)*CXCWidth,710*CXCWidth,1*CXCWidth)];
            [imagV3 setBackgroundColor:BGColor];
            [bgScrollView addSubview:imagV3];
            
                _typeButton =cell;
         }
        
     }
   }
    
    //活动内容
    self.problemDescriptionTextView = [[UITextView alloc] init];
    self.problemDescriptionTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.problemDescriptionTextView.text=NSLocalizedString(@"详细描述一下您的问题", nil);//提示语
    self.problemDescriptionTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.problemDescriptionTextView.delegate = self;
    self.problemDescriptionTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.problemDescriptionTextView.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:self.problemDescriptionTextView];
    _problemDescriptionTextView.frame =CGRectMake(30*CXCWidth, 300*CXCWidth, 690*CXCWidth, 200*CXCWidth);
    
    
    
    //中间信息
    UIView *zhongView = [[UIView alloc]initWithFrame:CGRectMake(0,_problemDescriptionTextView.bottom+10*CXCWidth,CYScreanW, 250*CXCWidth)];
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
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,zhongView.bottom,CYScreanW, 520*CXCWidth)];
    //    bottomView.backgcroundColor =[UIColor redColor];
    [bgScrollView addSubview:bottomView];
    
    
    //报修
    UIButton *complaintsButton = [[UIButton alloc] init];
    [complaintsButton setTitle:@"立即投诉" forState:UIControlStateNormal];
    [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    complaintsButton.layer.cornerRadius = 5;
    complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [complaintsButton addTarget:self action:@selector(launchedDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:complaintsButton];
    complaintsButton.frame =CGRectMake((30*CXCWidth), 100*CXCWidth,CXCWidth*690 , 100*CXCWidth);
    //提示
    UIButton *promptButton = [[UIButton alloc] init];
    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
    [promptButton setImage:[UIImage imageNamed:@"icon_pro_tel"] forState:UIControlStateNormal];
    promptButton.backgroundColor = [UIColor clearColor];
    [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];
    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [bottomView addSubview:promptButton];
    promptButton.frame =CGRectMake((30*CXCWidth), 230*CXCWidth,CXCWidth*690 , 40*CXCWidth);

     self.typeConplabtsArray = @[@"房屋设施",@"公共设施",@"服务评价"];
    //房屋列表
    self.typeComplaintsTableView = [[UITableView alloc] init];
    self.typeComplaintsTableView.delegate = self;
    self.typeComplaintsTableView.dataSource = self;
    self.typeComplaintsTableView.layer.cornerRadius = 5;
    self.typeComplaintsTableView.showsVerticalScrollIndicator = NO;
    self.typeComplaintsTableView.backgroundColor = [UIColor whiteColor];
    self.typeComplaintsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.typeComplaintsTableView.layer.borderColor = BGColor.CGColor;
    self.typeComplaintsTableView.layer.borderWidth = 1;
    [self.view addSubview:self.typeComplaintsTableView];
    [self.typeComplaintsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.6);
        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
        make.top.equalTo(self.typeButton.mas_bottom).offset(0);
        make.height.mas_equalTo((CYScreanH - 64) * 0.18);
    }];
    self.typeComplaintsTableView.hidden = YES;
//
//    
//    
//    [bgScrollView setContentSize:CGSizeMake(CYScreanW,promptButton.bottom+CYScreanW*0.1)];

}
//拨打电话
- (void) callPropertyPhone
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", [CYSmallTools getDataStringKey:PROPERTYCPHONE]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [bgScrollView addSubview:callWebview];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.06;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeConplabtsArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
//    cell.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    cell.textLabel.textColor = TEXTColor;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.typeConplabtsArray[indexPath.row]];
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.typeComplaintsTableView.hidden = YES;
    self.typeId = [NSString stringWithFormat:@"%ld",indexPath.row];
//    [self.typeButton setTitle:self.typeConplabtsArray[indexPath.row] forState:UIControlStateNormal];
    UILabel *lab =[self.view viewWithTag:112];
    lab.text =self.typeConplabtsArray[indexPath.row] ;
    
    
    NSLog(@"点击了%@",self.typeConplabtsArray[indexPath.row]);
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 函数  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
//点击查看类型
- (void) selectTypeButton:(UIButton *)sender
{
    if (self.typeComplaintsTableView.hidden == YES) {
        self.typeComplaintsTableView.hidden = NO;
    }
    else
        self.typeComplaintsTableView.hidden = YES;
    //释放第一响应身份
    [_phoneSTextField resignFirstResponder];
    [_problemDescriptionTextView resignFirstResponder];
    [_complaintsTextField resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"详细描述一下您的问题", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"详细描述一下您的问题", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
//内容将要发生改变编辑,编辑完使用return退出

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
            textView.text=NSLocalizedString(@"详细描述一下您的问题", nil);
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
        textView.text=NSLocalizedString(@"详细描述一下您的问题", nil);
    }
}
//保存图片
- (void) savePRImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}



//投诉
- (void) RequestComplaints
{
    UILabel*lab =[self.view viewWithTag:112];
    if ([lab.text isEqualToString:@"请选择投诉类型"]) {
        [MBProgressHUD showError:@"请选择投诉类型" ToView:self.view];
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
    
    if (self.phoneSTextField.text.length && self.problemDescriptionTextView.text.length && self.complaintsTextField.text.length)
    {
        if (![CYWhetherPhone isValidPhone:self.phoneSTextField.text])
        {
            [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
            return;
        }
        [MBProgressHUD showLoadToView:self.view];
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
        parames[@"user"]        =  [NSString stringWithFormat:@"%@",self.complaintsTextField.text];//
        parames[@"phone"]       =  [NSString stringWithFormat:@"%@",self.phoneSTextField.text];
        parames[@"category"]    =  [NSString stringWithFormat:@"%@",self.typeId];//
        parames[@"reason"]      =  [NSString stringWithFormat:@"%@",self.problemDescriptionTextView.text];
        if (![self.imageAddress isEqualToString:@""] && self.imageAddress != nil) {
            [parames setObject:_imageAddress forKey:@"imgAddress"];
        }
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/addComplain",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 NSLog(@"投诉成功");
                 [MBProgressHUD showError:@"提交成功" ToView:self.navigationController.view];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"请求失败:%@", error.description);
         }];
    }
    else
    {
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    _uploadImageVArray =[[NSMutableArray alloc]init];
    
    
    for(NSInteger i = 0; i < self.picIdArr.count; i++)
    {
        NSData * imageData = [self.picUrlArr objectAtIndex: i];
        [_uploadImageVArray addObject:@""];
        
        [self uploadImage:imageData withInt:i];
        
    }
    if(_picIdArr.count==0)
    {
        [self RequestComplaints ];
        
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
        //使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData :eachImgData name : @"file" fileName : fileName mimeType : @"image/jpg/png/jpeg" ];
      
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
                
                
                [self RequestComplaints];
                
                
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
-(void)xuanzhong
{
    //    UIActionSheet *photoSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    //    [photoSheet showInView:self.view];
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    
    //    [next showInViewContrller:self choosenNum:0 delegate:self];
    //    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr];//6个的时候
    
    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr withNum:5];//一张照片的时候
    
    
    
    
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
            
            zhong.frame =CGRectMake(0,self.problemDescriptionTextView.bottom+CXCWidth*10,CYScreanW, 250*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 520*CXCWidth);
            [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
            
            
        }else
        {
            zhong.frame =CGRectMake(0,self.problemDescriptionTextView.bottom+CXCWidth*10,CYScreanW, 470*CXCWidth);
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
        {//6张时候<6
            if (i<1) {
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth+i%3*CXCWidth*235, i<3? 30*CXCWidth:250*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
                [btn setImage:[UIImage imageNamed:@"icon_insert_pic"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
                btn.tag =400+i;
                [ zhong  addSubview:btn];
                
                
            }
            
        }
        
    }
    
    
    
}
-(void)shanchu:(UIButton *)btn
{
    [_picIdArr removeObjectAtIndex:btn.tag-44400];
    [self xianshi];
    
    
}

//选图回来
- (void)YBImagePickerDidFinishWithImages:(NSMutableArray *)imageArray {
    //    for (UIImage * image in imageArray) {
    //
    //    }
    [_picIdArr addObjectsFromArray:imageArray ];
    [self xianshi];//多张
    
    
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
