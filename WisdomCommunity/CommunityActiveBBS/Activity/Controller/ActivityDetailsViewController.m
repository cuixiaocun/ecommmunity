//
//  ActivityDetailsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityDetailsViewController.h"
#import "ActivityDetailsModel.h"
#import "ActivityDetailsTopView.h"
#import "CZExhibitionDetailsSelectView.h"
#import "AKGallery.h"

@interface ActivityDetailsViewController ()
{
    UILabel *navLabel;
    UIImageView *shareImage;
    UIImageView *showImage;
    
    
}
@property ( nonatomic, strong) ActivityDetailsModel          *headModel;
@property ( nonatomic, strong) CZExhibitionDetailsSelectView *detailsSelectView;
@property ( nonatomic, assign) BOOL                          isComments;
@property ( nonatomic, strong) ActivityDetailsTopView        *topView;

@end

@implementation ActivityDetailsViewController
- (CZExhibitionDetailsSelectView *)detailsSelectView
{
    if (!_detailsSelectView) {
        _detailsSelectView = [[CZExhibitionDetailsSelectView alloc] initWithFrame:CGRectMake(0, 750*CXCWidth, CYScreanW, 80*CXCWidth)];
        _detailsSelectView.backgroundColor =[UIColor whiteColor];
        
        [_detailsSelectView setTitleWithOne:@"活动详情" andTwo:@"评论"];
    }
    return _detailsSelectView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //     playCount = 0;参与
    //praiseCount = 0;点赞
    //replyCount = 0;回复
    // viewCount = 3;查看
    
    [self setADNotification];
    [self setAcDetailsModel];
    [self initActivityDetaController];
    [self showSelectButton];
    [self initCommentsReqeust];//获取评论列表
    
    
    __weak typeof(self)weakSelf = self;
    self.detailsSelectView.detailsSelectIndex = ^(UIButton *seleButton,NSInteger index){
        weakSelf.isComments = index == 2?YES:NO;
        [weakSelf.ActivityDetailsTableView reloadData];
        if (index == 1) {
            
        }
        if (index == 2) {
            //按钮
            if (weakSelf.ActivityAModelArray.count)//有评论就会滚动
            {
                [weakSelf.ActivityDetailsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
    };
    self.topView.participateDidClicked = ^(UIButton *sender){
        weakSelf.topView.participateButton.enabled = NO;
        [weakSelf participateRequest];
    };
    //添加单击手势防范
    UITapGestureRecognizer *postingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closedKeyBoardTap:)];
    postingTap.numberOfTapsRequired = 1;
    [self.topView addGestureRecognizer:postingTap];
    
}
//收键盘
-(void) closedKeyBoardTap:(UITapGestureRecognizer *)sender
{
    [self.inputMessageADTextView resignFirstResponder];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [self.backADView setHidden:NO];

}
- (void) viewWillDisappear:(BOOL)animated
{
    
    [self.backADView setHidden:YES];
}
//初始化数据
- (void) setAcDetailsModel
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:self.ActivityIDmodel forKey:@"id"];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/viewActivity",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [MBProgressHUD showLoadToView:self.view];
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"获取详情请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSDictionary *dict = [JSON valueForKey:@"returnValue"];
             self.headModel = [ActivityDetailsModel modelObjectWithDictionary:dict];
             NSLog(@"请求成功");
             [self.topView setTopViewWithModel:self.headModel];
             //如果已经参加则不可 点击/添加
             if ([[dict objectForKey:@"viewAccountJoinStatus"] integerValue] == 1) {
//                 [self.topView.participateButton setTitle:@"已经参与" forState:UIControlStateNormal];
//                 self.topView.participateButton.userInteractionEnabled = NO;
             }
             [self.detailsSelectView setTitleWithOne:@"活动详情" andTwo:[NSString stringWithFormat:@"评论 (%@)",self.headModel.replyCount]];
             [self.ActivityDetailsTableView reloadData];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
    //初始化HTML代码高度
    self.HtmlHeight = (CXCScreanH - 64) * 0.47;
    
    
    //初始化数组
    self.ActivityAModelArray = [[NSMutableArray alloc] init];
    self.ActivityAllDataArray = [[NSMutableArray alloc] init];
    self.ActivityAHeight = [[NSMutableArray alloc] init];
}
//获取评论数据
- (void)initCommentsReqeust
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:self.ActivityIDmodel forKey:@"id"];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/activityReplyList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [MBProgressHUD showLoadToView:self.view];
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON valueForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             for (NSDictionary *dict in array)
             {
                 NSString *stringDO = [NSString stringWithFormat:@"%@",[dict objectForKey:@"accountDO"]];
                 
                 NSString *post = [NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]];
                 NSString *content = [NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]];
                 //记录评论高度
                 CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
                 YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:content.length > 0 ? content : @""]];
                 [self.ActivityAHeight addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
                 if (stringDO.length > 6)
                 {
                     NSDictionary *dictDO = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"accountDO"]];
                     [self.ActivityAModelArray addObject:[self dataTurnADModel:[NSString stringWithFormat:@"%@",[dictDO objectForKey:@"nickName"]] withPost:post withTime:[NSString stringWithFormat:@"%@",[dict objectForKey:@"gmtCreate"]] withHead:[NSString stringWithFormat:@"%@",[dictDO objectForKey:@"imgAddress"]]]];
                 }
                 else
                 {
                     [self.ActivityAModelArray addObject:[self dataTurnADModel:@"未获取" withPost:post withTime:@"未获取时间信息" withHead:@""]];
                 } 
             }
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         self.topView.participateButton.enabled = YES;
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
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
//立即参与
- (void)participateRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:self.ActivityIDmodel forKey:@"activityId"];
    
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/play",POSTREQUESTURL];
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
             NSDictionary *dict = [JSON valueForKey:@"returnValue"];
             NSLog(@"请求成功dict = %@",dict);
             [self.topView.participateButton setHidden:YES];
             [MBProgressHUD showSuccess:@"参与成功" ToView:self.view];
             
             self.topView.participateLabel.text = [NSString stringWithFormat:@"%d人参加",[self.topView.participateLabel.text integerValue] + 1];
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
             [self.topView.participateButton setTitle:@"已经参与" forState:UIControlStateNormal];
             self.topView.participateButton.enabled = YES;
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         self.topView.participateButton.enabled = YES;
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];

}
//评论请求
- (void)sendRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:self.ActivityIDmodel forKey:@"activityId"];
    [parames setObject:self.inputMessageADTextView.text forKey:@"content"];
    
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/reply",POSTREQUESTURL];
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
             [self.detailsSelectView setTitleWithOne:@"活动详情" andTwo:[NSString stringWithFormat:@"评论 (%ld)",[self.headModel.replyCount integerValue] + 1]];
             [self visitActivity];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:[NSString stringWithFormat:@"请求失败:%@",error.description] ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
    
}
- (void)visitActivity
{
    //获取个人数据
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
    //获取信息高度
    CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageADTextView.text.length > 0 ? self.inputMessageADTextView.text : @"未获取"]];
    
    //        [self.ActivityAHeight addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
    [self.ActivityAHeight insertObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height] atIndex:0];
    //刷新本地
    //        [self.ActivityAModelArray addObject:[self dataTurnADModel:name withPost:self.inputMessageADTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl]];
    
    
    [self.ActivityAModelArray insertObject:[self dataTurnADModel:name withPost:self.inputMessageADTextView.text withTime:[CYSmallTools getTimeStamp] withHead:headUrl] atIndex:0];
    
    [self.ActivityDetailsTableView reloadData];
    //把最后一行滚动到最上面
    if (self.isComments == YES) {
        
        
        
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.ActivityDetailsTableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.ActivityDetailsTableView reloadData];
        
    }
    self.inputMessageADTextView.text = nil;
    //放弃第一响应身份
    [self.inputMessageADTextView resignFirstResponder];
    //设置frame
    self.backADView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64, CYScreanW, (CXCScreanH - 64) * 0.1);


}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
//初始化控件
- (void) initActivityDetaController
{
    //显示
    self.ActivityDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - (CXCScreanH - 64) * 0.1)];
    self.ActivityDetailsTableView.delegate = self;
    self.ActivityDetailsTableView.dataSource = self;
    self.ActivityDetailsTableView.showsVerticalScrollIndicator = NO;
    self.ActivityDetailsTableView.backgroundColor = [UIColor whiteColor];
    self.ActivityDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ActivityDetailsTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //背景
    self.backADView = [[UIView alloc] initWithFrame:CGRectMake( 0, CXCScreanH - (CXCScreanH - 64) * 0.1, CYScreanW, (CXCScreanH - 64) * 0.1)];
    self.backADView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    [self.navigationController.view addSubview:self.backADView];
