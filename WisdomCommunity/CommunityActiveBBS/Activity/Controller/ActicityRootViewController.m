//
//  ActicityRootViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActicityRootViewController.h"

typedef NS_ENUM(NSInteger , arrayStateType) {
    typeRootActivity,
    typeMyReleass,
    typeMyParticipate
};



@interface ActicityRootViewController ()
@property ( nonatomic, assign) arrayStateType type;
@end

@implementation ActicityRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.type = typeRootActivity;
    
    [self setActivityRootStyle];
    [self initActivityRootModel];
    [self initActivityRootController];
    
    
}

//活动
- (void) footerActivityRefresh
{
    switch (self.type) {
        case typeRootActivity:
            self.currentAllPage += 1;//计数+1
            [self initActivityRootModel];//请求数据
            break;
        case typeMyReleass:
            self.currentReleasePage += 1;
            [self loadMyRelease];
            break;
        case typeMyParticipate:
            self.currentParticipatePage += 1;
            [self loadMyParticipate];
            break;
        default:
            break;
    }
}
//初始化数据
- (void) initActivityRootModel
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/activityList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:[NSString stringWithFormat:@"%ld",self.currentAllPage] forKey:@"currentPage"];
    [parames setObject:@"15"forKey:@"pageSize"];
    NSLog(@"parames = %@",parames);
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *listArray = [JSON objectForKey:@"returnValue"];
            if (!listArray.count)
            {
                if (!self.modelActivityRootarray.count) {
                    self.ActicityPromptImage.hidden = NO;
                }
                
                if (self.whetherClickLabelRequest == NO)
                {
                    [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                }
                if (self.modelActivityRootarray.count) {
                    self.currentAllPage -= 1;
                }
            }
            else
            {
                for (NSDictionary *dict in listArray)
                {
                    ActivityRootModel *model = [ActivityRootModel bodyWithDict:dict];
                    [self.modelActivityRootarray addObject:model];
                }
                NSLog(@"self.modelActivityRootarray = %@",self.modelActivityRootarray);
            }
            [self.ActivityRootTableView reloadData];
            
        }
        else
        {
            self.currentAllPage -= 1;
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
        }
        self.whetherClickLabelRequest = NO;//重置
    }];
}

