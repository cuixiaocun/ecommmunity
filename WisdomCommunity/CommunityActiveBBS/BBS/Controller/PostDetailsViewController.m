//
//  PostDetailsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()
{
    float wenziHight;
    UIView *bgview ;
    UILabel *postLabel;
    int time_i;
    NSMutableArray *SeeImageObjArray;
}
@end

@implementation PostDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBBSDData];
    [self setPostStyle];
    //增加监听，当键盘出现或改变时收出消息
    [self setNotification];
    [self initPostController];
    time_i=1;
    
    //获取帖子评论
    [self getPostDetailsRequest:[self.BBSDetailsDict objectForKey:@"id"]];
}
//初始化数据
- (void) initPostModel:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
        
        NSString *content = [NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]];
        //记录评论高度
        CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:content.length > 0 ? content : @"未获取"]];
        [self.PostDetailsHeight addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
        NSString *fromDo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"accountDO"]];
        if (fromDo.length > 6)
        {
            NSDictionary *fromDict = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"accountDO"]];
            [self.PostDetailsModelarray addObject:[self dataTurnModel:[fromDict objectForKey:@"nickName"] withPost:content withTime:[dict objectForKey:@"gmtCreate"] withHead:[fromDict objectForKey:@"imgAddress"]]];
        }
        else
        {
            [self.PostDetailsModelarray addObject:[self dataTurnModel:@"未获取" withPost:content withTime:@"未获取时间信息" withHead:@""]];
        }
    }
    //刷新评论
    [self.PostDetailsTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    //刷新
//    [self.PostDetailsTableView reloadData];
}
//数据转模型
- (PostDetailsModel *) dataTurnModel:(NSString *)name withPost:(NSString *)post withTime:(NSString *)time withHead:(NSString *)head
{
    NSDictionary *dict = @{
                           @"headImageString":head,
                           @"nameString":name,
                           @"timeString":time,
                           @"postString":post
                           };
    PostDetailsModel *model = [PostDetailsModel bodyWithDict:dict];
    return model;
}
//设置样式
- (void) setPostStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帖子详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
//初始化数据源
- (void) initBBSDData
{
    //数据源
    self.PostDetailsModelarray = [[NSMutableArray alloc] init];
    self.postPictureArray = [[NSArray alloc] init];
    self.PostDetailsHeight = [[NSMutableArray alloc] init];
    NSString *post = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"content"]];
    CGSize size = CGSizeMake(CYScreanW * 0.94, CGFLOAT_MAX);
    NSLog(@"post = %@",post);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:[CYSmallTools textEditing:post.length > 0 ? post : @""]];
    //图片信息
    NSString *pictureString = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"imgAddress"]];
    if ([pictureString isEqual:[NSNull null]]||[pictureString isEqualToString:@"<null>"]) {

        
    }else
    {
        self.postPictureArray = [pictureString componentsSeparatedByString:@","];

    }
    NSLog(@"self.postPictureArray = %@",self.postPictureArray);
    NSInteger number = 0;
    for (NSString *content in self.postPictureArray)
    {
        NSLog(@"content = %@,content.length = %d",content,content.length);
        
        if (content.length > 6)
        {
            number += 1;
        }
    }
    if (pictureString.length <= 6)
    {
        
        
        self.postHeight = layout.textBoundingSize.height + (CXCScreanH - 64) * 0.01;
    }
    else if (number >= 1 && number <= 3)
    {
        self.postHeight = layout.textBoundingSize.height + (CXCScreanH - 64) * 0.26;
    }
    else
        self.postHeight = layout.textBoundingSize.height + (CXCScreanH - 64) * 0.5;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    if(self.backView)
    {
        self.backView.hidden =NO;

    }

}
- (void) viewWillDisappear:(BOOL)animated
{
//    [self.backView removeFromSuperview];
    self.backView.hidden =YES;
    [_inputMessageTextView resignFirstResponder];
}
- (void) viewDidDisappear:(BOOL)animated
{
//        [self.backView removeFromSuperview];
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputMessageTextView resignFirstResponder];
}
//初始化控件
- (void) initPostController
{
    //显示
    self.PostDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH-64-(CXCScreanH - 64) * 0.1)];
    self.PostDetailsTableView.delegate = self;
    self.PostDetailsTableView.dataSource = self;
    self.PostDetailsTableView.showsVerticalScrollIndicator = NO;
    self.PostDetailsTableView.backgroundColor = [UIColor whiteColor];
    self.PostDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.PostDetailsTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self TextFiledView];
    
   }
