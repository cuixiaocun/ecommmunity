//
//  MyCommentViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyCommentViewController.h"

@interface MyCommentViewController ()

@end

@implementation MyCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setMyComStyle];
    [self initMyComController];
    
    //数据请求
    [MBProgressHUD showLoadToView:self.view];
    [self getMyCommentList];
}
//初始化数据
- (void) initMyComModel:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *dictPost = [NSDictionary dictionaryWithDictionary:array[i]];
        ActivityRootModel *modelA = [ActivityRootModel bodyWithDict:dictPost];
        [self.IDArray addObject:modelA];
        NSString *accountDoString = [NSString stringWithFormat:@"%@",[dictPost objectForKey:@"accountDO"]];
        NSDictionary *dict;
        if (accountDoString.length > 6)
        {
            NSDictionary *dictDo = [NSDictionary dictionaryWithDictionary:[dictPost objectForKey:@"accountDO"]];
            dict = @{
                     @"headString":[NSString stringWithFormat:@"%@",[dictDo objectForKey:@"imgAddress"]],
                     @"nameString":[NSString stringWithFormat:@"%@",[dictDo objectForKey:@"nickName"]],
                     @"timeString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"gmtCreate"]],
                     @"showImageString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"imgAddress"]],
                     @"commentPostString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"title"]],
                     @"comNameString":@"",
                     @"titleString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"content"]]
                     };
        }
        else
        {
            dict = @{
                     @"headString":DefaultHeadImage,
                     @"nameString":@"未获取",
                     @"timeString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"gmtCreate"]],
                     @"showImageString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"imgAddress"]],
                     @"commentPostString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"title"]],
                     @"comNameString":@"",
                     @"titleString":[NSString stringWithFormat:@"%@",[dictPost objectForKey:@"content"]]
                     };
        }
        
        NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithDictionary:dict];
        MyCommentModel *model = [MyCommentModel bodyWithDict:dict2];
        [self.myCommentModelArray addObject:model];
        
        
    }
    //刷新
    [self.MyCommentTableView reloadData];
}
//设置样式
- (void) setMyComStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的评论";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //数据源
    self.myCommentModelArray = [[NSMutableArray alloc] init];
    self.IDArray = [[NSMutableArray alloc] init];
    //初始页数
    self.currentMCPage = 1;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化控件
- (void) initMyComController
{
    //显示
    self.MyCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW,CXCScreanH - 64)];
    self.MyCommentTableView.delegate = self;
    self.MyCommentTableView.dataSource = self;
    self.MyCommentTableView.showsVerticalScrollIndicator = NO;
    self.MyCommentTableView.backgroundColor = [UIColor whiteColor];
    self.MyCommentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyCommentTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerMyComRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.MyCommentTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerMyComRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.MyCommentTableView.mj_footer = footer;
    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.MyCommentImage = PromptImageView;
}
//刷新
-(void) headerMyComRefresh
{
    //结束下拉刷新
    [self.MyCommentTableView.mj_header endRefreshing];
}
//根据不同的排序调用不同的方法
- (void) footerMyComRefresh
{
    self.currentMCPage += 1;
    [self getMyCommentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CXCWidth*230;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myCommentModelArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bbsCellId";
    self.myCCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.myCCell == nil)
    {
        self.myCCell = [[MyConmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.myCommentModelArray[indexPath.row]);
    self.myCCell.model = self.myCommentModelArray[indexPath.row];
    self.myCCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.myCCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailsViewController *ADController = [[ActivityDetailsViewController alloc] init];
    ActivityRootModel *IDmodel = self.IDArray[indexPath.row];
    ADController.ActivityIDmodel = IDmodel.activityID;
    [self.navigationController pushViewController:ADController animated:YES];
}
//请求我的评论列表数据
- (void) getMyCommentList
{
    self.MyCommentImage.hidden = YES;
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"pageSize"]   =  @"15";//
    parames[@"currentPage"]     =  [NSString stringWithFormat:@"%ld",self.currentMCPage];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/myReplyAcs",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         // 结束上拉刷新
         [self.MyCommentTableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (array.count)
             {
                 [self initMyComModel:array];
             }
             else
             {
                 if (!self.myCommentModelArray.count)
                 {
                     self.MyCommentImage.hidden = NO;
                 }
                 
                 [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                 self.currentMCPage -= 1;
             }
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
             self.currentMCPage -= 1;
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (!self.myCommentModelArray.count)
         {
             self.MyCommentImage.hidden = NO;
         }

         // 结束上拉刷新
         [self.MyCommentTableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         self.currentMCPage -= 1;
         NSLog(@"请求失败:%@", error.description);
     }];
}



@end
