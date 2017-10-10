//
//  OrderMViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderMViewController.h"

@interface OrderMViewController ()

@end

@implementation OrderMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setOrderMStyle];
    [self initOrderMControls];
    
}
//设置样式
- (void) setOrderMStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的订单";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    //获取订单数据:每次都重新加载
    [self getAllOrderData];
}
//初始化数据源
- (void) initOrderMModelData:(NSArray *)array
{
    //数据源
    self.MyOrderModelArray = [[NSMutableArray alloc] init];
    self.MyOrderAllDataArray = [NSArray arrayWithArray:array];
    for (NSInteger i = array.count - 1; i >= 0; i --)
    {
        NSDictionary *orderDict = [NSDictionary dictionaryWithDictionary:array[i]];
        NSDictionary *dict = @{
                               @"orderIdString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"id"]],
                               @"headImageString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"shopImg"]],
                               @"nameString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"shopName"]],
                               @"timeString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"gmtCreate"]],
                               @"moneyString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"nowMoney"]],
                               @"satateString":[NSString stringWithFormat:@"%@",[orderDict objectForKey:@"process"]]
                               };
        OrderMModel *model = [OrderMModel bodyWithDict:dict];
        [self.MyOrderModelArray addObject:model];
    }
    [self.OrderMTableView reloadData];
}

//初始化首页控件
- (void) initOrderMControls
{
    //显示
    self.OrderMTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW,CXCScreanH - 64)];
    self.OrderMTableView.delegate = self;
    self.OrderMTableView.dataSource = self;
    self.OrderMTableView.showsVerticalScrollIndicator = NO;
    self.OrderMTableView.backgroundColor = [UIColor whiteColor];
    self.OrderMTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.OrderMTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.26;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MyOrderModelArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"RootTableViewCellId";
    self.OrderCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.OrderCell == nil)
    {
        self.OrderCell = [[OrderMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.MyOrderModelArray[indexPath.row]);
    self.OrderCell.model = self.MyOrderModelArray[indexPath.row];
    self.OrderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.OrderCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    OrderMModel *model = self.MyOrderModelArray[indexPath.row];
    OrderDetailsViewController *ODController = [[OrderDetailsViewController alloc] init];
    ODController.selectOrderId = model.orderIdString;
    [self.navigationController pushViewController:ODController animated:YES];
    
}
//获取订单数
- (void) getAllOrderData
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/myOrderList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"获取订单数请求成功JSON = %@",JSON);
         
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             [self initOrderMModelData:[JSON objectForKey:@"returnValue"]];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}


- (void)didReceiveMemoryWarning {
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