- (void)TextFiledView
{ //背景
    self.backView = [[UIView alloc] initWithFrame:CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64, CYScreanW, (CXCScreanH - 64) * 0.1)];
    self.backView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    [self.navigationController.view addSubview:self.backView];
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(28*CXCWidth,((CXCScreanH - 64) * 0.1-40*CXCWidth )/2, 40*CXCWidth, 40*CXCWidth)];
    [imgV setImage:[UIImage imageNamed:@"icon_pencil"]];
    [_backView addSubview:imgV];

    //输入框
    _inputMessageTextView = [[UITextView alloc] initWithFrame:CGRectMake( imgV.right+30*CXCWidth, (CXCScreanH - 64) * 0.02, CYScreanW * 0.64, (CXCScreanH - 64) * 0.06)];
    _inputMessageTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    _inputMessageTextView.layer.borderWidth = 1;
    _inputMessageTextView.layer.cornerRadius = 5;
    _inputMessageTextView.delegate = self;
    _inputMessageTextView.textColor = [UIColor blackColor];
    _inputMessageTextView.font = [UIFont fontWithName:@"Arial" size:17];
    [self.backView addSubview:_inputMessageTextView];
    //发送按钮
    CGSize sizeT = [@"发送" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    CGSize sizeI = [UIImage imageNamed:@"Paper_plane"].size;
    self.sendButtonInfor = [[UIButton alloc] initWithFrame:CGRectMake( _inputMessageTextView.right+30*CXCWidth, (CXCScreanH - 64) * 0.02, CYScreanW * 0.15, (CXCScreanH - 64) * 0.06)];
    self.sendButtonInfor.backgroundColor = [UIColor clearColor];
    [self.sendButtonInfor addTarget:self action:@selector(followPostRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.sendButtonInfor setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButtonInfor.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];

    _sendButtonInfor.backgroundColor =NavColor;
    
        [self.backView addSubview:self.sendButtonInfor];


}
//发送按钮
- (void) sendButton
{
    if (self.inputMessageTextView.text.length > 0)
    {
        NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
        NSString *headUrl;
        NSString *name;
        if ([[dictT objectForKey:@"success"] integerValue] == 1)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
            headUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgAddress"]];
            name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]];
        }
        else
        {
            dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
            headUrl = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"imgAddress"]];
            name = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"nickName"]];
        }
        //记录评论高度
        CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageTextView.text.length > 0 ? self.inputMessageTextView.text : @""]];
        [self.PostDetailsHeight addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
        
        //发送
//        [self.PostDetailsModelarray addObject:[self dataTurnModel:name withPost:self.inputMessageTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl]];
        
        
        [self.PostDetailsModelarray insertObject:[self dataTurnModel:name withPost:self.inputMessageTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl] atIndex:0];
 
        [self.PostDetailsTableView reloadData];
        //把最后一行滚动到最上面
        
//        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.ActivityAModelArray.count - 1 inSection:0];
//        NSLog(@"lastIndexPath = %@,self.ActivityAModelArray.count = %ld",lastIndexPath,self.ActivityAModelArray.count);
//        [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//
//        
//        
//        
        
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.PostDetailsTableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        self.inputMessageTextView.text = nil;
        //放弃第一响应身份
        [self.inputMessageTextView resignFirstResponder];
        //设置frame
        self.backView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64, CYScreanW, (CXCScreanH - 64) * 0.1);
                //改变评论数量
        [self.CommentButton setTitle:[NSString stringWithFormat:@"%d",[self.CommentButton.titleLabel.text integerValue] + 1] forState:UIControlStateNormal];
    }
    else
        [MBProgressHUD showError:@"评论不可为空" ToView:self.view];
}
//  - - - - -- - - -- - - - -- - - - - - - - - - - - textview代理 - - - - - - - -- - - - -- - - -- - - - - -- - - -
//内容将要发生改变编辑,编辑完使用return退出
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView
{
    [self setSendButtonAndTextView];
}
//根据输入设置文本框和发送按钮
- (void) setSendButtonAndTextView
{
    CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageTextView.text.length > 0 ? self.inputMessageTextView.text : @""]];
    if (layout.textBoundingSize.height > (CXCScreanH - 64) * 0.06 && layout.textBoundingSize.height < (CXCScreanH - 64) * 0.3)
    {
        self.backView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64 - self.keyBoardHeight, CYScreanW, (CXCScreanH - 64) * 0.1);