//    self.backADView.hidden = YES;
    
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(28*CXCWidth,((CXCScreanH - 64) * 0.1-40*CXCWidth )/2, 40*CXCWidth, 40*CXCWidth)];
    [imgV setImage:[UIImage imageNamed:@"icon_pencil"]];
    [_backADView addSubview:imgV];
    
    //输入框
    self.inputMessageADTextView = [[UITextView alloc] initWithFrame:CGRectMake( imgV.right+30*CXCWidth, (CXCScreanH - 64) * 0.02, CYScreanW * 0.64, (CXCScreanH - 64) * 0.06)];
    self.inputMessageADTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.inputMessageADTextView.layer.borderWidth = 1;
    self.inputMessageADTextView.layer.cornerRadius = 5;
    self.inputMessageADTextView.delegate = self;
    self.inputMessageADTextView.textColor = TEXTColor;
    self.inputMessageADTextView.font = [UIFont fontWithName:@"Arial" size:17];
    [self.backADView addSubview:self.inputMessageADTextView];
    //发送按钮
    CGSize sizeT = [@"发送" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    CGSize sizeI = [UIImage imageNamed:@"Paper_plane"].size;
    self.sendButtonADInfor = [[UIButton alloc] initWithFrame:CGRectMake( _inputMessageADTextView.right+30*CXCWidth, (CXCScreanH - 64) * 0.02, CYScreanW*0.15, (CXCScreanH - 64) * 0.06)];
    self.sendButtonADInfor.backgroundColor = [UIColor clearColor];
    [self.sendButtonADInfor addTarget:self action:@selector(sendButton) forControlEvents:UIControlEventTouchUpInside];
    [self.sendButtonADInfor setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButtonADInfor.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    self.sendButtonADInfor.backgroundColor =NavColor;
    
//    [self.sendButtonADInfor setImage:[UIImage imageNamed:@"Paper_plane"] forState:UIControlStateNormal];
//    self.sendButtonADInfor.imageEdgeInsets = UIEdgeInsetsMake( 0, sizeT.width / 2, (CXCScreanH - 64) * 0.03, -sizeT.width / 2);
//    self.sendButtonADInfor.titleEdgeInsets = UIEdgeInsetsMake( (CXCScreanH - 64) * 0.03, -sizeI.width / 2, 0, sizeI.width / 2);
    [self.backADView addSubview:self.sendButtonADInfor];
    
    
    //控制显示与隐藏
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 64)];

    
    
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.navigationView];
    //左
