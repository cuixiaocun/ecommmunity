//
//  CZExhibitionDetailsController.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CZExhibitionDetailsController.h"


@interface CZExhibitionDetailsController ()






@end

@implementation CZExhibitionDetailsController

- (CZExhibitionDetailsSelectView *)detailsSelectView
{
    if (!_detailsSelectView) {
        _detailsSelectView = [[CZExhibitionDetailsSelectView alloc] initWithFrame:CGRectMake(0, 200, CYScreanW, 40)];
        [_detailsSelectView setTitleWithOne:@"展览详情" andTwo:@"展览评论"];
    }
    return _detailsSelectView;
}


- (instancetype)initWithID:(CZExhibitionModel *)model andType:(DetailsExhibitionType)type
{
    if (self = [super init]) {
        self.model = model;
        self.type = type;
        self.isComments = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initExhibitionDetailsController];
    [self setADNotification];
    [self setExhibitionPStyle];
    [self initData];
    
    __weak typeof(self)weakSelf = self;
    self.detailsSelectView.detailsSelectIndex = ^(UIButton *seleButton,NSInteger index){
        [weakSelf.inputMessageADTextView resignFirstResponder];//收键盘
        weakSelf.isComments = index == 2?YES:NO;
        [weakSelf.tableView reloadData];
    };
    
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    [self.backADView removeFromSuperview];
}

//初始化导航栏
- (void) setExhibitionPStyle
{
    self.view.backgroundColor                         = [UIColor whiteColor];
    self.title                                        = self.type == DetailsTypeOilPainting?@"油画展览":@"装潢展览";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share"] style:UIBarButtonItemStyleDone target:self action:@selector(navShare)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    //数据源
    self.ActivityAModelArray = [[NSMutableArray alloc] init];
    self.ActivityHeightArray = [[NSMutableArray alloc] init];
}

- (void)initExhibitionDetailsController
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64 - (CYScreanH - 64) * 0.1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    //背景
    self.backADView = [[UIView alloc] initWithFrame:CGRectMake( 0, CYScreanH - (CYScreanH - 64) * 0.1, CYScreanW, (CYScreanH - 64) * 0.1)];
    self.backADView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    [self.navigationController.view addSubview:self.backADView];

    //输入框
    self.inputMessageADTextView = [[UITextView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, (CYScreanH - 64) * 0.06)];
    self.inputMessageADTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.inputMessageADTextView.layer.borderWidth = 1;
    self.inputMessageADTextView.layer.cornerRadius = 5;
    self.inputMessageADTextView.delegate = self;
    self.inputMessageADTextView.textColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00];
    self.inputMessageADTextView.font = [UIFont fontWithName:@"Arial" size:17];
    [self.backADView addSubview:self.inputMessageADTextView];
    //发送按钮
    CGSize sizeT = [@"发送" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    CGSize sizeI = [UIImage imageNamed:@"Paper_plane"].size;
    self.sendButtonADInfor = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.85, (CYScreanH - 64) * 0.02, CYScreanW * 0.15, (CYScreanH - 64) * 0.06)];
    self.sendButtonADInfor.backgroundColor = [UIColor clearColor];
    [self.sendButtonADInfor addTarget:self action:@selector(sendOilButton) forControlEvents:UIControlEventTouchUpInside];
    [self.sendButtonADInfor setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButtonADInfor.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [self.sendButtonADInfor setTitleColor:[UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00] forState:UIControlStateNormal];
    [self.sendButtonADInfor setImage:[UIImage imageNamed:@"Paper_plane"] forState:UIControlStateNormal];
    self.sendButtonADInfor.imageEdgeInsets = UIEdgeInsetsMake( 0, sizeT.width / 2, (CYScreanH - 64) * 0.03, -sizeT.width / 2);
    self.sendButtonADInfor.titleEdgeInsets = UIEdgeInsetsMake( (CYScreanH - 64) * 0.03, -sizeI.width / 2, 0, sizeI.width / 2);
    [self.backADView addSubview:self.sendButtonADInfor];
}