//        self.inputMessageTextView.frame = CGRectMake( CYScreanW * 0.05, (CXCScreanH - 64) * 0.02, CYScreanW * 0.8, layout.textBoundingSize.height);
//        self.sendButtonInfor.frame = CGRectMake( CYScreanW * 0.85, (layout.textBoundingSize.height - (CXCScreanH - 64) * 0.02) / 2, CYScreanW * 0.15, (CXCScreanH - 64) * 0.06);
    }
    else
    {
        self.backView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64 - self.keyBoardHeight, CYScreanW, (CXCScreanH - 64) * 0.1);
//        self.inputMessageTextView.frame = CGRectMake( CYScreanW * 0.05, (CXCScreanH - 64) * 0.02, CYScreanW * 0.8, (CXCScreanH - 64) * 0.06);
//        self.sendButtonInfor.frame = CGRectMake( CYScreanW * 0.85, (CXCScreanH - 64) * 0.02, CYScreanW * 0.15, (CXCScreanH - 64) * 0.06);
    }
}
//增加监听，当键盘出现或改变时收出消息
- (void) setNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//自定义键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
//    int width = keyboardRect.size.width;
    if (self.PostDetailsModelarray.count >= 2)
    {
        self.view.frame = CGRectMake(0.0f, -self.keyBoardHeight + 64, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.backView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64 - self.keyBoardHeight, CYScreanW, (CXCScreanH - 64) * 0.1);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.PostDetailsModelarray.count >= 2)
    {
        self.view.frame = CGRectMake( 0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.backView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64, CYScreanW, (CXCScreanH - 64) * 0.1);
}
//点赞
- (void) thumbUpClick:(UIButton *)sender
{
    [self BBSThumbRequest];

}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
            return (CXCScreanH - 64) * 0.17+self.postHeight+CYScreanW*0.12;
        
    }
    else

    {
        return ((CXCScreanH - 64) * 0.15 + [self.PostDetailsHeight[indexPath.row] floatValue]);
    }
    
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
        return self.PostDetailsModelarray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        time_i =time_i+1;
        static NSString *ID = @"cellPPCId";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        bgview= [[UIView alloc]init];
        //bgview.backgroundColor = [UIColor redColor];
        [cell addSubview:bgview];
        NSString *accountDoString = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"accountDO"]];
        NSString *head = DefaultHeadImage;
        NSString *name = @"未获取";
        if (accountDoString.length > 6)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[self.BBSDetailsDict objectForKey:@"accountDO"]];
            head = [CYSmallTools isValidUrl:[dict objectForKey:@"imgAddress"]] ? [dict objectForKey:@"imgAddress"] : DefaultHeadImage;
            name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]];
        }
        
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.03, (CXCScreanH - 64) * 0.02, CYScreanW * 0.12,  CYScreanW * 0.12)];
        [headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:nil];
        [bgview addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = name;
        nameLabel.textColor = [UIColor colorWithRed:0.282 green:0.282 blue:0.282 alpha:1.00];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [bgview addSubview:nameLabel];
        nameLabel.frame =CGRectMake((headImage.right)+(CYScreanW * 0.02), ((CXCScreanH - 64) * 0.02), (CYScreanW * 0.5), ((CXCScreanH - 64) * 0.04));
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = [NSString stringWithFormat:@"%@",[CYSmallTools timeWithTimeIntervalString:[self.BBSDetailsDict objectForKey:@"gmtCreate"]]];
        timeLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:11];
        [bgview addSubview:timeLabel];
        timeLabel.frame =CGRectMake(headImage.right, nameLabel.bottom, (CYScreanW * 0.5), ((CXCScreanH - 64) * 0.04));
        //来自
        postLabel = [[UILabel alloc] init];
        postLabel.text = [NSString stringWithFormat:@"来自%@",[self.BBSDetailsDict objectForKey:@"communityName"]];
        postLabel.textAlignment = NSTextAlignmentRight;
        postLabel.textColor = [UIColor colorWithRed:0.431 green:0.627 blue:0.941 alpha:1.00];
        postLabel.font = [UIFont systemFontOfSize:11];
        [bgview addSubview:postLabel];
        postLabel.frame =CGRectMake((CYScreanW * 0.48), (nameLabel.bottom), (CYScreanW * 0.5), ((CXCScreanH - 64) * 0.04));
        
        NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:postLabel.text];
        [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.651 green:0.651 blue:0.651 alpha:1.00] range:NSMakeRange(0,2)];
        //        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0,2)];
        postLabel.attributedText = sendMessageString;
            if (SeeImageObjArray) {
                
            }else
            {
                [ProgressHUD show:@"加载中"];

            }

        dispatch_async(dispatch_get_main_queue(), ^{

            [self timeRun];
        });
        }
        return cell;

            }
    
    
    else
    {
        static NSString *ID = @"bbsCellId";
        self.postCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.postCell == nil)
        {
            self.postCell = [[PostDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.PostDetailsModelarray[indexPath.row]);
        self.postCell.model = self.PostDetailsModelarray[indexPath.row];
        self.postCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.postCell;
    }
    
}
- (void)run
{

}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //放弃第一响应身份
    [self.inputMessageTextView resignFirstResponder];
}
//图片缩放
- (CGSize)imageCompressWithSimple:(UIImage*)image scale:(float)scale
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    size.width = width * scale;
    size.height = height * scale;
    return size;
}
//获取帖子评论列表
- (void) getPostDetailsRequest:(NSString *)postId
{
//    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",postId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/followNoteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
//         [MBProgressHUD hideHUDForView:self.view];
         
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"评论请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         NSArray *array = [JSON objectForKey:@"returnValue"];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [self initPostModel:array];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
//         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
//发表评论
- (void) followPostRequest
{
    [_inputMessageTextView resignFirstResponder  ];
    //发送内容不为空
    if (_inputMessageTextView.text.length > 0)
    {
        [MBProgressHUD showLoadToView:self.view];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"id"]];
        parames[@"content"]  =  [NSString stringWithFormat:@"%@",self.inputMessageTextView.text];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/followNote",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             NSArray *array = [JSON objectForKey:@"returnValue"];
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [self sendButton];
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
        [MBProgressHUD showError:@"评论为空" ToView:self.view];
}
//获取评论详情及点赞
- (void) BBSThumbRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/praiseNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"点赞请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%ld",[self.thumbUpButton.titleLabel.text integerValue] + 1]  forState:UIControlStateNormal];
             self.thumbUpButton.selected = YES;
             self.thumbUpButton.userInteractionEnabled = NO;
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"点赞请求失败:%@", error.description);
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (int)countTheStrLength:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

