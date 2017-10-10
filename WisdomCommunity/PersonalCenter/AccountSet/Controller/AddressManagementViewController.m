//
//  AddressManagement ViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AddressManagementViewController.h"
#import "AccountSettingViewController.h"
@interface AddressManagementViewController ()

@end

@implementation AddressManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAddressMStyle];
    [self initAddressMController];
    
    
}
//设置样式
- (void) setAddressMStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收货地址";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    //获取收货地址
    [self getReceiveGListRequest];
}
- (void) initAddressMModel:(NSArray *)array
{
    self.AllAllAddressArray = [[NSMutableArray alloc] init];
    self.AllAddressArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < array.count; i ++)
    {
        NSDictionary *addressDict = array[i];
        [self.AllAllAddressArray addObject:addressDict];//保存所有收货地址
        NSDictionary *dict = @{
                               @"nameString":[addressDict objectForKey:@"name"],
                               @"phoneString":[addressDict objectForKey:@"phone"],
                               @"addressString":[addressDict objectForKey:@"address"],
                               @"defaultString":[addressDict objectForKey:@"isDefault"],
                               @"idString":[NSString stringWithFormat:@"%ld",i]
                               };
        AddressMangeModel *model = [AddressMangeModel bodyWithDict:dict];
        [self.AllAddressArray addObject:model];
    }
    [self.AddressTableView reloadData];
}
//初始化控件
- (void) initAddressMController
{
    //显示
    self.AddressTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.86)];
    self.AddressTableView.delegate = self;
    self.AddressTableView.dataSource = self;
    self.AddressTableView.showsVerticalScrollIndicator = NO;
    self.AddressTableView.scrollEnabled = YES;
    self.AddressTableView.backgroundColor = [UIColor whiteColor];
    self.AddressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.AddressTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *addAdressButton = [[UIButton alloc] init];
    addAdressButton.backgroundColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
    [addAdressButton setTitle:@"+ 收货地址" forState:UIControlStateNormal];
    addAdressButton.layer.cornerRadius = 5;
    [addAdressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAdressButton addTarget:self action:@selector(addAdressButtonC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAdressButton];
    [addAdressButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.04);
     }];
}
//
- (void) addAdressButtonC
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    AddressEditViewController *AEditController = [[AddressEditViewController alloc] init];
    [self.navigationController pushViewController:AEditController animated:YES];
}
- (void) ClickEditImage:(NSString *)addressid
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    AddressUpdateViewController *AUpdateController = [[AddressUpdateViewController alloc] init];
    AUpdateController.ReceiveAddressDict = self.AllAllAddressArray[[addressid integerValue]];
    [self.navigationController pushViewController:AUpdateController animated:YES];
    NSLog(@"点击了第%@条地址信息",addressid);
}//
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
    return self.AllAddressArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.cell == nil)
    {
        self.cell = [[AddressMangeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    self.cell.model = self.AllAddressArray[indexPath.row];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell.delegate = self;
    return self.cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* array =self.navigationController.viewControllers;
    NSLog(@"array[0] = %@",array);
    //判断是不是从个人中心页进入的
    if (![array[array.count - 2] isKindOfClass:[AccountSettingViewController class]])
    {
        self.selectAddressDict = [NSDictionary dictionaryWithDictionary:self.AllAllAddressArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        
        [self ClickEditImage:[NSString stringWithFormat:@"%d",indexPath.row]];

    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取收货地址列表
- (void) getReceiveGListRequest
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
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/expressAddList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [self initAddressMModel:[JSON objectForKey:@"returnValue"]];
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


@end
