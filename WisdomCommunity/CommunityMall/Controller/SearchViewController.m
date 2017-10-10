//
//  SearchViewController.m
//  bridgeProject
//
//  Created by bridge on 16/5/20.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSearchController];
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化控件
- (void) initSearchController
{
    self.view.backgroundColor = [UIColor whiteColor];
    //设置返回箭头颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //左
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.01, 20, 35, 35)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = buttonLeft;
    //右按钮
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    btnRight.backgroundColor = [UIColor clearColor];
    btnRight.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [btnRight setTitle:@"搜索" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(onClickSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = buttonRight;
    
    
    _bar = [[UISearchBar alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
    _bar.placeholder = @"输入商家、商品";
    _bar.tintColor = [UIColor redColor];
    _bar.barTintColor = [UIColor whiteColor];
    _bar.translucent = YES;
    // 是否在控件的右端显示一个书的按钮
    _bar.showsBookmarkButton = NO;
    // 是否显示cancel按钮(静态)
    //search.showsCancelButton = YES;
    self.navigationItem.titleView = _bar;
    _bar.delegate = self;
    //自动获取光标
    [_bar becomeFirstResponder];
    
    
    //初始化tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}
//返回按钮
- (void) backButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//搜索按钮
-(void) onClickSearch:(UIButton *)sender
{
    NSLog(@"_bar.text = %@",_bar.text);
    [self RequestSearchData];
    [_bar resignFirstResponder];
}
//点击键盘搜索按钮事件
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search text :%@",[searchBar text]);
    [self RequestSearchData];
    [_bar resignFirstResponder];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TakeOutModel *model = self.searchArray[indexPath.row];
    if ([model.isNUJianMian integerValue] == 1 || [model.isManJian integerValue] == 1)
    {
        return (CYScreanH - 64) * 0.16;
    }
    else
        return (CYScreanH - 64) * 0.12;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.searchArray.count;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellComMallId2";
    self.takeCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.takeCell == nil)
    {
        self.takeCell = [[TakeOutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    self.takeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.takeCell.model = self.searchArray[indexPath.row];
    return  self.takeCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.AllSearchArray[indexPath.row]];
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    NSLog(@"dict = %@,%@",dict,[dict objectForKey:@"shopId"]);
    MPController.MerchantsId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    [self.navigationController pushViewController:MPController animated:YES];
}
//获取搜索内容
- (void) RequestSearchData
{
    if (!_bar.text.length)
    {
        [MBProgressHUD showError:@"请输入搜索内容" ToView:self.view];
        return;
    }
    [MBProgressHUD showLoadToView:self.view];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/shopBySName",POSTREQUESTURL];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:_bar.text forKey:@"sName"];
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    
    NSLog(@"parames = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取搜索内容请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
            if (array.count)
            {
                self.tableView.hidden = NO;
                [self initSearchModel:array];
            }
            else
            {
                self.tableView.hidden = YES;
                [MBProgressHUD showError:@"没有找到相关商家或产品" ToView:self.view];
            }
        }
        else
            [MBProgressHUD showError:@"加载出错" ToView:self.view];
    }];
}
//初始化数据源
- (void) initSearchModel:(NSArray *)array
{
    //初始化
    self.searchArray = [[NSMutableArray alloc] init];
    self.AllSearchArray = [NSArray arrayWithArray:array];
    //数据源
    for (NSDictionary *MerchantsDict in array)
    {
        NSDictionary *dataDict = @{
                                   @"headString"        :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"imgBiao"]],
                                   @"nameString"        :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"shopName"]],
                                   @"startTOString"       :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"zongHePingFen"]],
                                   @"numberString"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"successNum"]],
                                   @"sendPriceString"   :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"minAmount"]],
                                   @"shippingFeeString" :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"busFee"]],
                                   @"onlineString"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"youHuiInfo"]],
                                   @"merchantsId"       :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"id"]],
                                   @"isManJian"         :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"isManJian"]],
                                   @"isNUJianMian"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"isNUJianMian"]]
                                   };
        
        TakeOutModel *model = [TakeOutModel bodyWithDict:dataDict];
        [self.searchArray addObject:model];
    }
    [self.tableView reloadData];
}
//数据请求
- (void)requestWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
@end
