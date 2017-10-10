//
//  BBSRootViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "BBSRootViewController.h"

@interface BBSRootViewController ()

@end

@implementation BBSRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBBSRootStyle];
    [self initBBSRootController];
    

}
- (void) initVariable
{
    //数据源
    self.modelBBSRootarray = [[NSMutableArray alloc] init];
    self.BBSRootAllarray = [[NSMutableArray alloc] init];
    self.BBSHeightArray = [[NSMutableArray alloc] init];
    self.BBSRecordInt = 1;//从第一页开始请求
    [self getPostListRequest];
}
//初始化数据
- (void) initBBSRootModel:(NSArray *)array
{
    NSArray *arrayModel = [NNSRootModelData initBBSRootModel:array];
    [self.BBSRootAllarray addObjectsFromArray:arrayModel[0]];
    [self.BBSHeightArray addObjectsFromArray:arrayModel[1]];
    [self.modelBBSRootarray addObjectsFromArray:arrayModel[2]];
    //刷新
    [self.BBSRootTableView reloadData];    
}
//设置样式
- (void) setBBSRootStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帖子";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(550*CXCWidth, -88*CXCWidth,200*CXCWidth, 88*CXCWidth)];
    [btn addTarget:self action:@selector(posting) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *btnImg =[[UIImageView alloc]initWithFrame:CGRectMake(160*CXCWidth,24*CXCWidth ,40*CXCWidth , 40*CXCWidth)];
    [btnImg setImage:[UIImage imageNamed:@"icon_edit"]];
    [btn addSubview:btnImg];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem= rightItem;
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    //发帖图标
    self.postingImmage.hidden = NO;
    //如果查看帖子详情就刷新查看的帖子数据，否则刷新所有数据（发帖返回或者进入本页）
    if (self.ClickCellData.count == 2)
    {
        //刷新位置和帖子数据
        [self getClickCellNewData:self.ClickCellData[0] withDict:self.ClickCellData[1]];
    }
    else
    {
        [self initVariable];
    }
}
- (void) viewWillDisappear:(BOOL)animated
{
    //隐藏发布按钮
    self.postingImmage.hidden = YES;
}
//刷新
-(void) headerBBSRootfresh
{
    //结束下拉刷新
    [self.BBSRootTableView.mj_header endRefreshing];
}
//根据不同的排序调用不同的方法
- (void) footerComAnRefresh
{
    self.BBSRecordInt += 1;
    [self getPostListRequest];
}

//初始化控件
- (void) initBBSRootController
{
    //显示
    self.BBSRootTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.BBSRootTableView.delegate = self;
    self.BBSRootTableView.dataSource = self;
    self.BBSRootTableView.showsVerticalScrollIndicator = NO;
    self.BBSRootTableView.backgroundColor = [UIColor whiteColor];
    self.BBSRootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.BBSRootTableView];
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerBBSRootfresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.BBSRootTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerComAnRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.BBSRootTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.BBSRootPromptImage = PromptImageView;
    //发状态
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
//    UITapGestureRecognizer *postingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postingTap:)];
//    postingTap.numberOfTapsRequired = 1;
//    [self.postingImmage addGestureRecognizer:postingTap];
}
//发帖
-(void) posting
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    SendPostViewController *SPController = [[SendPostViewController alloc] init];
    [self.navigationController pushViewController:SPController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return (CYScreanH - 64) * 0.34;
    return [self.BBSHeightArray[indexPath.row] floatValue];
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelBBSRootarray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bbsCellId";
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.cell == nil)
    {
        self.cell = [[comBBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.modelBBSRootarray[indexPath.row]);
    self.cell.model = self.modelBBSRootarray[indexPath.row];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //记录点击的cell
    self.ClickCellData = @[[NSString stringWithFormat:@"%ld",indexPath.row],self.BBSRootAllarray[indexPath.row]];
    //跳转
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
    PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.BBSRootAllarray[indexPath.row]];
    [self.navigationController pushViewController:PDController animated:YES];
}
//获取点击cell的下标
- (void) getClickCellNewData:(NSString *)ClickRow withDict:(NSDictionary *)dict
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/viewNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"点击帖子请求成功JSON = %@",JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = @[[JSON objectForKey:@"returnValue"]];
             array = [NSArray arrayWithArray:[NNSRootModelData initBBSRootModel:array]];
             NSLog(@"array = %@,self.BBSRootAllarray.count = %ld",array,self.BBSRootAllarray.count);
             
             [self.BBSRootAllarray   replaceObjectAtIndex:[ClickRow integerValue] withObject:[JSON objectForKey:@"returnValue"]];
            
             NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
             [self.BBSHeightArray    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];

             BBSArray = [NSArray arrayWithArray:array[2]];
             [self.modelBBSRootarray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
             
             NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:0];
             [self.BBSRootTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
    //初始化
    self.ClickCellData = [[NSArray alloc] init];
}
//获取帖子列表
- (void) getPostListRequest
{
    if (self.BBSRecordInt == 1)
    {
        [MBProgressHUD showLoadToView:self.view];
    }
    self.BBSRootPromptImage.hidden = YES;//默认隐藏
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"category"]     =  @"1";//
    parames[@"pageSize"]     =  @"15";
    parames[@"currentPage"]  =  [NSString stringWithFormat:@"%ld",self.BBSRecordInt];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/noteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         // 结束上拉刷新
         [self.BBSRootTableView.mj_footer endRefreshing];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         NSArray *array = [JSON objectForKey:@"returnValue"];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             if (array.count)
             {
                 [self initBBSRootModel:array];
             }
             else
             {
                 if (!self.modelBBSRootarray.count) {
                     self.BBSRootPromptImage.hidden = NO;
                 }
                 [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                 self.BBSRecordInt -= 1;//失败不计数
             }
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
             self.BBSRecordInt -= 1;//失败不计数
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (!self.modelBBSRootarray.count) {
             self.BBSRootPromptImage.hidden = NO;
         }
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
         self.BBSRecordInt -= 1;
     }];
}


@end