//    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, 35, 15, 25)];
//    btnLeft.backgroundColor = [UIColor clearColor];
//    [btnLeft setImage:[UIImage imageNamed:@"未标题-1_06"] forState:UIControlStateNormal];
//    [btnLeft addTarget:self action:@selector(backButtonAD) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationView addSubview:btnLeft];
    
    //左
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake( 0, 0, 100, 64)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft addTarget:self action:@selector(backButtonAD) forControlEvents:UIControlEventTouchUpInside];
    //图片
   showImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 33,33)];
    [showImage setImage:[UIImage imageNamed:@"icon_xiang_goBack"]];
    [btnLeft addSubview:showImage];
    [self.navigationView addSubview:btnLeft];
    
    //图片
    UIImageView * showImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 33,33)];
    [showImage2 setImage:[UIImage imageNamed:@"icon_goBack"]];
    [btnLeft addSubview:showImage2];
    
    //右
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW-100, 0, 100, 64)];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    //图片
    shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 25, 33,33)];
    [shareImage setImage:[UIImage imageNamed:@"icon_xiang_share"]];
    [shareBtn addSubview:shareImage];
    [self.navigationView addSubview:shareBtn];
    //图片
    UIImageView *shareImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 25, 33,33)];
    [shareImage2 setImage:[UIImage imageNamed:@"icon_share_white"]];
    [shareBtn addSubview:shareImage2];

    
    
    navLabel =[[UILabel alloc]initWithFrame:CGRectMake(100,20 , CYScreanW-100-100, 44)];
    navLabel.text =@"活动详情";
    navLabel.textAlignment =NSTextAlignmentCenter;
    navLabel.textColor =[UIColor whiteColor];
    navLabel.alpha =0;
    [_navigationView addSubview:navLabel];
    
    
    
    
   }
