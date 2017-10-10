//
//  PeripheralServicesViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PeripheralServicesViewController.h"

@interface PeripheralServicesViewController ()

@end

@implementation PeripheralServicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPeripheralStyle];
    [self initPeripheralControls];
    
    
}
//
- (void) viewWillAppear:(BOOL)animated
{
    [self SurroundingMerchantsRequest];
}
//设置样式
- (void) setPeripheralStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"周边服务";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//初始化首页控件
- (void) initPeripheralControls
{
    //显示
    self.PeripheralSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH-64)];
    self.PeripheralSTableView.delegate = self;
    self.PeripheralSTableView.dataSource = self;
    self.PeripheralSTableView.showsVerticalScrollIndicator = NO;
    self.PeripheralSTableView.backgroundColor = [UIColor whiteColor];
    self.PeripheralSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.PeripheralSTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.135;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModelPerSArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"RootTableViewCellId";
    self.perCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.perCell == nil)
    {
        self.perCell = [[PeripheralSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.dataModelPerSArray[indexPath.row]);
    self.perCell.model = self.dataModelPerSArray[indexPath.row];
    self.perCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.perCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeripheralSModel *model = self.dataModelPerSArray[indexPath.row];
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    NSLog(@"model.merchantsId = %@",model.perIdString);
    MPController.MerchantsId = model.perIdString;
    [self.navigationController pushViewController:MPController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取周边商家数据
- (void) SurroundingMerchantsRequest
{
    [MBProgressHUD showLoadToView:self.view];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"comNo"]   =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];//
    NSLog(@"parames = %@",parames);
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/shopByComNoList",POSTREQUESTURL];
    
    [self requestPeripheralWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取周边商家数据请求成功JSON:%@", dict);
        
        if ([[dict objectForKey:@"success"] integerValue] == 1)
        {
            [self initDataPeripheralModel:[dict objectForKey:@"returnValue"]];
        }
        else
        {
            [MBProgressHUD showError:@"加载出错" ToView:self.view];
        }
        
    }];
}
//初始化数据
- (void) initDataPeripheralModel:(NSArray *)array
{
    if (!array.count) {
        [MBProgressHUD showError:@"没有数据了" ToView:self.view];
    }
    //数据源
    self.dataAllPerSArray = [[NSMutableArray alloc] init];
    self.dataModelPerSArray = [[NSMutableArray alloc] init];
    for (NSDictionary *MerchantsDict in array)
    {
        NSDictionary *dict = @{
                               @"perSerHeadString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"imgBiao"]],
                               @"perNameString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"shopName"]],
                               @"perStartString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"zongHePingFen"]],
                               @"perNumberString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"successNum"]],
                               @"perAddressString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"shopAddress"]],
                               @"perPhooneString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"account"]],
                               @"perIdString":[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"id"]],
                               };
        [self.dataAllPerSArray addObject:dict];
        PeripheralSModel *model = [PeripheralSModel bodyWithDict:dict];
        [self.dataModelPerSArray addObject:model];
    }
//    //刷新
    [self.PeripheralSTableView reloadData];
}
//数据请求
- (void) requestPeripheralWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];

}
@end
