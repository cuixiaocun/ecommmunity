//
//  SelectSexViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SelectSexViewController.h"

@interface SelectSexViewController ()

@end

@implementation SelectSexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setSSexStyle];
    
    [self initSexController];
    
}
- (void) confirmButton
{
    [MBProgressHUD showLoadToView:self.view];
    NSDictionary *dict = [CYSmallTools getDataKey:PERSONALDATA];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  [dict objectForKey:@"id"];
    parames[@"sex"]       =  [NSString stringWithFormat:@"%@",self.selectSexString];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/updateAccInfo",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [CYSmallTools saveData:JSON withKey:ACCOUNTDATA];//记录账号数据
             [self.navigationController popViewControllerAnimated:YES];
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
//设置样式
- (void) setSSexStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"性别";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) initSexController
{
    //
    UITableView *SexTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.16)];
    SexTableView.delegate = self;
    SexTableView.dataSource = self;
    SexTableView.showsVerticalScrollIndicator = NO;
    SexTableView.scrollEnabled = NO;
    SexTableView.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    SexTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:SexTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[self.sexString integerValue] == 1 ? 0 : 1 inSection:0];
    [SexTableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    //确定
    UIButton *determineButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.18, CYScreanW * 0.9, (CYScreanH - 64) * 0.08)];
//    [determineButton setBackgroundImage:[UIImage imageNamed:@"code_btn"] forState:UIControlStateNormal];
    [determineButton setBackgroundColor:NavColor];
    determineButton.layer.cornerRadius = 7;
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(confirmButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineButton];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.08;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"男";
    }
    else
        cell.textLabel.text = @"女";
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        self.selectSexString = @"1";
    }
    else
    {
        self.selectSexString = @"0";
    }
    
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