//获取评价列表
- (void)initData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    [parames setObject:self.model.modelID forKey:@"id"];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/exhibition/replyList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [MBProgressHUD showLoadToView:self.view];
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"评价列表请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             for (NSDictionary *dict  in array) {
                 
                 NSString *accountDoString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"accountDO"]];
                 NSString *content = [NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]];
                 CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
                 YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:content.length > 0 ? content : @"未获取"]];
                 [self.ActivityHeightArray addObject:[NSString stringWithFormat:@"%f",layout.textBoundingSize.height]];
                 if (accountDoString.length > 6)
                 {
                     NSDictionary *dictDo = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"accountDO"]];
                     [self.ActivityAModelArray addObject:[self dataTurnADModel:[NSString stringWithFormat:@"%@",[dictDo objectForKey:@"nickName"]] withPost:[NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]] withTime:[NSString stringWithFormat:@"%@",[dict objectForKey:@"gmtCreate"]] withHead:[NSString stringWithFormat:@"%@",[dictDo objectForKey:@"imgAddress"]]]];
                 }
                 else
                 {
                     [self.ActivityAModelArray addObject:[self dataTurnADModel:@"未获取" withPost:content withTime:[NSString stringWithFormat:@"%@",[dict objectForKey:@"gmtCreate"]] withHead:DefaultHeadImage]];
                 }
                 
             }
             [self.tableView reloadData];
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}

//导航栏分享事件
- (void)navShare
{
    //没有安装QQ //没有安装微信
    if (![QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled])
    {
        [MBProgressHUD showError:@"尚未安装QQ或微信" ToView:self.view];
    }
    else
    {
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            NSLog(@"userInfo = %@",userInfo);
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareTextToPlatformType:platformType];
        }];
    }
}
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    UMShareWebpageObject *object = [UMShareWebpageObject shareObjectWithTitle:@"璟智生活" descr:[NSString stringWithFormat:@"%@",self.model.name] thumImage:[UIImage imageNamed:@"icon_1024"]];//
    object.webpageUrl = [NSString stringWithFormat:@"%@/api/exhibition/shareExhibition?=%@",POSTREQUESTURL,self.model.modelID];
    NSLog(@"object.webpageUrl= %@,self.model.name = %@",object.webpageUrl,self.model.name);
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObjectWithMediaObject:object];
    //设置文本
    //    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
#pragma mark 发送按钮
- (void)sendOilButton
{
    if (self.inputMessageADTextView.text.length > 0)
    {
        //数据请求
        [self sendCommentRequest];
        
        //设置蓝色条
        if (self.detailsSelectView.defaultSelect == YES)
        {
            self.detailsSelectView.defaultSelect = NO;
            [self.detailsSelectView changeBlueView];
        }
        //取出本地（自己）数据
        NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
        NSString *headUrl;
        NSString *name;
        NSLog(@"dictT = %@",dictT);
        
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
        CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageADTextView.text.length > 0 ? self.inputMessageADTextView.text : @"未获取"]];
        [self.ActivityHeightArray addObject:[NSString stringWithFormat:@"%f",layout.textBoundingSize.height]];
//        [self.ActivityAModelArray addObject:[self dataTurnADModel:name withPost:self.inputMessageADTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl]];
        [self.ActivityAModelArray insertObject:[self dataTurnADModel:name withPost:self.inputMessageADTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl] atIndex:0];
   
        self.isComments = YES;//设置标识
        [self.tableView reloadData];//刷新
        //把最后一行滚动到最上面
//        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.ActivityAModelArray.count - 1 inSection:0];
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

        NSLog(@"lastIndexPath = %@,self.ActivityAModelArray.count = %ld",lastIndexPath,self.ActivityAModelArray.count);
        [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //放弃第一响应身份
        self.inputMessageADTextView.text = @"";
        [self.inputMessageADTextView resignFirstResponder];
    }
    else
        [MBProgressHUD showError:@"评论不可为空" ToView:self.view];
}
//数据转模型
- (PostDetailsModel *) dataTurnADModel:(NSString *)name withPost:(NSString *)post withTime:(NSString *)time withHead:(NSString *)head
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
//发送评论
- (void) sendCommentRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"exhId"]     =  self.model.modelID;
    parames[@"content"]   =  [NSString stringWithFormat:@"%@",self.inputMessageADTextView.text];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/exhibition/replyEx",POSTREQUESTURL];
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
             
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:[NSString stringWithFormat:@"请求失败:%@",error.description] ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isComments == YES)
    {
        return ((CYScreanH - 64) * 0.15 + [self.ActivityHeightArray[indexPath.row] floatValue]);
        return (CYScreanH - 64) * 0.24;
    }
    else
    {
        return self.HtmlHeight;
    }
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
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageADTextView.text.length > 0 ? self.inputMessageADTextView.text : @""]];
    if (layout.textBoundingSize.height > (CYScreanH - 64) * 0.06 && layout.textBoundingSize.height < (CYScreanH - 64) * 0.3)
    {
        self.backADView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.96 + 64 - self.keyADBoardHeight - layout.textBoundingSize.height, CYScreanW, (CYScreanH - 64) * 0.04 + layout.textBoundingSize.height);
        self.inputMessageADTextView.frame = CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, layout.textBoundingSize.height);
        self.sendButtonADInfor.frame = CGRectMake( CYScreanW * 0.85, (layout.textBoundingSize.height - (CYScreanH - 64) * 0.02) / 2, CYScreanW * 0.15, (CYScreanH - 64) * 0.06);
    }
    else
    {
        self.backADView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.9 + 64 - self.keyADBoardHeight, CYScreanW, (CYScreanH - 64) * 0.1);
        self.inputMessageADTextView.frame = CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.02, CYScreanW * 0.8, (CYScreanH - 64) * 0.06);
        self.sendButtonADInfor.frame = CGRectMake( CYScreanW * 0.85, (CYScreanH - 64) * 0.02, CYScreanW * 0.15, (CYScreanH - 64) * 0.06);
    }
}
//增加监听，当键盘出现或改变时收出消息
- (void) setADNotification
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
    self.keyADBoardHeight = keyboardRect.size.height;
    int width = keyboardRect.size.width;
    //    self.view.frame = CGRectMake(0.0f, - self.keyADBoardHeight + 64, CYScreanW, CYScreanH - (CYScreanH - 64) * 0.1);
    self.backADView.frame = CGRectMake( 0, CYScreanH - (CYScreanH - 64) * 0.1 - self.keyADBoardHeight, CYScreanW, (CYScreanH - 64) * 0.1);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.backADView.frame = CGRectMake( 0, CYScreanH - (CYScreanH - 64) * 0.1, CYScreanW, (CYScreanH - 64) * 0.1);
}