//我参与
- (void)loadMyParticipate
{
    NSString *requestUrl         = [NSString stringWithFormat:@"%@/api/activity/myPlayAcs",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:[NSString stringWithFormat:@"%ld",self.currentParticipatePage] forKey:@"currentPage"];
    [parames setObject:@"15"forKey:@"pageSize"];
    NSLog(@"parames = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        

        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        
        NSString *error = [JSON objectForKey:@"error"];
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *listArray = [JSON objectForKey:@"returnValue"];
            if (!listArray.count)
            {
                if (!self.myParticipateArray.count) {
                    self.ActicityPromptImage.hidden = NO;
                }
                
                if (self.whetherClickLabelRequest == NO)
                {
                    [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                }
                if (self.myParticipateArray.count)
                {
                    self.currentParticipatePage -= 1;
                }
            }
            else
            {
                for (NSDictionary *dict in listArray)
                {
                    ActivityRootModel *model = [ActivityRootModel bodyWithDict:dict];
                    [self.myParticipateArray addObject:model];
                }
                NSLog(@"self.myParticipateArray = %@",self.myParticipateArray);
            }
            [self.ActivityRootTableView reloadData];
        }
        else
        {
            self.currentParticipatePage -= 1;
            [MBProgressHUD showError:error ToView:self.view];
        }
        self.whetherClickLabelRequest = NO;//重置
    }];
}
//我发布
- (void)loadMyRelease
{
    NSString *requestUrl         = [NSString stringWithFormat:@"%@/api/activity/myActivityList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:[NSString stringWithFormat:@"%ld",self.currentReleasePage] forKey:@"currentPage"];
    [parames setObject:@"15"forKey:@"pageSize"];
    NSLog(@"parames = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        NSString *error = [JSON objectForKey:@"error"];
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *listArray = [JSON objectForKey:@"returnValue"];
            if (!listArray.count)
            {
                if (self.whetherClickLabelRequest == NO)
                {
                    [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                }
                //不为空
                if (self.myReleaseArray.count)
                {
                    self.currentReleasePage -= 1;
                }
                if (!self.myReleaseArray.count) {
                    self.ActicityPromptImage.hidden = NO;
                }
            }
            else
            {
                self.ActicityPromptImage.hidden = YES;
                for (NSDictionary *dict in listArray)
                {
                    ActivityRootModel *model = [ActivityRootModel bodyWithDict:dict];
                    [self.myReleaseArray addObject:model];
                }
            }
            [self.ActivityRootTableView reloadData];
        }
        else
        {
            if (self.myReleaseArray.count)
            {
                self.currentReleasePage -= 1;
            }
            [MBProgressHUD showError:error ToView:self.view];
        }
        self.whetherClickLabelRequest = NO;//重置
    }];
}
- (void)requestWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
{
    self.ActicityPromptImage.hidden = YES;//每次请求数据都隐藏
    //第一次进入显示进度条
    if (self.whetherFirst)
    {
        [MBProgressHUD showLoadToView:self.view];
        self.whetherFirst = NO;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [self.ActivityRootTableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view];
         success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         self.whetherClickLabelRequest = NO;//重置
         [self.ActivityRootTableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
         //改变计数
         switch (self.type) {
             case typeRootActivity:
                 if (self.modelActivityRootarray.count) {
                     self.currentAllPage -= 1;
                 }//计数+1
                 else
                     self.ActicityPromptImage.hidden = NO;
                 break;
             case typeMyReleass:
                 if (self.myReleaseArray.count) {
                     self.currentReleasePage -= 1;
                 }//计数+1
                 else
                     self.ActicityPromptImage.hidden = NO;
                 break;
             case typeMyParticipate:
                 if (self.myParticipateArray.count) {
                     self.currentParticipatePage -= 1;
                 }//计数+1
                 else
                     self.ActicityPromptImage.hidden = NO;
                 break;
             default:
                 break;
         }
     }];
}

- (NSMutableArray *)modelActivityRootarray
{
    if (!_modelActivityRootarray) {
        _modelActivityRootarray = [NSMutableArray array];
    }
    return _modelActivityRootarray;
}

-(NSMutableArray *)myParticipateArray
{
    if (!_myParticipateArray) {
        _myParticipateArray = [NSMutableArray array];
    }
    return _myParticipateArray;
}

-(NSMutableArray *)myReleaseArray
{
    if (!_myReleaseArray) {
        _myReleaseArray = [NSMutableArray array];
    }
    return _myReleaseArray;
}


//设置样式
- (void) setActivityRootStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"邻里活动";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(550*CXCWidth, -88*CXCWidth,200*CXCWidth, 88*CXCWidth)];
    [btn addTarget:self action:@selector(postingActivity) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *btnImg =[[UIImageView alloc]initWithFrame:CGRectMake(160*CXCWidth,24*CXCWidth ,40*CXCWidth , 40*CXCWidth)];
    [btnImg setImage:[UIImage imageNamed:@"icon_edit"]];
    [btn addSubview:btnImg];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem= rightItem;
    

    //初始化
    self.currentAllPage = 1;
    self.currentReleasePage = 1;
    self.currentParticipatePage = 1;
    self.whetherFirst = YES;
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    self.postingImmage.hidden = NO;
    
    
    self.currentReleasePage = 1;
    self.myReleaseArray = [[NSMutableArray alloc] init];
    self.currentParticipatePage = 1;
    self.myParticipateArray = [[NSMutableArray alloc] init];
    
    switch (self.type) {
        case typeMyReleass:
            [self loadMyRelease];
            break;
        case typeMyParticipate:
            [self loadMyParticipate];
            break;
        default:
            break;
    }

//    [self loadMyRelease];
//    [self loadMyParticipate];
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    //隐藏发布按钮
    self.postingImmage.hidden = YES;
}
//初始化控件
- (void) initActivityRootController
{
    self.plistButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (CYScreanW - 2) / 3, (CYScreanH - 64) * 0.08)];
    self.plistButton.backgroundColor = [UIColor clearColor];
    [self.plistButton setTitle:@"活动列表" forState:UIControlStateNormal];
    [self.plistButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.plistButton setTitleColor:TEXTColor forState:UIControlStateNormal];
