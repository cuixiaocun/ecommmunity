//
//  AddressUpdateViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/24.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AddressUpdateViewController.h"

@interface AddressUpdateViewController ()

@end

@implementation AddressUpdateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAddressUStyle];
    [self initAddressUController];
    
}
//设置样式
- (void) setAddressUStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收货地址";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //右
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [messageBtn addTarget:self action:@selector(delegateAddress) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setTitle:@"删除" forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem = buttonRight;
}
//删除收货地址
- (void) delegateAddress
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  [NSString stringWithFormat:@"%@",[self.ReceiveAddressDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/delExpressAdd",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [MBProgressHUD showError:@"删除成功" ToView:self.navigationController.view];
             [self.navigationController popViewControllerAnimated:YES];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
     }];
}
//初始化控件
- (void) initAddressUController
{
    //显示
    self.EditAddressTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.32)];
    self.EditAddressTableView.delegate = self;
    self.EditAddressTableView.dataSource = self;
    self.EditAddressTableView.showsVerticalScrollIndicator = NO;
    self.EditAddressTableView.scrollEnabled = YES;
    self.EditAddressTableView.backgroundColor = [UIColor whiteColor];
    self.EditAddressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.EditAddressTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //确定
    UIButton *confirmButton = [[UIButton alloc] init];
    confirmButton.backgroundColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.layer.cornerRadius = 5;
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(editReceiveGoodsRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.04);
     }];
}
//是否设置为默认
- (void) whetherDefault
{
    if (self.defaultButton.selected == NO)
    {
        self.defaultButton.selected = YES;
    }
    else
        self.defaultButton.selected = NO;
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//内容将要发生改变编辑,编辑完使用return退出
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignFirstResponderAUTest];
}
- (void) resignFirstResponderAUTest
{
    [self.PhoneTField resignFirstResponder];
    [self.NameTField resignFirstResponder];
    [self.detailsAddressTView resignFirstResponder];
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
    return 4;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:13];
    static NSString *ID = @"EditCelliD";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = font;
    cell.textLabel.textColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"详细地址";
        //
        self.detailsAddressTView = [[UITextView alloc] init];
        self.detailsAddressTView.delegate = self;
        self.detailsAddressTView.font = font;
        self.detailsAddressTView.text = [NSString stringWithFormat:@"%@",[self.ReceiveAddressDict objectForKey:@"address"]];
        self.detailsAddressTView.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
        self.detailsAddressTView.backgroundColor = [UIColor clearColor];
        self.detailsAddressTView.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:self.detailsAddressTView];
        [self.detailsAddressTView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
             make.top.equalTo(cell.mas_top).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.7);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
         }];
        
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"收货人姓名";
        self.NameTField = [[UITextField alloc] init];
        self.NameTField.placeholder = @"姓名";
        self.NameTField.delegate = self;
        self.NameTField.text = [NSString stringWithFormat:@"%@",[self.ReceiveAddressDict objectForKey:@"name"]];
        self.NameTField.font = font;
        self.NameTField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
        self.NameTField.backgroundColor = [UIColor clearColor];
        self.NameTField.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:self.NameTField];
        [self.NameTField mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
             make.top.equalTo(cell.mas_top).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.7);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
         }];
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"手机号码";
        self.PhoneTField = [[UITextField alloc] init];
        self.PhoneTField.placeholder = @"手机号";
        self.PhoneTField.delegate = self;
        self.PhoneTField.font = font;
        self.PhoneTField.text = [NSString stringWithFormat:@"%@",[self.ReceiveAddressDict objectForKey:@"phone"]];
        self.PhoneTField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
        self.PhoneTField.backgroundColor = [UIColor clearColor];
        self.PhoneTField.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:self.PhoneTField];
        [self.PhoneTField mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
             make.top.equalTo(cell.mas_top).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.7);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
         }];
    }
    else if(indexPath.row == 3)
    {
        self.defaultButton = [[UIButton alloc] init];
        [self.defaultButton setImage:[UIImage imageNamed:@"icon_selected_bg"] forState:UIControlStateNormal];
        [self.defaultButton setImage:[UIImage imageNamed:@"icon_selected_withbg"] forState:UIControlStateSelected];
        [self.defaultButton addTarget:self action:@selector(whetherDefault) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.defaultButton];
        [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
             make.width.mas_equalTo((CYScreanH - 64) * 0.04);
             make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        //设置默认标签
        if ([[self.ReceiveAddressDict objectForKey:@"isDefault"] integerValue] == 1)
        {
            self.defaultButton.selected = YES;
        }
        else
            self.defaultButton.selected = NO;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"设为默认收货地址";
        label.font = font;
        label.textColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.defaultButton.mas_right).offset(CYScreanW * 0.02);
             make.width.mas_equalTo((CYScreanH - 64) * 0.5);
             make.top.equalTo(cell.mas_top).offset(0);
             make.bottom.equalTo(cell.mas_bottom).offset(0);;
         }];
    }
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [cell.contentView addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(cell.mas_left).offset(0);
         make.right.equalTo(cell.mas_right).offset(0);
         make.top.equalTo(cell.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];

    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        [self resignFirstResponderAUTest];
        if (self.defaultButton.selected == NO)
        {
            self.defaultButton.selected = YES;
        }
        else
            self.defaultButton.selected = NO;
    }
}
//编辑收货地址
- (void) editReceiveGoodsRequest
{
    if (self.detailsAddressTView.text.length && self.NameTField.text.length && [CYWhetherPhone isValidPhone:self.PhoneTField.text])
    {
        [MBProgressHUD showLoadToView:self.view];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"name"]      =  [NSString stringWithFormat:@"%@",self.NameTField.text];
        parames[@"phone"]     =  [NSString stringWithFormat:@"%@",self.PhoneTField.text];
        parames[@"address"]   =  [NSString stringWithFormat:@"%@",self.detailsAddressTView.text];
        parames[@"id"]        =  [NSString stringWithFormat:@"%@",[self.ReceiveAddressDict objectForKey:@"id"]];
        parames[@"isDefault"] =  self.defaultButton.selected == YES ? @"1":@"0";
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/updateExpressAdd",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [MBProgressHUD showError:@"修改成功" ToView:self.navigationController.view];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
                 [MBProgressHUD showError:@"加载出错" ToView:self.view];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"请求失败:%@", error.description);
         }];
    }
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
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
