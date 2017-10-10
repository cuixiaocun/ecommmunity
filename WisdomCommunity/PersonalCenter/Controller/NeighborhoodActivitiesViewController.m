//
//  NeighborhoodActivitiesViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "NeighborhoodActivitiesViewController.h"

typedef NS_ENUM(NSInteger, typeActivities) {
    typeRelease,
    typeParticipate
};



@interface NeighborhoodActivitiesViewController ()
@property (nonatomic, assign)typeActivities type;
@end

@implementation NeighborhoodActivitiesViewController

- (void)viewDidLoad
{
    self.type = typeParticipate;
    [super viewDidLoad];
    
    [self setActivityNAStyle];
    [self initActivityNAController];
    
    [MBProgressHUD showLoadToView:self.view];
    [self initActivityNAModel];
    
}

- (NSMutableArray *)myParticipateArray
{
    if (!_myParticipateArray) {
        _myParticipateArray = [NSMutableArray array];
    }
    return _myParticipateArray;
}

- (NSMutableArray *)myReleaseArray
{
    if (!_myReleaseArray) {
        _myReleaseArray = [NSMutableArray array];
    }
    return _myReleaseArray;
}

//我发布的
- (void)loadMyRelease
{
    NSString *requestUrl         = [NSString stringWithFormat:@"%@/api/activity/myActivityList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:[NSString stringWithFormat:@"%ld",self.currentReleasePage] forKey:@"currentPage"];
    [parames setObject:@"15"forKey:@"pageSize"];
    NSLog(@"我发布的parames  = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        
        NSString *error = [JSON objectForKey:@"error"];
        if ([error isKindOfClass:[NSNull class]] || error == nil)
        {
            if ([[JSON objectForKey:@"success"] integerValue] == 1)
            {
                NSArray *listArray = [JSON objectForKey:@"returnValue"];
                if (!listArray.count)
                {
                    if (!self.myReleaseArray.count)
                    {
                        self.NeighborhoodImage.hidden = NO;
                    }
                    if (self.IsClickLabel == YES)
                    {
                        [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                    }
                    if (self.myReleaseArray.count)
                    {
                        self.currentReleasePage -= 1;
                    }
                }
                else
                {
                    for (NSDictionary *dict in listArray)
                    {
                        ActivityRootModel *model = [ActivityRootModel bodyWithDict:dict];
                        [self.myReleaseArray addObject:model];
                    }
                }
                [self.AcNeighborhoodTableView reloadData];
            }
            else
            {
                [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
                if (self.myReleaseArray.count)
                {
                    self.currentReleasePage -= 1;
                }
            }
        }
        else
        {
            [MBProgressHUD showError:error ToView:self.view];
            if (self.myReleaseArray.count)
            {
                self.currentReleasePage -= 1;
            }
        }
        self.IsClickLabel = NO;
    }];
}

- (void)requestWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
{
    self.NeighborhoodImage.hidden = YES;//每次请求数据都隐藏
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         // 结束上拉刷新
         [self.AcNeighborhoodTableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view];
         success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         self.IsClickLabel = NO;//默认是NO
         // 结束上拉刷新
         [self.AcNeighborhoodTableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:[NSString stringWithFormat:@"请求失败:%@",error.description] ToView:self.view];
         switch (self.type) {
             case typeRelease:
                 if (self.myReleaseArray.count) {
                     self.currentReleasePage -= 1;
                 }
                 else
                     self.NeighborhoodImage.hidden = NO;
                 break;
             case typeParticipate:
                 if (self.myParticipateArray.count) {
                     self.currentParticipatePage -= 1;
                 }
                 else
                     self.NeighborhoodImage.hidden = NO;
                 break;
             default:
                 break;
         }
         NSLog(@"请求失败:%@", error.description);
     }];
}
- (void)tableviewReloadDataAndScrolltoRow
{
    [self.AcNeighborhoodTableView reloadData];
    //滚动到显示帖子的第一行
    NSInteger count ;
    switch (self.type) {
        case typeRelease:
            count = self.myReleaseArray.count;
            break;
        case typeParticipate:
            count = self.myParticipateArray.count;
            break;
        default:
            break;
    }
    if (count<1) {
        return;
    }
    [self.AcNeighborhoodTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//我参与的
- (void) initActivityNAModel
{
    //数据源
    NSString *requestUrl         = [NSString stringWithFormat:@"%@/api/activity/myPlayAcs",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:[NSString stringWithFormat:@"%ld",self.currentParticipatePage] forKey:@"currentPage"];
    [parames setObject:@"15"forKey:@"pageSize"];
    NSLog(@"我参与的parames  = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        NSString *error = [JSON objectForKey:@"error"];
        if ([error isKindOfClass:[NSNull class]] || error == nil)
        {
            if ([[JSON objectForKey:@"success"] integerValue] == 1)
            {
                NSArray *listArray = [JSON objectForKey:@"returnValue"];
                if (!listArray.count)
                {
                    if (!self.myParticipateArray.count)
                    {
                        self.NeighborhoodImage.hidden = NO;
                    }
                    if (self.IsClickLabel == YES)
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
                }
                [self.AcNeighborhoodTableView reloadData];
            }
            else
            {
                [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
                if (self.myParticipateArray.count)
                {
                    self.currentParticipatePage -= 1;
                }
            }
        }
        else
        {
            [MBProgressHUD showError:error ToView:self.view];
            if (self.myParticipateArray.count)
            {
                self.currentParticipatePage -= 1;
            }
        }
        self.IsClickLabel = NO;
    }];
}
//设置样式
- (void) setActivityNAStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的活动";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.currentReleasePage = 1;
    self.currentParticipatePage = 1;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

//初始化控件
- (void) initActivityNAController
{
    self.participateNAButton = [[UIButton alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.00, CYScreanW * 0.5, (CYScreanH - 64) * 0.08)];
    self.participateNAButton.backgroundColor = [UIColor clearColor];
    [self.participateNAButton setTitle:@"我参与的" forState:UIControlStateNormal];
    [self.participateNAButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.participateNAButton setTitleColor:[UIColor colorWithRed:0.698 green:0.698 blue:0.698 alpha:1.00] forState:UIControlStateNormal];
    [self.participateNAButton setImage:[UIImage imageNamed:@"icon_injoin_activity_def拷贝"] forState:UIControlStateNormal];
    [self.participateNAButton setImage:[UIImage imageNamed:@"icon_injoin_activity_selected"] forState:UIControlStateSelected];
    self.participateNAButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    self.participateNAButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.participateNAButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.participateNAButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.participateNAButton addTarget:self action:@selector(labelClickNAButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.participateNAButton];
    self.participateNAButton.selected = YES;
    
    self.releaseNAButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.5, (CYScreanH - 64) * 0.00, CYScreanW * 0.5, (CYScreanH - 64) * 0.08)];
//    self.releaseNAButton.backgroundColor = [UIColor redColor];
    [self.releaseNAButton setTitle:@"我发布的" forState:UIControlStateNormal];
    [self.releaseNAButton setTitleColor:[UIColor colorWithRed:0.247 green:0.525 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.releaseNAButton setTitleColor:[UIColor colorWithRed:0.698 green:0.698 blue:0.698 alpha:1.00] forState:UIControlStateNormal];
    [self.releaseNAButton setImage:[UIImage imageNamed:@"icon_post_activity_def"] forState:UIControlStateNormal];
    [self.releaseNAButton setImage:[UIImage imageNamed:@"icon_post_activity_selected"] forState:UIControlStateSelected];
    self.releaseNAButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    self.releaseNAButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.releaseNAButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.releaseNAButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.releaseNAButton addTarget:self action:@selector(labelClickNAButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.releaseNAButton];
    self.releaseNAButton.selected = NO;
    //竖线  vertical
    UIImageView *verticalImmage = [[UIImageView alloc] init];
    verticalImmage.backgroundColor = BGColor;
    [self.view addSubview:verticalImmage];
    [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.participateNAButton.mas_right).offset(-0.5);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [self.view addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.participateNAButton.mas_top).offset(0);
         make.height.mas_equalTo(1);
     }];
    UIImageView *segmentationTImmage = [[UIImageView alloc] init];
    segmentationTImmage.backgroundColor = BGColor;
    [self.view addSubview:segmentationTImmage];
    [segmentationTImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.participateNAButton.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    
    //显示
    self.AcNeighborhoodTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, CXCScreanH-(CYScreanH - 64) * 0.08-64)];
    self.AcNeighborhoodTableView.delegate = self;
    self.AcNeighborhoodTableView.dataSource = self;
    self.AcNeighborhoodTableView.showsVerticalScrollIndicator = NO;
    self.AcNeighborhoodTableView.backgroundColor = [UIColor whiteColor];
    self.AcNeighborhoodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.AcNeighborhoodTableView];
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerNARefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.AcNeighborhoodTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerNAfresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.AcNeighborhoodTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    //    PromptImageView.hidden = YES;
    self.NeighborhoodImage = PromptImageView;
}
//刷新
-(void) headerNARefresh
{
    //结束下拉刷新
    [self.AcNeighborhoodTableView.mj_header endRefreshing];
}
//根据不同的排序调用不同的方法
- (void) footerNAfresh
{
    self.IsClickLabel = YES;//
    switch (self.type) {
        case typeRelease:
            self.currentReleasePage += 1;
            [self loadMyRelease];
            break;
        case typeParticipate:
            self.currentParticipatePage += 1;
            [self initActivityNAModel];
            break;
        default:
            break;
    }
}
//标签页选择
- (void) labelClickNAButton:(UIButton *)sender
{
    self.IsClickLabel = NO;//
    if (sender == self.participateNAButton)
    {
        if (self.myParticipateArray.count) {
            self.currentParticipatePage += 1;
        }
        self.participateNAButton.selected = YES;
        self.releaseNAButton.selected = NO;
        self.type = typeParticipate;
        [self initActivityNAModel];
    }
    else if (sender == self.releaseNAButton)
    {
        if (self.myReleaseArray.count) {
            self.currentReleasePage += 1;
        }
        self.participateNAButton.selected = NO;
        self.releaseNAButton.selected = YES;
        self.type = typeRelease;
        [self loadMyRelease];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.4;
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
            
        case typeRelease:
            array = self.myReleaseArray;
            break;
        case typeParticipate:
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

        case typeRelease:
            array = self.myReleaseArray;
            break;
        case typeParticipate:
            array = self.myParticipateArray;
            break;
        default:
            break;
    }
    self.cell.model = array[indexPath.row];
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
            
        case typeRelease:
            array = self.myReleaseArray;
            break;
        case typeParticipate:
            array = self.myParticipateArray;
            break;
        default:
            break;
    }
    //防止数组越界
    if (indexPath.row <= array.count - 1)
    {
        ActivityDetailsViewController *ADController = [[ActivityDetailsViewController alloc] init];
        ActivityRootModel *IDmodel = array[indexPath.row];
        ADController.ActivityIDmodel = IDmodel.activityID;
        [self.navigationController pushViewController:ADController animated:YES];
    }
}

@end