//    [self.plistButton setImage:[UIImage imageNamed:@"icon_activity_list_def"] forState:UIControlStateNormal];
//    [self.plistButton setImage:[UIImage imageNamed:@"icon_activity_list_selected"] forState:UIControlStateSelected];
//    self.plistButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//    self.plistButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.plistButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.plistButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.plistButton addTarget:self action:@selector(labelClickAButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.plistButton];
    self.plistButton.selected = YES;
    
    self.participateButton = [[UIButton alloc] initWithFrame:CGRectMake((CYScreanW - 2) / 3 + 1, 0, (CYScreanW - 2) / 3, (CYScreanH - 64) * 0.08)];
    self.participateButton.backgroundColor = [UIColor clearColor];
    [self.participateButton setTitle:@"我参与的" forState:UIControlStateNormal];
    [self.participateButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.participateButton setTitleColor:TEXTColor forState:UIControlStateNormal];
//    [self.participateButton setImage:[UIImage imageNamed:@"icon_injoin_activity_def拷贝"] forState:UIControlStateNormal];
//    [self.participateButton setImage:[UIImage imageNamed:@"icon_injoin_activity_selected"] forState:UIControlStateSelected];
//    self.participateButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//    self.participateButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.participateButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.participateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.participateButton addTarget:self action:@selector(labelClickAButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.participateButton];
    self.participateButton.selected = NO;
    
    self.releaseButton = [[UIButton alloc] initWithFrame:CGRectMake((CYScreanW - 2) / 3 * 2 - 2, 0, (CYScreanW - 2) / 3, (CYScreanH - 64) * 0.08)];
    self.releaseButton.backgroundColor = [UIColor clearColor];
    [self.releaseButton setTitle:@"我发布的" forState:UIControlStateNormal];
    [self.releaseButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.releaseButton setTitleColor:TEXTColor forState:UIControlStateNormal];
//    [self.releaseButton setImage:[UIImage imageNamed:@"icon_post_activity_def"] forState:UIControlStateNormal];
//    [self.releaseButton setImage:[UIImage imageNamed:@"icon_post_activity_selected"] forState:UIControlStateSelected];
//    self.releaseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//    self.releaseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.releaseButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.releaseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.releaseButton addTarget:self action:@selector(labelClickAButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.releaseButton];
    self.releaseButton.selected = NO;
    //竖线  vertical
    UIImageView *verticalImmage = [[UIImageView alloc] init];
    verticalImmage.backgroundColor = BGColor;
    [self.view addSubview:verticalImmage];
    [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.plistButton.mas_right).offset(0);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    UIImageView *verticalTImmage = [[UIImageView alloc] init];
    verticalTImmage.backgroundColor = BGColor;
    [self.view addSubview:verticalTImmage];
    [verticalTImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.participateButton.mas_right).offset(0);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //分割线
