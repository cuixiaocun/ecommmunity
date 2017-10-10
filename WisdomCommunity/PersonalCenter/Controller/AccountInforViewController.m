//
//  AccountInforViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AccountInforViewController.h"

@interface AccountInforViewController ()

@end

@implementation AccountInforViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setAccountStyle];
    [self initAccountController];
    
    
    
}
//设置样式
- (void) setAccountStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账户设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [self getAccountData];
}
- (void) getAccountData
{
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    NSLog(@"dict = %@",dictT);
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        self.dataAccountArray = @[[dict objectForKey:@"imgAddress"],[dict objectForKey:@"nickName"],[dict objectForKey:@"trueName"],[NSString stringWithFormat:@"%@",[dict objectForKey:@"idNo"]],[NSString stringWithFormat:@"%@",[dict objectForKey:@"sex"]],[NSString stringWithFormat:@"%@",[dict objectForKey:@"age"]],[NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]],@"",@""];
        [self.accountInforTableView reloadData];
    }
    else
    {
        dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
        self.dataAccountArray = @[[dictT objectForKey:@"imgAddress"],[dictT objectForKey:@"nickName"],[dictT objectForKey:@"trueName"],[NSString stringWithFormat:@"%@",[dictT objectForKey:@"idNo"]],[NSString stringWithFormat:@"%@",[dictT objectForKey:@"sex"]],[NSString stringWithFormat:@"%@",[dictT objectForKey:@"age"]],[NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]],@"",@""];
        [self.accountInforTableView reloadData];
    }
}
//初始化控件
- (void) initAccountController
{
    self.promptAccountArray = @[@"头像",@"用户名",@"真实姓名",@"身份证号",@"性别",@"年龄",@"手机号码",@"我的签到",@"收货地址管理"];
    self.dataAccountArray = @[@"",@"",@"",@"",@"",@"",[CYSmallTools getDataStringKey:ACCOUNT],@"",@""];
    //显示
    self.accountInforTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0,0, CYScreanW, CXCScreanH -64)];
    self.accountInforTableView.delegate = self;
    self.accountInforTableView.dataSource = self;
    self.accountInforTableView.showsVerticalScrollIndicator = NO;
    self.accountInforTableView.scrollEnabled = YES;
    self.accountInforTableView.backgroundColor = [UIColor whiteColor];
    self.accountInforTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.accountInforTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
    UIView *buttonBg =[[UIView alloc]init];
    buttonBg.backgroundColor =[UIColor whiteColor];
    buttonBg.frame =CGRectMake(0, 0, CYScreanW, CYScreanH/5);
    self.exitButton = [[UIButton alloc] init];
    self.exitButton.backgroundColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
    [self.exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    self.exitButton.layer.cornerRadius = 5;
    [self.exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [buttonBg addSubview:self.exitButton];
    _exitButton.frame =CGRectMake(CYScreanW*0.05,30, CYScreanW*0.9, ((CYScreanH - 64) * 0.08));
    _accountInforTableView.tableFooterView =buttonBg;
    
   // [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make)
   //  {
   //     make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
   //    make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
   //    make.height.mas_equalTo((CYScreanH - 64) * 0.06);
   //    make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.1);
   //}];
}
//退出登录
- (void) exitButtonClick
{
    self.exitButton.userInteractionEnabled = NO;
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/logout",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [MBProgressHUD showLoadToView:self.view];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    
    NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStringUTF8 parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        self.exitButton.userInteractionEnabled = YES;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"退出登录请求成功JSON:%@,%@", JSON,[JSON objectForKey:@"error"]);
        //退出成功或者提示异常
        if ([[JSON objectForKey:@"success"] integerValue] == 1 || [CYSmallTools whetherLoginFails:[JSON objectForKey:@"error"] withResult:[JSON objectForKey:@"success"]])
        {
            CYLoginViewController *GoLoController = [[CYLoginViewController alloc] init];
            [self.navigationController pushViewController:GoLoController animated:YES];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.exitButton.userInteractionEnabled = YES;
        NSLog(@"退出登录请求失败:%@", error.description);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
    }];
    
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
    return self.promptAccountArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row!=6)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//右侧箭头

    
    }else
    {
    
        cell.accessoryType= UITableViewCellAccessoryNone;
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0.482 green:0.482 blue:0.482 alpha:1.00];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    cell.textLabel.font = font;
    cell.detailTextLabel.font = font;
    if (indexPath.row == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.promptAccountArray[indexPath.row]];
        //头像
        NSString *headString = [NSString stringWithFormat:@"%@",self.dataAccountArray[indexPath.row]];
        //商品图片
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.92 - (CYScreanH - 64) * 0.06, (CYScreanH - 64) * 0.01, (CYScreanH - 64) * 0.06, (CYScreanH - 64) * 0.06)];
        [imageView3 sd_setImageWithURL:[NSURL URLWithString:headString.length > 6 ? headString : @""] placeholderImage:nil];
        [cell.contentView addSubview:imageView3];
        //圆角
        imageView3.layer.cornerRadius = imageView3.frame.size.width / 2;
        imageView3.clipsToBounds = YES;
    }
    else if (indexPath.row == 4)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.promptAccountArray[indexPath.row]];
        if ([self.dataAccountArray[indexPath.row] integerValue] == 1)
        {
            cell.detailTextLabel.text = @"男";
        }
        else
            cell.detailTextLabel.text = @"女";
    }    else
    {
        NSString *string = [NSString stringWithFormat:@"%@",self.dataAccountArray[indexPath.row]];
        NSLog(@"self.promptAccountArray[indexPath.row] = %@,indexpath = %ld",self.dataAccountArray[indexPath.row],indexPath.row);
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.promptAccountArray[indexPath.row]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[string isEqualToString:@"<null>"] ? @"" : string];
    }
    
    return cell;
    
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    if (indexPath.row == 0)
    {
        SetHeadViewController *SHAController = [[SetHeadViewController alloc] init];
        SHAController.headString = [NSString stringWithFormat:@"%@",self.dataAccountArray[indexPath.row]];
        [self.navigationController pushViewController:SHAController animated:YES];
    }
    else if (indexPath.row == 1)
    {
        SetGeneralAcInforViewController *SGAController = [[SetGeneralAcInforViewController alloc] init];
        SGAController.promptString = self.dataAccountArray[1];
        [self.navigationController pushViewController:SGAController animated:YES];
    }
    else if (indexPath.row == 4)
    {
        SelectSexViewController *SSController = [[SelectSexViewController alloc] init];
        SSController.sexString = [NSString stringWithFormat:@"%@",self.dataAccountArray[4]];
        [self.navigationController pushViewController:SSController animated:YES];
    }
    else if (indexPath.row == 2)
    {
        [self personalChange:self.dataAccountArray[2] withRow:indexPath.row];
    }
    else if (indexPath.row == 3)
    {
        [self personalChange:self.dataAccountArray[3] withRow:indexPath.row];
    }
    else if (indexPath.row == 5)
    {
        [self personalChange:self.dataAccountArray[5] withRow:indexPath.row];
    }
    else if (indexPath.row == 7)
    {
        SeeSignInRecordViewController *SSIRController = [[SeeSignInRecordViewController alloc] init];
        [self.navigationController pushViewController:SSIRController animated:YES];
    }
    else if (indexPath.row == 8)
    {
        AddressManagementViewController *adController = [[AddressManagementViewController alloc] init];
        [self.navigationController pushViewController:adController animated:YES];
    }
}
- (void) personalChange:(NSString *)oldString withRow:(NSInteger)row
{
    RealNameViewController *RNController = [[RealNameViewController alloc] init];
    RNController.typeInt = row;
    RNController.beforeString = [NSString stringWithFormat:@"%@",oldString];
    [self.navigationController pushViewController:RNController animated:YES];
}

@end
