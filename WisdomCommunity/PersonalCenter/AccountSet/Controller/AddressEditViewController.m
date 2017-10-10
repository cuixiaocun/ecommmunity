//
//  AddressEditViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AddressEditViewController.h"

@interface AddressEditViewController ()

@end

@implementation AddressEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAddressEStyle];
    [self initAddressEController];
    [self getComData];
}
//设置样式
- (void) setAddressEStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收货地址";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//删除收货地址
- (void) delegateAddress
{
    
}
//初始化控件
- (void) initAddressEController
{
    //显示
    self.EditAddressTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, (CYScreanH - 64) * 0.42)];
    self.EditAddressTableView.delegate = self;
    self.EditAddressTableView.dataSource = self;
    self.EditAddressTableView.showsVerticalScrollIndicator = NO;
    self.EditAddressTableView.scrollEnabled = YES;
    self.EditAddressTableView.backgroundColor = [UIColor whiteColor];
    self.EditAddressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.EditAddressTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //选择小区
    self.SelectComTableView = [[UITableView alloc] init];
    self.SelectComTableView.delegate = self;
    self.SelectComTableView.dataSource = self;
    self.SelectComTableView.layer.cornerRadius = 5;
    self.SelectComTableView.layer.borderColor = [UIColor grayColor].CGColor;
    self.SelectComTableView.layer.borderWidth = 1;
    self.SelectComTableView.showsVerticalScrollIndicator = NO;
    self.SelectComTableView.scrollEnabled = YES;
    self.SelectComTableView.backgroundColor = [UIColor whiteColor];
    self.SelectComTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.SelectComTableView];
    self.SelectComTableView.hidden = YES;
    
    //确定
    UIButton *confirmButton = [[UIButton alloc] init];
    confirmButton.backgroundColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.layer.cornerRadius = 5;
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(addReceiveGoodsRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.04);
     }];
}
//选择小区
- (void) selectComButton:(UIButton *)sender
{
    if (self.SelectComTableView.hidden == YES)
    {
        self.SelectComTableView.hidden = NO;
    }
    else
        self.SelectComTableView.hidden = YES;
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
//设置物业公司布局
- (void) setAButtonLayout:(NSString *)string
{
    CGSize sizeP = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
    [self.SelectComButton setTitle:string forState:UIControlStateNormal];
    self.SelectComButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
    self.SelectComButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
    
}
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignFirstResponderKey];
    self.SelectComTableView.hidden = YES;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.EditAddressTableView)
    {
        if (indexPath.row == 0)
        {
//            return (CYScreanH - 64) * 0.1;
            return (CYScreanH - 64) * 0;

        }
        else
            return (CYScreanH - 64) * 0.08;
    }
    else
    {
        return (CYScreanH - 64) * 0.06;
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.EditAddressTableView)
    {
        return 5;
    }
    else
    {
        return self.SelectComArray.count;
    }
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
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
    if (tableView == self.EditAddressTableView)
    {
        if (indexPath.row == 0)
        {
//            cell.textLabel.text = @"小区选择";
//            self.SelectComButton = [[UIButton alloc] init];
//            [self.SelectComButton setImage:[UIImage imageNamed:@"icon_drop_down"] forState:UIControlStateNormal];
//            [self.SelectComButton setTitleColor:[UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00] forState:UIControlStateNormal];
//            self.SelectComButton.layer.cornerRadius = 5;
//            self.SelectComButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
//            self.SelectComButton.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
//            self.SelectComButton.layer.borderWidth = 1;
//            [self.SelectComButton addTarget:self action:@selector(selectComButton:) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:self.SelectComButton];
//            [self.SelectComButton mas_makeConstraints:^(MASConstraintMaker *make)
//             {
//                 make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//                 make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//                 make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.02);
//                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//             }];
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"详细地址";
            //
            self.detailsAddressTField = [[UITextField alloc] init];
            self.detailsAddressTField.placeholder = @"详细地址";
            self.detailsAddressTField.delegate = self;
            self.detailsAddressTField.font = font;
            self.detailsAddressTField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
            self.detailsAddressTField.backgroundColor = [UIColor clearColor];
            self.detailsAddressTField.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:self.detailsAddressTField];
            [self.detailsAddressTField mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.width.mas_equalTo(CYScreanW * 0.7);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
             }];

        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"收货人姓名";
            self.NameTField = [[UITextField alloc] init];
            self.NameTField.placeholder = @"姓名";
            self.NameTField.delegate = self;
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
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"手机号码";
            self.PhoneTField = [[UITextField alloc] init];
            self.PhoneTField.placeholder = @"手机号";
            self.PhoneTField.delegate = self;
            self.PhoneTField.font = font;
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
        else if(indexPath.row == 4)
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

    }
    else
    {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.SelectComArray[indexPath.row]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]];
    }
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.SelectComTableView.hidden = YES;//隐藏选择小区tableview
    if (tableView == self.SelectComTableView)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.SelectComArray[indexPath.row]];
        self.selectAdComId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        NSString *string = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]];
        //物业公司
        [self setAButtonLayout:string];
    }
    else if (tableView == self.EditAddressTableView)
    {
        if (indexPath.row == 0)
        {
            [self resignFirstResponderKey];
        }
        else if (indexPath.row == 4)
        {
            [self resignFirstResponderKey];
            if (self.defaultButton.selected == NO)
            {
                self.defaultButton.selected = YES;
            }
            else
                self.defaultButton.selected = NO;
        }
    }
}
- (void)resignFirstResponderKey
{
    [self.PhoneTField resignFirstResponder];
    [self.NameTField resignFirstResponder];
    [self.detailsAddressTField resignFirstResponder];
}
//获取小区数据
- (void) getComData
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStringUTF8 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        self.SelectComArray = [NSArray arrayWithArray:[[JSON objectForKey:@"param"] objectForKey:@"comList"]];
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            if (self.SelectComArray.count > 0)
            {
                [self setSecComView:self.SelectComArray];
            }
            else
                [MBProgressHUD showError:@"没有社区数据" ToView:self.view];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}
- (void) setSecComView:(NSArray *)array
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[0]];
    self.selectAdComId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    NSString *string = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]];
    //物业公司
    [self setAButtonLayout:string];
    self.SelectComTableView.frame = CGRectMake( CYScreanW * 0.3, (CYScreanH - 64) * 0.08, CYScreanW * 0.67, (CYScreanH - 64) * 0.06 * array.count);
    [self.SelectComTableView reloadData];
}
//添加收货地址
- (void) addReceiveGoodsRequest
{
    if (self.detailsAddressTField.text.length && self.NameTField.text.length && self.PhoneTField.text.length)
    {
        if ([CYWhetherPhone isValidPhone:self.PhoneTField.text])
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
            parames[@"address"]   =  [NSString stringWithFormat:@"%@",self.detailsAddressTField.text];
            parames[@"isDefault"] =  self.defaultButton.selected == YES ? @"1":@"0";
            NSLog(@"parames = %@",parames);
            //url
            NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/addExpressAdd",POSTREQUESTURL];
            NSLog(@"requestUrl = %@",requestUrl);
            [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 [MBProgressHUD hideHUDForView:self.view];
                 NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
                 if ([[JSON objectForKey:@"success"] integerValue] == 1)
                 {
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
        else
            [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
    }
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
