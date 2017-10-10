//
//  MyBBSViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyBBSViewController.h"

@interface MyBBSViewController ()

@end

@implementation MyBBSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setBBSMyStyle];
    [self initBBSMyController];
    
    
    
    [self getMyBBSRequst];
}

//初始化数据
- (void) initBBSMyModel:(NSArray *)array
{
    NSArray *arrayModel = [NNSRootModelData initBBSRootModel:array];
    [self.myBBSAllarray addObjectsFromArray:arrayModel[0]];
    [self.MyBBSHeightArray addObjectsFromArray:arrayModel[1]];
    [self.modelBBSMyArray addObjectsFromArray:arrayModel[2]];
    //刷新
    [self.MyBBSTableView reloadData];
}
//设置样式
- (void) setBBSMyStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的帖子";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //数据源
    self.currentMBBSPage = 1;
    self.modelBBSMyArray = [[NSMutableArray alloc] init];
    self.myBBSAllarray = [[NSMutableArray alloc] init];
    self.MyBBSHeightArray = [[NSMutableArray alloc] init];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    if (self.ClickMyCellData.count == 2)
    {
        //刷新位置和帖子数据
        [self getClickMyCellNewData:self.ClickMyCellData[0] withDict:self.ClickMyCellData[1]];
    }
}
//刷新
-(void) headerMyRefresh
{
    //结束下拉刷新
    [self.MyBBSTableView.mj_header endRefreshing];
}
//根据不同的排序调用不同的方法
- (void) footerMyRefresh
{
    self.currentMBBSPage += 1;
    [self getMyBBSRequst];
}
//初始化控件
- (void) initBBSMyController
{
    //显示
    self.MyBBSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.MyBBSTableView.delegate = self;
    self.MyBBSTableView.dataSource = self;
    self.MyBBSTableView.showsVerticalScrollIndicator = NO;
    self.MyBBSTableView.backgroundColor = [UIColor whiteColor];
    self.MyBBSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyBBSTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerMyRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.MyBBSTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerMyRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.MyBBSTableView.mj_footer = footer;
    
    
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.MyBBSImage = PromptImageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.MyBBSHeightArray[indexPath.row] floatValue];
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelBBSMyArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyBBSCellId";
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.cell == nil)
    {
        self.cell = [[comBBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.modelBBSMyArray[indexPath.row]);
    self.cell.model = self.modelBBSMyArray[indexPath.row];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //记录点击的cell
    self.ClickMyCellData = @[[NSString stringWithFormat:@"%ld",indexPath.row],self.myBBSAllarray[indexPath.row]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
    PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.myBBSAllarray[indexPath.row]];
    [self.navigationController pushViewController:PDController animated:YES];
    
}
//获取我的帖子
- (void) getMyBBSRequst
{
    if (self.currentMBBSPage == 1)
    {
        [MBProgressHUD showLoadToView:self.view];
    }
    self.MyBBSImage.hidden = YES;
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]      =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]        =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"pageSize"]     =  @"15";
    parames[@"currentPage"]  =  [NSString stringWithFormat:@"%ld",self.currentMBBSPage];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/myNoteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (self.currentMBBSPage == 1)
         {
             [MBProgressHUD hideHUDForView:self.view];
         }
         // 结束上拉刷新
         [self.MyBBSTableView.mj_footer endRefreshing];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (array.count)
             {
                 [self initBBSMyModel:array];
             }
             else
             {
                 if (!self.modelBBSMyArray.count)
                 {
                     self.MyBBSImage.hidden = NO;
                 }
                 self.currentMBBSPage -= 1;//修改计数
                 [MBProgressHUD showError:@"没有数据了"  ToView:self.view];
             }
         }
         else
         {
             self.currentMBBSPage -= 1;//修改计数
             [MBProgressHUD showError:[JSON objectForKey:@"error"]  ToView:self.view];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (!self.modelBBSMyArray.count)
         {
             self.MyBBSImage.hidden = NO;
         }
         if (self.currentMBBSPage == 1)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
         }
         // 结束上拉刷新
         [self.MyBBSTableView.mj_footer endRefreshing];
         self.currentMBBSPage -= 1;
         NSLog(@"请求失败:%@", error.description);
     }];
}

//获取点击cell的下标
- (void) getClickMyCellNewData:(NSString *)ClickRow withDict:(NSDictionary *)dict
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
   
             
             [self.myBBSAllarray   replaceObjectAtIndex:[ClickRow integerValue] withObject:[JSON objectForKey:@"returnValue"]];
             
             NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
             [self.MyBBSHeightArray    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
             
             BBSArray = [NSArray arrayWithArray:array[2]];
             [self.modelBBSMyArray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
             
             NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:0];
             [self.MyBBSTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
    //初始化
    self.ClickMyCellData = [[NSArray alloc] init];
}


@end