//    UIImageView *segmentationImmage = [[UIImageView alloc] init];
//    segmentationImmage.backgroundColor = BGColor;
//    [self.view addSubview:segmentationImmage];
//    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(0);
//         make.right.equalTo(self.view.mas_right).offset(0);
//         make.bottom.equalTo(self.plistButton.mas_top).offset(0);
//         make.height.mas_equalTo(1);
//     }];
    UIImageView *segmentationTImmage = [[UIImageView alloc] init];
    segmentationTImmage.backgroundColor = BGColor;
    [self.view addSubview:segmentationTImmage];
    [segmentationTImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.plistButton.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    
    //显示
    self.ActivityRootTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, CXCScreanH-(CYScreanH - 64) * 0.08-64)];
    self.ActivityRootTableView.delegate = self;
    self.ActivityRootTableView.dataSource = self;
    self.ActivityRootTableView.showsVerticalScrollIndicator = NO;
    self.ActivityRootTableView.backgroundColor = [UIColor whiteColor];
    self.ActivityRootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ActivityRootTableView];
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerActivityRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.ActivityRootTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    //发状态
//    self.postingImmage = [[UIImageView alloc] init];
//    self.postingImmage.image = [UIImage imageNamed:@"icon_posting_withbg"];
//    self.postingImmage.backgroundColor = [UIColor clearColor];
//    self.postingImmage.userInteractionEnabled = YES;
//    [self.navigationController.view addSubview:self.postingImmage];
//    [self.postingImmage mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.right.equalTo(self.navigationController.view.mas_right).offset(-CYScreanW * 0.05);
//         make.bottom.equalTo(self.navigationController.view.mas_bottom).offset(-(CYScreanH - 64) * 0.15);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.09);
//         make.width.mas_equalTo((CYScreanH - 64) * 0.09);
//     }];
//    //添加单击手势防范
//    UITapGestureRecognizer *postingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postingActivityTap:)];
//    postingTap.numberOfTapsRequired = 1;
//    [self.postingImmage addGestureRecognizer:postingTap];
//    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.ActicityPromptImage = PromptImageView;
}
//标签页选择
- (void) labelClickAButton:(UIButton *)sender
{
    self.whetherClickLabelRequest = YES;//点击标签
    if (sender == self.plistButton)
    {
        if (self.modelActivityRootarray.count > 0) {
            self.currentAllPage += 1;
        }
        if (self.currentAllPage < 1)
        {
            self.currentAllPage += 1;
        }
        self.plistButton.selected = YES;
        self.participateButton.selected = NO;
        self.releaseButton.selected = NO;
        self.type = typeRootActivity;
        [self initActivityRootModel];
    }
    else if (sender == self.participateButton)
    {
        if (self.myParticipateArray.count)
        {
            self.currentParticipatePage += 1;
        }
        if (self.currentParticipatePage < 1)
        {
            self.currentParticipatePage += 1;
        }
        self.plistButton.selected = NO;
        self.participateButton.selected = YES;
        self.releaseButton.selected = NO;
        self.type = typeMyParticipate;
        [self loadMyParticipate];
    }
    else if (sender == self.releaseButton)
    {
        if (self.myReleaseArray.count) {
            self.currentReleasePage += 1;
        }
        
        self.plistButton.selected = NO;
        self.participateButton.selected = NO;
        self.releaseButton.selected = YES;
        self.type = typeMyReleass;
        [self loadMyRelease];
    }
}

//发帖
-(void) postingActivity
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    SendActivityViewController *SAController = [[SendActivityViewController alloc] init];
    [self.navigationController pushViewController:SAController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 460*CXCWidth;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = [NSMutableArray array];
    switch (self.type) {
        case typeRootActivity:
            array = self.modelActivityRootarray;
            break;
        case typeMyReleass:
            array = self.myReleaseArray;
            break;
        case typeMyParticipate:
            array = self.myParticipateArray;
            break;
        default:
            break;
    }
    return array.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bbsCellId";
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.cell == nil)
    {
        self.cell = [[ActivityRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSMutableArray *array = [NSMutableArray array];
    switch (self.type) {
        case typeRootActivity:
            array = self.modelActivityRootarray;
            break;
        case typeMyReleass:
            array = self.myReleaseArray;
            break;
        case typeMyParticipate:
            array = self.myParticipateArray;
            break;
        default:
            break;
    }
    if (indexPath.row <= array.count - 1)
    {
        self.cell.model = array[indexPath.row];
    }
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    NSMutableArray *array = [NSMutableArray array];
    switch (self.type) {
        case typeRootActivity:
            array = self.modelActivityRootarray;
            break;
        case typeMyReleass:
            array = self.myReleaseArray;
            break;
        case typeMyParticipate:
            array = self.myParticipateArray;
            break;
        default:
            break;
    }
    ActivityDetailsViewController *ADController = [[ActivityDetailsViewController alloc] init];
    ActivityRootModel *IDmodel = array[indexPath.row];
    ADController.ActivityIDmodel = IDmodel.activityID;
    [self.navigationController pushViewController:ADController animated:YES];
    
}





@end
