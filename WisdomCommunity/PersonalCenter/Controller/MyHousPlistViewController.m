//
//  MyHousPlistViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//  

#import "MyHousPlistViewController.h"
#import "MyHouseCell.h"
@interface MyHousPlistViewController ()

@end

@implementation MyHousPlistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setMyHouseStyle];
    [self initMyHouseController];
    
    
    
}

//设置样式
- (void) setMyHouseStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的房屋";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self getHouselist];
}

//初始化控件
- (void) initMyHouseController
{

      //数据源
    self.MyHouseAllArray = [[NSMutableArray alloc] init];
    
    //提示没有房屋
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.35, CYScreanW, CXCScreanH)];
//    label.text = @"当前小区尚未绑定房屋";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont fontWithName:@"Arial" size:25];
//    label.textColor = [UIColor grayColor];
//    label.hidden = YES;
//    [self.view addSubview:label];
//    self.promptLabel = label;
   
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, CXCScreanH-300*CXCWidth-64, CYScreanW, 300*CXCWidth)];
    [self.view addSubview:bgView];
    bgView.backgroundColor =BGColor;
    //提交按钮
    UIButton *queryButton = [[UIButton alloc] init];
    [queryButton setTitle:@"添加房屋" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton.layer.cornerRadius = 5;
    queryButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [queryButton addTarget:self action:@selector(submitMHButton) forControlEvents:UIControlEventTouchUpInside];
    queryButton.frame =CGRectMake(32*CXCWidth, 106*CXCWidth, 686*CXCWidth, 98*CXCWidth);
    [bgView   addSubview:queryButton];
    //显示
    self.MyHouseTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH-300*CXCWidth-64)];
    self.MyHouseTableView.delegate = self;
    self.MyHouseTableView.dataSource = self;
    self.MyHouseTableView.showsVerticalScrollIndicator = NO;
    self.MyHouseTableView.backgroundColor = BGColor;
    self.MyHouseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyHouseTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;

}
//提交
- (void) submitMHButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    HousingChoiceViewController *MyHousController = [[HousingChoiceViewController alloc] init];
    MyHousController.InputController = @"MyHousPlistViewController";
    [self.navigationController pushViewController:MyHousController animated:YES];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CXCWidth*195;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MyHouseAllArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"cell";
    MyHouseCell     *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell = [[MyHouseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy withType:[NSString stringWithFormat:@"%ld",indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.dic = [self.MyHouseAllArray objectAtIndex:indexPath.row];
    return cell;
    
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.MyHouseAllArray[indexPath.row]];
    if ([[dict objectForKey:@"status"] integerValue] == 2)
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        HousingChoiceViewController *MyHousController = [[HousingChoiceViewController alloc] init];
        MyHousController.HouseDict = [NSDictionary dictionaryWithDictionary:dict];
        MyHousController.InputController = @"MyHousPlistViewController";
        [self.navigationController pushViewController:MyHousController animated:YES];
    }
    
    
    
}
//获取房屋列表
- (void) getHouselist
{
    [MBProgressHUD showLoadToView:self.view];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/myBuilds",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
    dict[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    dict[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"dict = %@",dict);
    [manager POST:requestUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             self.MyHouseAllArray = [NSMutableArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (self.MyHouseAllArray.count)
             {
//                 self.promptLabel.hidden = YES;
                 self.MyHouseTableView.hidden = NO;
                 [self.MyHouseTableView reloadData];
             }
             else
             {
//                 self.promptLabel.hidden = NO;
                 self.MyHouseTableView.hidden = NO;
             }
         }
         else
         {
             self.MyHouseTableView.hidden = YES;
//             self.promptLabel.hidden = NO;
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"获取房屋列表失败:%@", error.description);
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