#pragma mark UITableviewDelegate && UITableviewDateSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight;

        sectionHeaderHeight = 200;
    
    if (scrollView == self.tableView) {
        //去掉UItableview的section的headerview黏性
        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 240;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, 240)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    CZExhibitionDetailsTopView *topView = [[CZExhibitionDetailsTopView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, 200)];
    
    [backgroundView addSubview:topView];
    [backgroundView addSubview:self.detailsSelectView];
    
    [topView setExhibitionDetailsTopView:self.model.imageUrl andName:self.model.name andAccount:self.model.account andDate:self.model.date andState:self.model.state andType:self.type == DetailsTypeOilPainting ? @"0" : @"1"];
    
    //添加单击手势防范
    UITapGestureRecognizer *postingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closedXKeyBoardTap:)];
    postingTap.numberOfTapsRequired = 1;
    [topView addGestureRecognizer:postingTap];
    return backgroundView;
}
//收键盘
-(void) closedXKeyBoardTap:(UITapGestureRecognizer *)sender
{
    [self.inputMessageADTextView resignFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isComments == YES) {
        NSLog(@"self.ActivityAModelArray = %ld",self.ActivityAModelArray.count);
        return self.ActivityAModelArray.count;
    }else{
        
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isComments == YES)
    {
        static NSString *ID = @"AcDeCellId";
        self.AcDeCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.AcDeCell == nil)
        {
            self.AcDeCell = [[PostDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.AcDeCell.model = self.ActivityAModelArray[indexPath.row];
        self.AcDeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.AcDeCell;
    }
    else
    {
        static NSString *ID = @"actiCellIdThree";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"self.model.imageUrl = %@,self.model.flag = %@,self.model.content = %@",self.model.imageUrl,self.model.flag,self.model.content);
//        NSString *htmlString = @"<p><span>范德萨发撒的发的说法是大丰收的发生</span></p><p><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/20160727184805.jpg\" width=\"100\" height=\"100\" alt=\"\" /></p><p><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/QQ%E5%9B%BE%E7%89%8720161029180006.png\" width=\"100\" height=\"100\" alt=\"\" /></p><p><hr /><hr /><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/helloWorld\" width=\"100\" height=\"100\" alt=\"\" /></p><p><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/20160727184805.jpg\" width=\"200\" height=\"300\" alt=\"\" /></p>";
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 0)];
        self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        self.webView.delegate = self;
        self.webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
        self.webView.scrollView.bounces = NO;//防止滑动页面使UIWebView也滑动
        [self.webView loadHTMLString:self.model.content baseURL:nil];
        [cell.contentView addSubview:self.webView];
        return cell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.inputMessageADTextView resignFirstResponder];
}
// ---- -- - - -- - - --- - - -- - - -- - -- - - -- - - -- - - - -- -webview使用- - -- - - - - - - - - - - -- - - --- - - - - - --  -- -
//自定义通知，点击webview之后对使用页面发送通知

#pragma mark - UIWebViewDelegate实现
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    frame = webView.frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    webView.frame = frame;
    if (frame.size.height > self.HtmlHeight)
    {
        self.HtmlHeight = frame.size.height;
        //刷新某一组
        [self.tableView reloadData];
    }
    
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载出错***********error:%@,errorcode=%ld,errormessage:%@",error.domain,(long)error.code,error.description);
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