- (void)timeRun
{
    //帖子内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = [UIColor colorWithRed:0.282 green:0.282 blue:0.282 alpha:1.00];
    NSString *content = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"content"]];
    if (![content isEqualToString:@"<null>"])
    {
        contentLabel.text = [NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"content"]];
    }
    contentLabel.font = [UIFont fontWithName:@"Arial" size:14];
    //postLabel.font = font;
    contentLabel.numberOfLines = 0;
    [contentLabel sizeToFit];
    [bgview addSubview:contentLabel];
    CGSize size = CGSizeMake(CYScreanW * 0.9, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:[CYSmallTools textEditing:content.length > 0 ? content : @""]];
    contentLabel.frame =CGRectMake((CYScreanW * 0.03), postLabel.bottom+CYScreanW*0.01, CYScreanW*0.94, layout.textBoundingSize.height+20);
    if (SeeImageObjArray) {//若不是第一次
        //显示图片
        [ProgressHUD dismiss];

        for (NSInteger i = 0; i < SeeImageObjArray.count; i ++)
        {
            SeeImageObj *z = SeeImageObjArray[i];
            SeeImagesView *_Img = [[SeeImagesView alloc]initWithFrame:CGRectMake(CYScreanW * 0.03 + (i % 3) * CYScreanW * 0.94 / 3,contentLabel.bottom + (i > 2 ? (CXCScreanH - 64) * 0.22 : (CXCScreanH - 64) * 0.01), CYScreanW * 0.3, (CXCScreanH - 64) * 0.2)];
            _Img.layer.cornerRadius = 5;
            _Img.userInteractionEnabled = YES;
            _Img.clipsToBounds = YES;
            [_Img setObj:z ImageArray:SeeImageObjArray];
            _Img.isOpen = YES;
            [bgview addSubview:_Img];
        }

    }else
    {
    //处理数据
    SeeImageObjArray = [[NSMutableArray alloc] init];
    
    
    for (NSInteger i = 0; i < self.postPictureArray.count; i ++)
    {
        
        SeeImageObj *z = [[SeeImageObj alloc]init];
        z.name = [NSString stringWithFormat:@"%@",self.postPictureArray[i]];
        
        NSData *_decodedImageData   = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:z.name]];
        z.image = [UIImage imageWithData:_decodedImageData];
        
        if ([UIScreen mainScreen].bounds.size.height == 480) {
            
            UIImage *image = [[UIImage alloc] init];
            NSData *_decodedImageData   = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:z.name]];
            image = [UIImage imageWithData:_decodedImageData];
            //如果图片过大需要缩放:非必须
            NSLog(@"前image.size.width = %f,image.size.height = %f",image.size.width,image.size.height);
            CGSize size;
            if (image.size.width > CYScreanW)
            {
                //                        size = [self imageCompressWithSimple:image scale:(CYScreanW / image.size.width)];
            }
            else
                size = image.size;
            NSLog(@"后image.size.width = %f,image.size.height = %f",image.size.width,image.size.height);
            z.whidth = [NSString stringWithFormat:@"%f",size.width];
            z.height = [NSString stringWithFormat:@"%f",size.height];
        }
        
        z.imgTitle = @"";
        z.imgContent = @"";
        [SeeImageObjArray addObject:z];
    }
    //显示图片
    for (NSInteger i = 0; i < SeeImageObjArray.count; i ++)
    {
        SeeImageObj *z = SeeImageObjArray[i];
        SeeImagesView *_Img = [[SeeImagesView alloc]initWithFrame:CGRectMake(CYScreanW * 0.03 + (i % 3) * CYScreanW * 0.94 / 3,contentLabel.bottom + (i > 2 ? (CXCScreanH - 64) * 0.22 : (CXCScreanH - 64) * 0.01), CYScreanW * 0.3, (CXCScreanH - 64) * 0.2)];
        _Img.layer.cornerRadius = 0;
        _Img.userInteractionEnabled = YES;
        _Img.clipsToBounds = YES;
        [_Img setObj:z ImageArray:SeeImageObjArray];
        _Img.isOpen = YES;
        [bgview addSubview:_Img];
    }
    }
    
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    // segmentationImmage.backgroundColor = BGColor;
    [bgview addSubview:segmentationImmage];
    
    float highPic ;
    if (SeeImageObjArray.count>3) {
        highPic =(CXCScreanH - 64)*0.22*2;
    }else if(SeeImageObjArray.count<4&&SeeImageObjArray.count>0)
    {
        highPic=(CXCScreanH - 64) * 0.22;
        
        
    }else
    {
        highPic =0;
        
    }
    segmentationImmage.frame =CGRectMake(0,highPic+contentLabel.bottom , CYScreanW, 1);
    
    //点赞
    self.thumbUpButton = [[CYEmitterButton alloc] init];
    self.thumbUpButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"praiseCount"]] forState:UIControlStateNormal];
    [self.thumbUpButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
    [self.thumbUpButton setImage:[UIImage imageNamed:@"icon_zan"] forState:UIControlStateNormal];
    [self.thumbUpButton setImage:[UIImage imageNamed:@"icon_zan_done"] forState:UIControlStateSelected];
    self.thumbUpButton.imageEdgeInsets = UIEdgeInsetsMake(10*CXCWidth,10*CXCWidth , 10*CXCWidth, 20*CXCWidth);
    self.thumbUpButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [self.thumbUpButton addTarget:self action:@selector(thumbUpClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:self.thumbUpButton];
    _thumbUpButton.frame =CGRectMake((CYScreanW * 0.8), segmentationImmage.bottom+((CXCScreanH - 64) * 0.03),90*CXCWidth , 60*CXCWidth);
//    _thumbUpButton.backgroundColor =[UIColor redColor];
    self.thumbUpButton.selected = NO;
    
    //查看次数
    UIButton *toViewButton = [[UIButton alloc] init];
    toViewButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [toViewButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"viewCount"]] forState:UIControlStateNormal];
    [toViewButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
    [toViewButton setImage:[UIImage imageNamed:@"icon_view"] forState:UIControlStateNormal];
    toViewButton.imageEdgeInsets = UIEdgeInsetsMake(10*CXCWidth,10*CXCWidth , 10*CXCWidth, 70*CXCWidth);
    toViewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [bgview addSubview:toViewButton];
//    toViewButton.backgroundColor =[UIColor greenColor ];
    
    toViewButton.frame =CGRectMake(0.4*CYScreanW, segmentationImmage.bottom+((CXCScreanH - 64) * 0.03),140*CXCWidth , 60*CXCWidth);
    self.toViewButton = toViewButton;
    
    
    
    //评论
    UIButton *btnLeft = [[UIButton alloc] init ];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setTitle:[NSString stringWithFormat:@"全部评论(%@)",[self.BBSDetailsDict objectForKey:@"replyCount"]] forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"2icon_comments"] forState:UIControlStateNormal];
    btnLeft.imageEdgeInsets = UIEdgeInsetsMake(15*CXCWidth,10*CXCWidth , 10*CXCWidth, 70*CXCWidth);
//    [btnLeft setBackgroundColor:[UIColor yellowColor]];
    btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    
    btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bgview   addSubview:btnLeft];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:13];
    btnLeft.frame =CGRectMake(30*CXCWidth, segmentationImmage.bottom+((CXCScreanH - 64) * 0.03),120*CXCWidth , 60*CXCWidth);
    
    self.CommentButton = btnLeft;
    
    [self.toViewButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"viewCount"]] forState:UIControlStateNormal];
    [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"praiseCount"]] forState:UIControlStateNormal];
    [self.CommentButton setTitle:[NSString stringWithFormat:@"%@",[self.BBSDetailsDict objectForKey:@"replyCount"]] forState:UIControlStateNormal];
    
    //分割线
    UIImageView *segmentationImmage2 = [[UIImageView alloc] init];
    segmentationImmage2.backgroundColor = BGColor;
    [bgview addSubview:segmentationImmage2];
    segmentationImmage2.frame =CGRectMake(0,_CommentButton.bottom+((CXCScreanH - 64) * 0.03) , CYScreanW, 1);
    bgview.frame =CGRectMake(0, 0, CYScreanW,segmentationImmage2.bottom);
    [ProgressHUD dismiss];
    


}
@end
