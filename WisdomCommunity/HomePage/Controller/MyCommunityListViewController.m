//
//  MyCommunityListViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/29.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyCommunityListViewController.h"

@interface MyCommunityListViewController ()

@end

@implementation MyCommunityListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyHouseStyle];
    [self initMyHouseController];

    [self getCommunityRootPlist];
}
- (void) initMyHouseData:(NSArray *)array
{
    self.AllDataArray = [NSMutableArray arrayWithArray:array];
    for (NSInteger i = 0; i < array.count; i ++)
    {
        NSDictionary *dict = array[i];
        NSDictionary *dictTwo;
        
        //取出保存的小区数据->绑定房屋时第一次保存
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        NSLog(@"getDict = %@",getDict);
        if ([[getDict objectForKey:@"id"] integerValue] == [[dict objectForKey:@"id"] integerValue])
        {
            dictTwo = @{@"address":[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]],@"comNo":[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]],@"prompt":@"当前小区"};
            self.recoredShowNowIndex = i;
        }
        else
            dictTwo = @{@"address":[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]],@"comNo":[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]],@"prompt":@"切换"};
        
        [self.MyHouseAllArray addObject:dictTwo];
        MyHouseModel *model = [MyHouseModel bodyWithDict:dictTwo];
        [self.MyHouseModelArray addObject:model];
    }
    
    [self.MyHouseTableView reloadData];
    
    
    
}
//设置样式
- (void) setMyHouseStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的房屋";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //数据源
    self.MyHouseModelArray = [[NSMutableArray alloc] init];
    self.MyHouseAllArray = [[NSMutableArray alloc] init];
    //赋值0
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

//初始化控件
- (void) initMyHouseController
{
    //显示
    self.MyHouseTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.MyHouseTableView.delegate = self;
    self.MyHouseTableView.dataSource = self;
    self.MyHouseTableView.showsVerticalScrollIndicator = NO;
    self.MyHouseTableView.backgroundColor = [UIColor whiteColor];
    self.MyHouseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyHouseTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
//    //提交按钮
//    UIButton *queryButton = [[UIButton alloc] init];
//    [queryButton setTitle:@"+ 添加房屋" forState:UIControlStateNormal];
//    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    queryButton.layer.cornerRadius = 5;
//    queryButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
//    [queryButton addTarget:self action:@selector(submitMHButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:queryButton];
//    [queryButton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.width.mas_equalTo(CYScreanW * 0.9);
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
//         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
    
}
////提交
//- (void) submitMHButton
//{
//    
//}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.12;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MyHouseModelArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellIId";
    self.MyHouseCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.MyHouseCell == nil)
    {
        self.MyHouseCell = [[MyHouseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    self.MyHouseCell.backgroundColor = [UIColor whiteColor];
    self.MyHouseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.MyHouseCell.model = self.MyHouseModelArray[indexPath.row];
    
    
    return self.MyHouseCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.MyHouseAllArray[indexPath.row]];
    if ([[dict objectForKey:@"prompt"] isEqual:@"切换"])
    {
        NSDictionary *dictSelect = [NSDictionary dictionaryWithDictionary:self.AllDataArray[indexPath.row]];
        //记录小区数据
        [CYSmallTools saveData:dictSelect withKey:COMDATA];
        [CYSmallTools saveDataString:[dictSelect objectForKey:@"comTel"] withKey:PROPERTYCPHONE];//手机号
        //重置点击cell的数据
        NSDictionary *dictS = @{@"address":[NSString stringWithFormat:@"%@",[dict objectForKey:@"address"]],@"comNo":[NSString stringWithFormat:@"%@",[dict objectForKey:@"comNo"]],@"prompt":@"当前小区"};
        MyHouseModel *model = [MyHouseModel bodyWithDict:dictS];
        [self.MyHouseAllArray replaceObjectAtIndex:indexPath.row withObject:dictS];
        [self.MyHouseModelArray replaceObjectAtIndex:indexPath.row withObject:model];
        //重置之前cell的数据
        NSDictionary *beforedict = [NSDictionary dictionaryWithDictionary:self.MyHouseAllArray[self.recoredShowNowIndex]];
        dictS = @{@"address":[beforedict objectForKey:@"address"],@"comNo":[NSString stringWithFormat:@"%@",[beforedict objectForKey:@"comNo"]],@"prompt":@"切换"};;
        model = [MyHouseModel bodyWithDict:dictS];
        [self.MyHouseAllArray replaceObjectAtIndex:self.recoredShowNowIndex withObject:dictS];
        [self.MyHouseModelArray replaceObjectAtIndex:self.recoredShowNowIndex withObject:model];
        //刷新数据
        [self.MyHouseTableView reloadData];
        //记录当前点击的cell下标
        self.recoredShowNowIndex = indexPath.row;
    }

    
}
//获取社区列表
- (void) getCommunityRootPlist
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStringUTF8 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        
        [MBProgressHUD hideHUDForView:self.view];
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"param"]];
            NSArray *array = [NSArray arrayWithArray:[dict objectForKey:@"comList"]];
            if (array.count) {
                [self initMyHouseData:array];
            }
            else
                [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error.description);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
    }];
}

@end
