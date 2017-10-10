
//
//  MessagePlistViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MessagePlistViewController.h"

@interface MessagePlistViewController ()

@end

@implementation MessagePlistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *string = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:@"hello"]];
    if (string.length > 10)//推送
        self.isJPushInput = YES;
    else
        self.isJPushInput = NO;
    //设置数据
    [self setMessagePStyle];
    [self initMessagePController];
    
}

//离开
- (void) viewWillDisappear:(BOOL)animated
{
    //将推送数据清空
    [CYSmallTools saveData:nil withKey:@"hello"];
}
//设置样式
- (void) setMessagePStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息中心";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (self.isJPushInput == YES)
    {
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
        //左
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 25)];
        btn1.backgroundColor = [UIColor clearColor];
        [btn1 setImage:[UIImage imageNamed:@"未标题-1_06"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(inputRootController) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:btn1];
        self.navigationItem.leftBarButtonItem = buttonLeft;
    }
}
//初始化控件
- (void) initMessagePController
{
    //显示
    self.messagePTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, self.isJPushInput ? 64 : 0, CYScreanW, CXCScreanH - 64)];
    self.messagePTableView.delegate = self;
    self.messagePTableView.dataSource = self;
    self.messagePTableView.showsVerticalScrollIndicator = NO;
    self.messagePTableView.backgroundColor = [UIColor whiteColor];
    self.messagePTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.messagePTableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//进入首页
- (void) inputRootController
{
    //创建标签控制器
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    NSArray *arryaVC = @[@"RootViewController",@"MallViewController",@"CommunityABBSViewController",@"PersonalCenterViewController"];
    NSMutableArray *arrayNav = [[NSMutableArray alloc] initWithCapacity:arryaVC.count];
    for (NSString *str in arryaVC)
    {
        UIViewController *viewController = [[NSClassFromString(str) alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigation.navigationBar.translucent = NO;
        navigation.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [navigation.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
        [arrayNav addObject:navigation];
        if ([str isEqualToString:@"RootViewController"])
        {
            navigation.tabBarItem.title = @"首页";
            navigation.tabBarItem.image = [UIImage imageNamed:@"icon_home-1"];
            navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_pre-1"];
        }
        else if([str isEqualToString:@"MallViewController"])
        {
            navigation.tabBarItem.title = @"社区商城";
            navigation.tabBarItem.image = [UIImage imageNamed:@"icon_shangcheng-1"];
            //未标题-1_26
            navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_shangcheng_pre-1"];
        }
        else if([str isEqualToString:@"CommunityABBSViewController"])
        {
            navigation.tabBarItem.title = @"社区大小事";
            navigation.tabBarItem.image = [UIImage imageNamed:@"icon_community-1"];
            //未标题-1_32
            navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_community_pre-1"];
        }
        else if([str isEqualToString:@"PersonalCenterViewController"])
        {
            navigation.tabBarItem.title = @"我的";
            navigation.tabBarItem.image = [UIImage imageNamed:@"icon_me-1"];
            //未标题-1_32
            navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_me_pre-1"];
        }
        
        
        //        navigation.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 30, 30);
    }
    tabbarController.viewControllers = arrayNav;
    //点击之后字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
    tabbarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00];
    self.view.window.rootViewController = tabbarController;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
    //获取消息列表数据
    [self getMessageListRequest];
}
//初始化数据源
- (void) initMessagePModelData:(NSArray *)array
{
    //数据源
    self.dataModelMPArray = [[NSMutableArray alloc] init];
    self.dataMessagePArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < array.count; i ++)
    {
        NSDictionary *dict = array[i];
        NSDictionary *dictT = @{
                               @"messageImageString":@"comments_icon",
                               @"messageString":[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]],
                               @"timeString":[CYSmallTools timeWithTimeIntervalString:[dict objectForKey:@"gmtCreate"]],
                               @"type":[NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]],
                               @"messageId":[NSString stringWithFormat:@"%@",[dict objectForKey:@"requestId"]]
                              };
        [self.dataMessagePArray addObject:dict];
        MessagePModel *model = [MessagePModel bodyWithDict:dictT];
        [self.dataModelMPArray addObject:model];
    }
    [self.messagePTableView reloadData];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*CXCWidth;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.dataModelMPArray.count ;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *ID = @"cellMessageOId";
        self.cellMessage = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.cellMessage == nil)
        {
            self.cellMessage = [[MessagePTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.cellMessage.backgroundColor = [UIColor whiteColor];
        self.cellMessage.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellMessage.model = self.dataModelMPArray[indexPath.row];
               
        return self.cellMessage;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MessagePModel *model = self.dataModelMPArray[indexPath.row];
    if ([model.type integerValue] == 1)//订单
    {
        OrderDetailsViewController *ODController = [[OrderDetailsViewController alloc] init];
        ODController.selectOrderId = model.messageId;
        [self.navigationController pushViewController:ODController animated:YES];
    }
    else if ([model.type integerValue] == 2)//活动
    {
        ActivityDetailsViewController *ADController = [[ActivityDetailsViewController alloc] init];
        ADController.ActivityIDmodel = model.messageId;
        [self.navigationController pushViewController:ADController animated:YES];
    }
    else if ([model.type integerValue] == 3)//公告
    {
        AnnounDetailsViewController *ADEController = [[AnnounDetailsViewController alloc] init];
        ADEController.detailsId = model.messageId;
        [self.navigationController pushViewController:ADEController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取消息列表
- (void) getMessageListRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/myMessages",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"消息列表请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (array.count)
             {
                 [self initMessagePModelData:array];
             }
             else
                 [MBProgressHUD showError:@"没有数据" ToView:self.view];
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.navigationController.view];
             CYLoginViewController *GoLoController = [[CYLoginViewController alloc] init];
             [self.navigationController pushViewController:GoLoController animated:YES];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}


@end