- (void) showSelectButton
{
    //顶部导航栏
    self.ActivityDeTopView = [[UIView alloc] initWithFrame:CGRectMake( 0, 64, CYScreanW, 80*CXCWidth)];
    self.ActivityDeTopView.backgroundColor = [UIColor whiteColor];
    self.ActivityDeTopView.hidden = YES;
    [self.view addSubview:self.ActivityDeTopView];
    //活动按钮
    self.ActivityDeTopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CYScreanW * 0.5, 79*CXCWidth)];
    self.ActivityDeTopButton.backgroundColor = [UIColor clearColor];
    [self.ActivityDeTopButton setTitle:@"活动详情" forState:UIControlStateNormal];
    [self.ActivityDeTopButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.ActivityDeTopButton setTitleColor:[UIColor colorWithRed:0.463 green:0.467 blue:0.471 alpha:1.00] forState:UIControlStateNormal];
    self.ActivityDeTopButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.ActivityDeTopButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.ActivityDeTopButton addTarget:self action:@selector(selectCODButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.ActivityDeTopView addSubview:self.ActivityDeTopButton];
    self.ActivityDeTopButton.selected = YES;
    //评论按钮
    self.CommentDeTopButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.5, 0, CYScreanW * 0.5, 79*CXCWidth)];
    self.CommentDeTopButton.backgroundColor = [UIColor clearColor];
    [self.CommentDeTopButton setTitle:@"评论(0)" forState:UIControlStateNormal];
    [self.CommentDeTopButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.CommentDeTopButton setTitleColor:[UIColor colorWithRed:0.463 green:0.467 blue:0.471 alpha:1.00] forState:UIControlStateNormal];
    self.CommentDeTopButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.CommentDeTopButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.CommentDeTopButton addTarget:self action:@selector(selectCODButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.ActivityDeTopView addSubview:self.CommentDeTopButton];
    self.CommentDeTopButton.selected = NO;
    //竖线  vertical
    UIImageView *verticalImmage = [[UIImageView alloc] init];
    verticalImmage.backgroundColor = BGColor;
    [self.ActivityDeTopView addSubview:verticalImmage];
    [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.ActivityDeTopButton.mas_right).offset(-0.5);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.ActivityDeTopView.mas_top).offset(0);
         make.height.mas_equalTo((CXCScreanH - 64) * 0.06);
     }];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [self.ActivityDeTopView addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.ActivityDeTopView.mas_left).offset(0);
         make.right.equalTo(self.ActivityDeTopView.mas_right).offset(0);
         make.top.equalTo(self.ActivityDeTopButton.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //移动的横线
    self.CustomTopView = [[UIView alloc] initWithFrame:CGRectMake( 0, (CXCScreanH - 64) * 0.06, CYScreanW * 0.5, 5)];
    self.CustomTopView.backgroundColor = [UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:1.00];
    [self.ActivityDeTopView addSubview:self.CustomTopView];
}
//返回
- (void) backButtonAD
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
- (void) shateButton
{
    //没有安装QQ //没有安装微信
    if (![QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled])
    {
        [MBProgressHUD showError:@"未安装QQ或微信" ToView:self.view];
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
    UMShareWebpageObject *object = [UMShareWebpageObject shareObjectWithTitle:@"云末社区" descr:[NSString stringWithFormat:@"%@",self.headModel.title] thumImage:[UIImage imageNamed:@"icon_1024"]];//
    NSString *url = [NSString stringWithFormat:@"%@/api/activity/shareActivity?=%@",POSTREQUESTURL,self.ActivityIDmodel];
    object.webpageUrl = url;
    NSLog(@"url = %@",url);
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
//发送按钮
- (void) sendButton
{
    [_inputMessageADTextView resignFirstResponder];
    
    //发送内容不为空
    if (self.inputMessageADTextView.text.length > 0)
    {
        //请求
        [self sendRequest];
       //        self.inputMessageADTextView.frame = CGRectMake( CYScreanW * 0.05, (CXCScreanH - 64) * 0.02, CYScreanW * 0.8, (CXCScreanH - 64) * 0.06);
//        self.sendButtonADInfor.frame = CGRectMake( CYScreanW * 0.85, (CXCScreanH - 64) * 0.02, CYScreanW * 0.15, (CXCScreanH - 64) * 0.06);
    }
}
// -- - - - - - - -- - - - - - - - - - - - - - -- - - - - - -- - - - - - - 设置navigationBar -- - - - - - -- - - - - - - -- - - - - - -- - - - - - - -- - - -
//设置导航条为透明色
-(void)setNavigationBarClear
{
    //    给导航条设置一个空的背景图 使其透明化
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = true;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight;
    
    sectionHeaderHeight = 750*CXCWidth-64;
    
    if (scrollView == self.ActivityDetailsTableView) {
        //去掉UItableview的section的headerview黏性
        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    //tableView相对于图片的偏移量
    CGFloat reOffset = scrollView.contentOffset.y + (CXCScreanH - 64) * 0.2;
    //    (kOriginalImageHeight - 64)这个数值决定了导航条在图片上滑时开始出现  alpha 从 0 ~ 0.99 变化
    //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
    CGFloat alpha = reOffset / ((CXCScreanH - 64) * 0.2);
    if (alpha <= 1)//下拉永不显示导航栏
    {
        alpha = 0;
    }
    else//上划前一个导航栏的长度是渐变的
    {
        alpha -= 1;
    }
    // 设置导航条的背景图片 其透明度随  alpha 值 而改变
    [self.navigationView setBackgroundColor:[UIColor colorWithPatternImage:[self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]]]];
    navLabel.alpha =alpha;
    shareImage.alpha =1-alpha;
    showImage.alpha =1-alpha;

    //  = [self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
/// 使用颜色填充图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
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
    //改变按钮颜色
//    if (textView.text.length)
//    {
//        [self.sendButtonADInfor setTitleColor:[UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00] forState:UIControlStateNormal];
//        [self.sendButtonADInfor setImage:[UIImage imageNamed:@"Paper_plane"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [self.sendButtonADInfor setTitleColor:[UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00] forState:UIControlStateNormal];
//        [self.sendButtonADInfor setImage:[UIImage imageNamed:@"Paper_plane"] forState:UIControlStateNormal];
//    }
    [self setSendButtonAndTextView];
}
//根据输入设置文本框和发送按钮
- (void) setSendButtonAndTextView
{
    CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:self.inputMessageADTextView.text.length > 0 ? self.inputMessageADTextView.text : @""]];
    if (layout.textBoundingSize.height > (CXCScreanH - 64) * 0.06 && layout.textBoundingSize.height < (CXCScreanH - 64) * 0.3)
    {
        self.backADView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64 - self.keyADBoardHeight, CYScreanW, (CXCScreanH - 64) * 0.1);
//        self.inputMessageADTextView.frame = CGRectMake( CYScreanW * 0.05, (CXCScreanH - 64) * 0.02, CYScreanW * 0.8, layout.textBoundingSize.height);
//        self.sendButtonADInfor.frame = CGRectMake( CYScreanW * 0.85, (layout.textBoundingSize.height - (CXCScreanH - 64) * 0.02) / 2, CYScreanW * 0.15, (CXCScreanH - 64) * 0.06);
    }
    else
    {
        self.backADView.frame = CGRectMake( 0, (CXCScreanH - 64) * 0.9 + 64 - self.keyADBoardHeight, CYScreanW, (CXCScreanH - 64) * 0.1);
//        self.inputMessageADTextView.frame = CGRectMake( CYScreanW * 0.05, (CXCScreanH - 64) * 0.02, CYScreanW * 0.8, (CXCScreanH - 64) * 0.06);
//        self.sendButtonADInfor.frame = CGRectMake( CYScreanW * 0.85, (CXCScreanH - 64) * 0.02, CYScreanW * 0.15, (CXCScreanH - 64) * 0.06);
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
    self.backADView.frame = CGRectMake( 0, CXCScreanH - (CXCScreanH - 64) * 0.1 - self.keyADBoardHeight, CYScreanW, (CXCScreanH - 64) * 0.1);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
//    self.view.frame = CGRectMake( 0, 0, CYScreanW, CYScreanH - (CYScreanH - 64) * 0.1);
    self.backADView.frame = CGRectMake( 0, CXCScreanH - (CXCScreanH - 64) * 0.1, CYScreanW, (CXCScreanH - 64) * 0.1);
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 830*CXCWidth;
    }
    else
        return 0;
}

