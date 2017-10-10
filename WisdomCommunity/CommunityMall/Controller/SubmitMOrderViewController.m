//
//  SubmitMOrderViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SubmitMOrderViewController.h"

@interface SubmitMOrderViewController ()

@end

@implementation SubmitMOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSuMOStyle];
    [self initSuMOController];
    [self initSuMOModelData];
    
    
}
//初始化数据源
- (void) initSuMOModelData
{
    //初始化
    self.submitModelArray = [[NSMutableArray alloc] init];
    Singleton *goodsSing = [Singleton getSingleton];
    //数据源
    for (NSInteger i = 0; i < goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *parames = [NSDictionary dictionaryWithDictionary:goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [parames objectForKey:@"goods"];
        NSString *price = [NSString stringWithFormat:@"%@",model.moneyString];//单价
        NSString *number = [NSString stringWithFormat:@"%@",[parames objectForKey:@"number"]];//销售量
        NSDictionary *dataDict = @{
                                   @"goodsNameString":[NSString stringWithFormat:@"%@",model.nameString],
                                   @"goodsNumberString":number,
                                   @"goodsMoneyString":[NSString stringWithFormat:@"%.2f",[number floatValue] * [price floatValue]]
                                   };
        SubmitMOrderModel *modelT = [SubmitMOrderModel bodyWithDict:dataDict];
        [self.submitModelArray addObject:modelT];
    }
    [self.confirmOTableView reloadData];
}
//设置样式
- (void) setSuMOStyle
{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"确认订单";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //收货地址管理
    _AddressManController = [[AddressManagementViewController alloc] init];
    //支付页面
    _PayCController = [[PayCenterViewController alloc] init];
}
- (void) viewWillAppear:(BOOL)animated
{
    //显示导航栏
    [self.navigationController.navigationBar setHidden:NO];
    //将购物车隐藏
    for (UIView *view in self.navigationController.view.subviews)
    {
        if ([view isKindOfClass:[UIView class]] && view.tag == 1234)
        {
            view.hidden = YES;
        }
    }
    //如果收货地址为空则获取收货地址，否则使用选择的收货地址
    if (_AddressManController.selectAddressDict == nil)
    {
        if (self.receiveDict)
        {
            [self.receiveButton setTitle:[NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"name"]] forState:UIControlStateNormal];
            _phoneLabel.text = [NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"phone"]];
            [_locationButton setTitle:[NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"address"]] forState:UIControlStateNormal];
        }
        else
        {
            //收货地址,最新添加需要重新获取
            [self getReGoAddressRequest];
        }
    }
    else
    {
        self.receiveDict = _AddressManController.selectAddressDict;//赋值
        _AddressManController.selectAddressDict = nil;//清空
        [self.receiveButton setTitle:[NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"name"]] forState:UIControlStateNormal];
        _phoneLabel.text = [NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"phone"]];
        [_locationButton setTitle:[NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"address"]] forState:UIControlStateNormal];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    //是否取消订单
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count - 2] == self) {
        //当前视图控制器在栈中，故为push操作
        NSLog(@"push");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        NSArray* array =self.navigationController.viewControllers;
        NSLog(@"array = %@",array);
        //判断是不是从订单页进入的
        if ([array[array.count - 1] isKindOfClass:[MerchantsPageViewController class]])
        {
            [self CannelOrderRequest];
        }
        //当前视图控制器不在栈中，故为pop操作
        
        NSLog(@"pop");
    }
}
//初始化控件
- (void) initSuMOController
{
    //显示
    self.confirmOTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64 - CYScreanH * 0.08)];
    self.confirmOTableView.delegate = self;
    self.confirmOTableView.dataSource = self;
    self.confirmOTableView.showsVerticalScrollIndicator = NO;
    self.confirmOTableView.backgroundColor = [UIColor whiteColor];
    self.confirmOTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.confirmOTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //提交订单
    //购物栏
    UIView *shoppingBarView = [[UIView alloc] init];
    shoppingBarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:shoppingBarView];
    [shoppingBarView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.view.mas_bottom).offset(0);
         make.height.mas_equalTo(CYScreanH * 0.08);
     }];
    //商品价格
    UILabel *selectPriceLabel = [[UILabel alloc] init];
    selectPriceLabel.text = [NSString stringWithFormat:@"实付款：￥%.2f",[self.SelectGoodsMoney floatValue]];
    selectPriceLabel.textColor = [UIColor whiteColor];
    [shoppingBarView addSubview:selectPriceLabel];
    [selectPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(shoppingBarView.mas_left).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.5);
         make.top.equalTo(shoppingBarView.mas_top).offset(CYScreanH * 0.01);
         make.height.mas_equalTo(CYScreanH * 0.06);
     }];
    self.selectPriceLabel = selectPriceLabel;
    //按钮
    UIButton *confirmButton = [[UIButton alloc] init];
    [confirmButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [confirmButton addTarget:self action:@selector(NowPayOrder) forControlEvents:UIControlEventTouchUpInside];
    [shoppingBarView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(shoppingBarView.mas_right).offset(0);
         make.width.mas_equalTo(CYScreanW * 0.3);
         make.top.equalTo(shoppingBarView.mas_top).offset(0);
         make.bottom.equalTo(shoppingBarView.mas_bottom).offset(0);
     }];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1)
        {
            return (CYScreanH - 64) * 0.06;
        }
        else
            return (CYScreanH - 64) * 0.14;
    }
    else if (indexPath.section == 2)
    {
        return (CYScreanH - 64) * 0.04;
    }
    else
        return (CYScreanH - 64) * 0.08;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 3;
    }
    else
        return self.submitModelArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    
    if (indexPath.section == 1)
    {
        static NSString *ID = @"submitOCellId";
        self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.cell == nil)
        {
            self.cell = [[SubmitMOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.cell.model = self.submitModelArray[indexPath.row];
        self.cell.backgroundColor = [UIColor whiteColor];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.cell;
    }
    else
    {
        
        static NSString *ID = @"subCellIdT";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //将购物车隐藏
        for (UIView *view in cell.subviews)
        {
            if ([view isKindOfClass:[UILabel class]])
            {
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[UIButton class]])
            {
                [view removeFromSuperview];
            }
        }
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                if (self.receiveButton == nil)
                {
                    //收货人
                    self.receiveButton = [[UIButton alloc] init];
                    self.receiveButton.backgroundColor = [UIColor clearColor];
                    self.receiveButton.titleLabel.font = font;
                    [self.receiveButton setTitle:@"收货人" forState:UIControlStateNormal];
                    [self.receiveButton setTitleColor:[UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00] forState:UIControlStateNormal];
                    [self.receiveButton setImage:[UIImage imageNamed:@"icon_receive_person"] forState:UIControlStateNormal];
                    self.receiveButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
                    self.receiveButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                    self.receiveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    self.receiveButton.userInteractionEnabled = NO;//不可点击
                    [cell.contentView addSubview:self.receiveButton];
                    [self.receiveButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.4);
                     }];
                    //箭头
                    UIImageView *image = [[UIImageView alloc] init];
                    image.image = [UIImage imageNamed:@"icon_arrow_right_gray"];
                    [cell.contentView addSubview:image];
                    [image mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.055);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
                         make.width.mas_equalTo(CYScreanW * 0.02);
                     }];
                    //手机号
                    _phoneLabel = [[UILabel alloc] init];
                    _phoneLabel.textColor = [UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00];
                    _phoneLabel.text = @"手机号";
                    _phoneLabel.textAlignment = NSTextAlignmentRight;
                    _phoneLabel.font = font;
                    [cell.contentView addSubview:_phoneLabel];
                    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(image.mas_left).offset(-CYScreanW * 0.03);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.4);
                     }];
                    //地址
                    _locationButton = [[UIButton alloc] init];
                    _locationButton.backgroundColor = [UIColor clearColor];
                    _locationButton.titleLabel.font = font;
                    [_locationButton setTitle:@"地址" forState:UIControlStateNormal];
                    [_locationButton setTitleColor:[UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00] forState:UIControlStateNormal];
                    [_locationButton setImage:[UIImage imageNamed:@"icon_receive_addr"] forState:UIControlStateNormal];
                    _locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
                    _locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                    _locationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    _locationButton.userInteractionEnabled = NO;//不可点击
                    [cell.contentView addSubview:_locationButton];
                    [_locationButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                         make.top.equalTo(self.receiveButton.mas_bottom).offset(0);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.85);
                     }];
                    //分割线
                    UIImageView *segmentationImmage = [[UIImageView alloc] init];
                    segmentationImmage.backgroundColor = BGColor;
                    [cell.contentView addSubview:segmentationImmage];
                    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(0);
                         make.right.equalTo(cell.mas_right).offset(0);
                         make.bottom.equalTo(cell.mas_bottom).offset(0);
                         make.height.mas_equalTo(1);
                     }];
                }
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.MerchantsDict objectForKey:@"shopName"]];
                cell.textLabel.font = font;
                cell.textLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            }
        }
        else if (indexPath.section == 2)
        {
            cell.detailTextLabel.font = font;//设置字体大小
            if (indexPath.row == 0)
            {
                NSString *busFee = [NSString stringWithFormat:@"%@",[self.MerchantsDict objectForKey:@"busFee"]];
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"运费：￥%@",[busFee isEqualToString:@"<null>"] ? @"0" : busFee];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.624 green:0.624 blue:0.624 alpha:1.00];
                
            }
            else if (indexPath.row == 1)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",[self.SelectGoodsMoney floatValue]];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            }
            else
            {
                if (self.SelectButton == nil)
                {
                    //选择按钮
                    self.SelectButton = [[UIButton alloc] init];
                    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
                    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
                    [cell.contentView addSubview:self.SelectButton];
                    [self.SelectButton addTarget:self action:@selector(agreementSOnClickButton:) forControlEvents:UIControlEventTouchUpInside];
                    self.SelectButton.backgroundColor = [UIColor clearColor];
                    [self.SelectButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(cell.mas_right).offset(- CYScreanW * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.06);
                         make.top.equalTo(cell.mas_top).offset(0);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                     }];
                    //默认不使用积分
                    self.SelectButton.selected = NO;
                    _PayCController.whetherUseScore = @"0";
                    //手机号
                    NSString *totalScore = [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"totalScore"]];
                    NSString *scoreUsed = [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"scoreUsed"]];
                    NSString *score2money = [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"score2money"]];
                    UILabel *label = [[UILabel alloc] init];
                    label.textAlignment = NSTextAlignmentRight;
                    label.textColor = [UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00];
                    label.text = [NSString stringWithFormat:@"当前可使用积分%@,消耗积分%@,抵现%.2f元",[totalScore isEqualToString:@"<null>"] ? @"0" : totalScore,[scoreUsed isEqualToString:@"<null>"] ? @"0" : scoreUsed,[score2money floatValue]];//@"当前可使用积分6000，消耗积分6000，抵现6元";
                    label.font = [UIFont fontWithName:@"Arial" size:11];
                    [cell.contentView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(self.SelectButton.mas_left).offset(- CYScreanW * 0.01);
                         make.width.mas_equalTo(CYScreanW * 0.79);
                         make.top.equalTo(cell.mas_top).offset(0);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
                    }];
                }
            }
        }
        
        return cell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            [self.navigationItem setBackBarButtonItem:backItem];
            
            [self.navigationController pushViewController:_AddressManController animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//积分使用按钮
- (void) agreementSOnClickButton:(UIButton *)sender
{
    if (self.SelectButton.selected == YES)
    {
        self.SelectButton.selected = NO;
        NSString *money = [NSString stringWithFormat:@"实付款：￥%.2f",[self.SelectGoodsMoney floatValue]];
        self.selectPriceLabel.text = [NSString stringWithFormat:@"%@",money];
        _PayCController.whetherUseScore = @"0";
    }
    else
    {
        NSString *socreMoney = [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"score2money"]];
        NSString *money = [NSString stringWithFormat:@"实付款：￥%.2f",[self.SelectGoodsMoney floatValue] - [socreMoney floatValue]];
        self.selectPriceLabel.text = [NSString stringWithFormat:@"%@",money];
        self.SelectButton.selected = YES;
        _PayCController.whetherUseScore = @"1";
    }
    
}
//获取收货地址列表
- (void) getReGoAddressRequest
{
    [MBProgressHUD showLoadToView:self.view];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/expressAddList",POSTREQUESTURL];
    [self requestSubWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"收货地址请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [self initAddressSubmit:[JSON objectForKey:@"returnValue"]];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//找默认收货地址  1.有默认使用默认;2.只有一条即为默认处理;3.多条选择一个默认;
- (void) initAddressSubmit:(NSArray *)array
{
    self.receiveGoodsAddress = array;//收货地址
    //如果没有收货地址
    if (array.count)
    {
        BOOL whetherHaveAddress = NO;//是否找到默认收货地址
        //遍历收货地址获取默认的收货地址
        for (NSDictionary *dict in array)
        {
            if ([[dict objectForKey:@"isDefault"] integerValue] == 1)
            {
                whetherHaveAddress = YES;
                self.receiveDict = [NSDictionary dictionaryWithDictionary:dict];
            }
        }
        //如果不存在,取最后一条作为默认收货地址
        if (whetherHaveAddress == NO)
        {
            self.receiveDict = [NSDictionary dictionaryWithDictionary:[array lastObject]];
        }
        //如果有数据
        if (self.receiveDict)
        {
            NSLog(@"self.receiveDict = %@",self.receiveDict);
            [self.receiveButton setTitle:[NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"name"]] forState:UIControlStateNormal];
            _phoneLabel.text = [NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"phone"]];
            [_locationButton setTitle:[NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"address"]] forState:UIControlStateNormal];
        }
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.confirmOTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
//取消订单
- (void) CannelOrderRequest
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/cancelOrder",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    
    [self requestSubWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"取消订单接口 = %@,%@",JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [MBProgressHUD showError:@"订单已取消" ToView:self.navigationController.view];
        }
    }];
}
//立即支付:绑定收货地址和订单号
- (void) NowPayOrder
{
    if (!self.receiveGoodsAddress.count && !self.receiveDict)
    {
        [MBProgressHUD showError:@"请先添加收货地址" ToView:self.navigationController.view];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        AddressEditViewController *AddController = [[AddressEditViewController alloc] init];
        [self.navigationController pushViewController:AddController animated:YES];
    }
    else
    {
        [MBProgressHUD showLoadToView:self.view];
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/bindOrderAdd",POSTREQUESTURL];
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"id"]        =  [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"id"]];
        parames[@"address"]   =  [NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"address"]];
        parames[@"receiver"]  =  [NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"name"]];
        parames[@"phone"]     =  [NSString stringWithFormat:@"%@",[self.receiveDict objectForKey:@"phone"]];
        NSLog(@"parames = %@",parames);
        [self requestSubWithUrl:requestUrl parames:parames Success:^(id responseObject) {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"立即支付:绑定收货地址和订单号 = %@,%@",JSON,[JSON objectForKey:@"error"]);
            if ([[JSON objectForKey:@"success"] integerValue] == 1)
            {
                [CYSmallTools saveData:self.receiveDict withKey:@"AddressDict"];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
                [self.navigationItem setBackBarButtonItem:backItem];
                _PayCController.payMoney = [NSString stringWithFormat:@"%@",self.selectPriceLabel.text];
                _PayCController.orderMallId = [NSString stringWithFormat:@"%@",[self.OrderDict objectForKey:@"id"]];
                [self.navigationController pushViewController:_PayCController animated:YES];
            }
        }];
    }
}
//数据请求
- (void)requestSubWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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
