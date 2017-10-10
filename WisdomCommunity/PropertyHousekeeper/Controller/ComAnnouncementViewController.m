//
//  ComAnnouncementViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComAnnouncementViewController.h"

@interface ComAnnouncementViewController ()

@end

@implementation ComAnnouncementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //初始化
    self.currentComAnnPage = 1;
    self.recordComAnnPage = 1;
    
    
    [self setComAnnStyle];
    [self initComAnnController];
    //请求数据
    [self getComAnnounceRequest];
    
}
//设置样式
- (void) setComAnnStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"社区公告";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //数据源
    self.dataModelCAArray = [[NSMutableArray alloc] init];
    self.dataAnnouncementArray = [[NSMutableArray alloc] init];
    self.AnnouncementHeigthArray = [[NSMutableArray alloc] init];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化数据源
- (void) initComAnnModelData:(NSArray *)array
{
    for (NSDictionary *arrayDict in array)
    {
        NSString *title = [NSString stringWithFormat:@"%@",[arrayDict objectForKey:@"title"]];
        //记录评论高度
        CGSize sizeP = CGSizeMake(CYScreanW * 0.8, CGFLOAT_MAX);
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:title.length > 0 ? title : @"未获取"]];
        [self.AnnouncementHeigthArray addObject:[NSString stringWithFormat:@"%.f",layout.textBoundingSize.height]];
        
        NSDictionary *dict = @{
                               @"comAnnImageString":@"comments_icon",
                               @"comAnnString":title,
                               @"timeString":[CYSmallTools timeWithTimeIntervalString:[arrayDict objectForKey:@"publishTime"]],
                               @"comAnnStringDetail":[arrayDict objectForKey:@"content"],
                               
                               };
        
        [self.dataAnnouncementArray addObject:arrayDict];
        ComAnnoModel *model = [ComAnnoModel bodyWithDict:dict];
        [self.dataModelCAArray addObject:model];
    }
    [self.announcementTableView reloadData];
}
//刷新
-(void) headerComAnRefresh
{
    //结束下拉刷新
    [self.announcementTableView.mj_header endRefreshing];
}
//根据不同的排序调用不同的方法
- (void) footerComAnRefresh
{
    self.currentComAnnPage += 1;
    [self getComAnnounceRequest];
}
//初始化控件
- (void) initComAnnController
{
    //显示
    self.announcementTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.announcementTableView.delegate = self;
    self.announcementTableView.dataSource = self;
    self.announcementTableView.showsVerticalScrollIndicator = NO;
    self.announcementTableView.backgroundColor = [UIColor whiteColor];
    self.announcementTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.announcementTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerComAnRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.announcementTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerComAnRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.announcementTableView.mj_footer = footer;
    
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*CXCWidth;
//    return (CYScreanH - 64) * 0.13 + [self.AnnouncementHeigthArray[indexPath.row] floatValue];
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModelCAArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellMessageOId";
    self.cellMessage = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.cellMessage == nil)
    {
        self.cellMessage = [[ComAnnoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    self.cellMessage.backgroundColor = [UIColor whiteColor];
    self.cellMessage.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row <= self.dataModelCAArray.count - 1)//防止数组越界
    {
        self.cellMessage.model = self.dataModelCAArray[indexPath.row];
    }
    if (indexPath.row != 1)
    {
        
    }
    return self.cellMessage;
    
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    AnnounDetailsViewController *ADEController = [[AnnounDetailsViewController alloc] init];
    ADEController.detailsDict = self.dataAnnouncementArray[indexPath.row];
    [self.navigationController pushViewController:ADEController animated:YES];
}
//获取社区公告列表
- (void) getComAnnounceRequest
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/noticeList",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"comNo"]         =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];//
    parames[@"pageSize"]      =  @"20";//
    parames[@"currentPage"]   =  [NSString stringWithFormat:@"%ld",self.currentComAnnPage];//
    NSLog(@"parames = %@",parames);
    
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         // 结束上拉刷新
         [self.announcementTableView.mj_footer endRefreshing];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"公告请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         NSArray *array = [JSON objectForKey:@"returnValue"];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             if ( array.count)
             {
                 [self initComAnnModelData:array];
             }
             else
             {
                  [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                 self.currentComAnnPage -= 1;//不成功就减1
             }
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
             self.currentComAnnPage -= 1;//不成功就减1
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
        // 结束上拉刷新
        [self.announcementTableView.mj_footer endRefreshing];
        self.currentComAnnPage -= 1;
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