- (ActivityDetailsTopView *)topView
{
    if (!_topView) {
        _topView = [[ActivityDetailsTopView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, 750*CXCWidth)];
    }
    return _topView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, 830*CXCWidth)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:self.topView];
    [backgroundView addSubview:self.detailsSelectView];
    
    return backgroundView;
    
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (self.isComments == YES)
        {
            return ((CXCScreanH - 64) * 0.15 + [self.ActivityAHeight[indexPath.row] floatValue]);
        }
        else
        {
            if ([self.headModel.flag isEqualToString:@"1"]) {

              CGSize size =  [self getSizeWithText:self.headModel.content font:[UIFont systemFontOfSize:17.0f]];
                if (self.headModel.imgAddress != nil) {
                    NSMutableArray *imagelist = [NSMutableArray array];
                    NSArray *imageArray = [self.headModel.imgAddress componentsSeparatedByString:@","];
                    for (int i = 0; i<imageArray.count; i++) {
                        if (![imageArray[i] isEqualToString:@""]) {
                            [imagelist addObject:imageArray[i]];
                        }
                    }
                    
                    return size.height + imagelist.count * 480*CXCWidth + 50;
                    
                }
                else
                {
                    NSLog(@"size.height+50 = %f",size.height + 50);
                    return size.height + 50;
                }
                
            }
            else
            {
                NSLog(@"self.HtmlHeight = %f",self.HtmlHeight);
                return self.HtmlHeight;
            }
        }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        if (self.isComments == YES)
        {
            NSLog(@"self.ActivityAModelArray.count = %ld",self.ActivityAModelArray.count);
            return self.ActivityAModelArray.count;
        }
        else
            return 1;

}
//设置cell内容
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
        if ([self.headModel.flag isEqualToString:@"1"]) {
            
            UILabel *contentLabel = [[UILabel alloc] init];
            contentLabel.numberOfLines = 0;
            static NSString *ID = @"actiCellIdContent";
            contentLabel.text = self.headModel.content;
            contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize labelSize = [self getAttributeSizeWithLabel:contentLabel];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(10);
                make.right.equalTo(cell.contentView).offset(-10);
                make.top.equalTo(cell.contentView).offset(20);
                
                make.height.mas_offset(labelSize.height);
            }];
            if (self.headModel.imgAddress != nil)
            {
                self.pictureArray = [NSMutableArray array];
                NSArray *imageArray = [self.headModel.imgAddress componentsSeparatedByString:@","];
                for (int i = 0; i<imageArray.count; i++)
                {
                    if (![imageArray[i] isEqualToString:@""])
                    {
                        [self.pictureArray addObject:imageArray[i]];
                    }
                }
                UIImageView *replace = nil;
                for (NSInteger b = 0 ; b < self.pictureArray.count ; b ++)
                {
                    NSString *imageUrl = self.pictureArray[b];
                    UIImageView *imageView = [[UIImageView alloc] init];
                    imageView.layer.masksToBounds = YES;
//                    imageView.layer.cornerRadius = 10;
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
                    imageView.contentMode =  UIViewContentModeScaleAspectFill;
                    [cell.contentView addSubview:imageView];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(cell.contentView).offset(0);
                        make.right.equalTo(cell.contentView).offset(0);
                        make.height.mas_offset(460*CXCWidth);
                        if (replace == nil) {
                            make.top.equalTo(contentLabel.mas_bottom).offset(10);
                        }else{
                            make.top.equalTo(replace.mas_bottom).offset(10);
                        }
                    }];
                    replace = imageView;
                    //点击手势
                    UIButton *button = [[UIButton alloc] init];
                    button.tag = 300 + b;
                    button.backgroundColor = [UIColor clearColor];
                    [button addTarget:self action:@selector(ClickToAEnlarge:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:button];
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(imageView.mas_left).offset(0);
                        make.right.equalTo(imageView.mas_right).offset(0);
                        make.top.equalTo(imageView.mas_top).offset(0);
                        make.bottom.equalTo(imageView.mas_bottom).offset(0);
                    }];
                }
            }
            return cell;
            
        }else{
            static NSString *ID = @"actiCellIdThree";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            if (self.ShowWebViewHtml == nil)
            //            {
            //                NSString *htmlString = @"<p><span>范德萨发撒的发的说法是大丰收的发生</span></p><p><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/20160727184805.jpg\" width=\"100\" height=\"100\" alt=\"\" /></p><p><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/QQ%E5%9B%BE%E7%89%8720161029180006.png\" width=\"100\" height=\"100\" alt=\"\" /></p><p><hr /><hr /><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/helloWorld\" width=\"100\" height=\"100\" alt=\"\" /></p><p><img src=\"http://7xwtb9.com2.z0.glb.qiniucdn.com/20160727184805.jpg\" width=\"200\" height=\"300\" alt=\"\" /></p>";
            self.ShowWebViewHtml = [[UIWebView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 0)];
            self.ShowWebViewHtml.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            self.ShowWebViewHtml.delegate = self;
            self.ShowWebViewHtml.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
            self.ShowWebViewHtml.scrollView.bounces = NO;//防止滑动页面使UIWebView也滑动
            [self.ShowWebViewHtml loadHTMLString:self.headModel.content baseURL:nil];
            [cell.contentView addSubview:self.ShowWebViewHtml];
            //            }
            
            return cell;
        }
    }
}
//点击手势
-(void) ClickToAEnlarge:(UIButton *)sender
{
    NSLog(@"sender.tag - 300 = %ld",sender.tag - 300);
    NSString *URLString = self.pictureArray[sender.tag - 300];
    //显示图片
    UIImage *image = [[UIImage alloc] init];
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    if (!URLString.length)//获取网络大图
    {
        [MBProgressHUD showError:@"获取失败" ToView:self.view];
        return;
    }
    
    
    NSMutableArray* arr= @[].mutableCopy;
    
    for (int  i = 0; i<self.pictureArray.count; i++) {
        
        AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:nil img:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_pictureArray[i]] ]]];
        
        [arr addObject:item];
    }
    
    AKGallery* gallery = AKGallery.new;
    gallery.items=arr;
    gallery.custUI=AKGalleryCustUI.new;
    gallery.selectIndex=sender.tag - 300;
    gallery.completion=^{
        NSLog(@"completion gallery");
        
    };
    //show gallery
    [self presentAKGallery:gallery animated:YES completion:nil];
    //

    
    
    
    
    
