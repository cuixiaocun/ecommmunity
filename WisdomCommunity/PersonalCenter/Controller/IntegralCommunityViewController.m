//
//  IntegralCommunityViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "IntegralCommunityViewController.h"
#import "ScoreTableViewCell.h"
@interface IntegralCommunityViewController ()

@end

@implementation IntegralCommunityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setIntegrealStyle];
    [self initIntegrealController];
    [self getIntegralRequest];
    
}
- (void) initIntegrealData:(NSArray *)array
{
    for (NSInteger i = array.count - 1; i >= 0; i --)
    {
        NSDictionary *dictDetails = array[i];
        [self.integralArray addObject:dictDetails];
    }
    [_IntegralTableView reloadData];
}
//设置样式
- (void) setIntegrealStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"积分记录";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //数据源
    self.integralArray = [[NSMutableArray alloc] init];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

//初始化控件
- (void) initIntegrealController
{
    //显示
    self.IntegralTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.IntegralTableView.delegate = self;
    self.IntegralTableView.dataSource = self;
    self.IntegralTableView.showsVerticalScrollIndicator = NO;
    self.IntegralTableView.backgroundColor = [UIColor whiteColor];
    self.IntegralTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.IntegralTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"没有积分数据";
    promptLabel.textColor = [UIColor grayColor];
    promptLabel.font = [UIFont fontWithName:@"Arial" size:20];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:promptLabel];
    promptLabel.hidden = YES;
    self.promptLabel = promptLabel;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160*CXCWidth;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.integralArray.count ;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"cell";
    ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell = [[ScoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy withType:[NSString stringWithFormat:@"%ld",indexPath.row]];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dic = self.integralArray[indexPath.row];
    return cell;

}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
//获取积分记录
- (void) getIntegralRequest
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/myScoreLog",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (array.count)
             {
                 self.IntegralTableView.hidden = NO;
                 self.promptLabel.hidden = YES;
                 [self initIntegrealData:array];
             }
             else
             {
                 self.promptLabel.hidden = NO;
                 self.IntegralTableView.hidden = YES;
             }
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