//    
//    NSData *_decodedImageData   = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URLString]];
//    image      = [UIImage imageWithData:_decodedImageData];
//    avatarImageView.image = image;
//    // 获得根窗口
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, CXCScreanH)];
//    oldAframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
//    backgroundView.backgroundColor =[UIColor blackColor];
//    backgroundView.alpha =0.5;
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldAframe];
//    imageView.image = image;
//    imageView.tag = 1;
//    [backgroundView addSubview:imageView];
//    backgroundView.userInteractionEnabled = YES;
//    [window addSubview:backgroundView];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) / 2, [UIScreen mainScreen].bounds.size.width, image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width);
//        backgroundView.alpha = 1;
//    }];
//    //点击图片缩小的手势
//    UITapGestureRecognizer *hideImageDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
//    hideImageDelete.numberOfTapsRequired = 1;
//    [backgroundView addGestureRecognizer:hideImageDelete];
}
//隐藏全屏展示图片
- (void)hideImage:(UITapGestureRecognizer *)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldAframe;
        backgroundView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.inputMessageADTextView resignFirstResponder];
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.inputMessageADTextView resignFirstResponder];
}
//切换按钮
- (void) selectCODButton:(UIButton *)sender
{
    if (sender == self.ActivityDeButton)
    {
        
        self.ActivityDeButton.selected = YES;
        self.ActivityDeTopButton.selected = YES;
        self.commentDeButton.selected = NO;
        self.CommentDeTopButton.selected = NO;
        
        [self MobileAnimation:CYScreanW * 0.25 withHeight:(CXCScreanH - 64) * 0.06];
        [self MobileTopAnimation:CYScreanW * 0.25 withHeight:(CXCScreanH - 64) * 0.06];
        [self.backADView setHidden:YES];

    }
    else if (sender == self.commentDeButton)
    {    [self.backADView setHidden:NO];

        
        self.ActivityDeButton.selected = NO;
        self.ActivityDeTopButton.selected = NO;
        self.commentDeButton.selected = YES;
        self.CommentDeTopButton.selected = YES;
        
        [self MobileAnimation:CYScreanW * 0.75 withHeight:(CXCScreanH - 64) * 0.06];
        [self MobileTopAnimation:CYScreanW * 0.75 withHeight:(CXCScreanH - 64) * 0.06];
    }
    else if (sender == self.ActivityDeTopButton)
    {
        
        self.ActivityDeButton.selected = YES;
        self.ActivityDeTopButton.selected = YES;
        self.commentDeButton.selected = NO;
        self.CommentDeTopButton.selected = NO;
        
        [self MobileAnimation:CYScreanW * 0.25 withHeight:(CXCScreanH - 64) * 0.06];
        [self MobileTopAnimation:CYScreanW * 0.25 withHeight:(CXCScreanH - 64) * 0.06];

    }
    else if (sender == self.CommentDeTopButton)
    {
        self.ActivityDeButton.selected = NO;
        self.ActivityDeTopButton.selected = NO;
        self.commentDeButton.selected = YES;
        self.CommentDeTopButton.selected = YES;
        [self MobileAnimation:CYScreanW * 0.75 withHeight:(CXCScreanH - 64) * 0.06];
        [self MobileTopAnimation:CYScreanW * 0.75 withHeight:(CXCScreanH - 64) * 0.06];
    }
    
    //刷新某一组
    [self.ActivityDetailsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    //滚动到显示帖子的第一行
    [self.ActivityDetailsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    
    
    
    
    
}
//移动动画
- (void) MobileTopAnimation:(float) width withHeight:(float)height
{
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.CustomTopView.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    self.CustomTopView.center = CGPointMake( width, height);
    [UIView commitAnimations];
}
-(void)didStopTopAnimation
{
    NSLog(@"动画执行完毕");
    //打印动画块的位置
    NSLog(@"动画执行之后的位置：%@",NSStringFromCGPoint(self.CustomTopView.center));
}
//移动动画
- (void) MobileAnimation:(float) width withHeight:(float)height
{
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.customView.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    self.customView.center = CGPointMake( width, height);
    [UIView commitAnimations];
}
-(void)didStopAnimation
{
    NSLog(@"动画执行完毕");
    //打印动画块的位置
    NSLog(@"动画执行之后的位置：%@",NSStringFromCGPoint(self.customView.center));
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"加载结束");
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    frame = webView.frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    webView.frame = frame;
    if (frame.size.height > self.HtmlHeight)
    {
        self.HtmlHeight = frame.size.height;
//        self.ShowWebViewHtml.frame = CGRectMake( 0, 0, CYScreanW, self.HtmlHeight);
        //刷新某一组
        [self.ActivityDetailsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
//    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    // CGFloat webViewHeight= [[webViewstringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"]floatValue];
//    CGRect newFrame = webView.frame;
//    newFrame.size.height= webViewHeight;
//    self.ShowWebViewHtml.frame= newFrame;
    
    
//    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
//    self.ActivityDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width,height);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    //    NSLog(@"监听 : %@ auth:%d", [[request URL]absoluteString],_authenticated);
    //对将要跳转的URL进行监听，与显示的URL进行比较，不一样则为要跳转的URL，一样则不再遍历，直接跳出，不作操作
   
    return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载出错***********error:%@,errorcode=%ld,errormessage:%@",error.domain,(long)error.code,error.description);
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
    }
}
- (CGSize) getAttributeSizeWithLabel:(UILabel *)textLabel
{
    CGSize maximumLabelSize = CGSizeMake(CYScreanW-20, 9999);
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    return expectSize;
}

- (CGSize) getSizeWithText:(NSString *)text font:(UIFont *)fnt
{
    
    if (IOS7) {
        CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(CYScreanW-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
        return tmpRect.size;
    }else{
        
        CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
        return size;
    }
    
}


@end
