//
//  OrderDetailsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface OrderDetailsViewController ()

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setOrderDeStyle];
    [self initOrderDeControls];
    
    [self getOrderDetailsRequest];
    
}
//设置样式
- (void) setOrderDeStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backButtonODVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = buttonLeft;
}
- (void) backButtonODVC
{
    NSArray* array =self.navigationController.viewControllers;
    NSLog(@"array[0] = %@",array);
    //判断是不是从订单页进入的
    if ([array[array.count - 2] isKindOfClass:[MallPayReViewController class]])
    {
        //回到外卖首页
        UIViewController *viewCtl = self.navigationController.viewControllers[0];
        [self.navigationController popToViewController:viewCtl animated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化数据源
- (void) initOrderDeData:(NSArray *)array
{
    //初始化
    self.MyOrderAllDataArray = [[NSMutableArray alloc] init];
    //数据源
    for (NSInteger i = 0; i < array.count; i ++)
    {
        NSDictionary *goodsDict = [NSDictionary dictionaryWithDictionary:array[i]];
        NSDictionary *dataDict = @{
                                   @"goodsNameString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"productName"]],
                                   @"goodsNumberString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"productnum"]],
                                   @"goodsMoneyString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"total"]]
                                   };
        OrderDetailsModel *model = [OrderDetailsModel bodyWithDict:dataDict];
        [self.MyOrderAllDataArray addObject:model];
    }
    [self.OrderMTableView reloadData];
}

//初始化首页控件
- (void) initOrderDeControls
{
    [self.OrderMTableView removeFromSuperview];
    //显示
    self.OrderMTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.OrderMTableView.delegate = self;
    self.OrderMTableView.dataSource = self;
    self.OrderMTableView.showsVerticalScrollIndicator = NO;
    self.OrderMTableView.backgroundColor = [UIColor whiteColor];
    self.OrderMTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.OrderMTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1)
        {
            return (CYScreanH - 64) * 0.08;
        }
        else
        {
            return (CYScreanH - 64) * 0.06;
        }
    }
    else if (indexPath.section == 1)
    {
        return (CYScreanH - 64) * 0.14;
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            return (CYScreanH - 64) * 0.08;
        }
        else
            return (CYScreanH - 64) * 0.04;
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0 || indexPath.row == 6)
        {
            return (CYScreanH - 64) * 0.01;
        }
        else
            return (CYScreanH - 64) * 0.04;
    }
    else
    {
        if (indexPath.row == 3)
        {
            return (CYScreanH - 64) * 0.15;
        }
        else if (indexPath.row == 0)
        {
            return (CYScreanH - 64) * 0.01;
        }
        else
            return (CYScreanH - 64) * 0.04;
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return self.MyOrderAllDataArray.count + 1;
    }
    else if (section == 3)
    {
        return 7;
    }
    else
    {
        return 4;
    }
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    if (indexPath.section == 2 && indexPath.row != 0)
    {
        static NSString *ID = @"submitOCellId";
        self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.cell == nil)
        {
            self.cell = [[OrderDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.cell.model = self.MyOrderAllDataArray[indexPath.row - 1];
        self.cell.backgroundColor = [UIColor whiteColor];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.cell;
    }
    else
    {
        NSInteger process = [[self.OrderDetailsDict objectForKey:@"process"] integerValue];//状态标签
        static NSString *ID = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
        cell.textLabel.textColor = [UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0)
        {
            cell.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            if (indexPath.row == 0)
            {
                if (self.receiveOrderButton == nil && self.OrderDetailsDict)
                {
                    //收货人
                    self.receiveOrderButton = [[UIButton alloc] init];
                    self.receiveOrderButton.titleLabel.font = font;
                    self.receiveOrderButton.backgroundColor = [UIColor clearColor];
                    [self.receiveOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.receiveOrderButton setImage:[UIImage imageNamed:@"icon_book_done_bg"] forState:UIControlStateNormal];
                    self.receiveOrderButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
                    self.receiveOrderButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                    self.receiveOrderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    self.receiveOrderButton.userInteractionEnabled = NO;//不可点击
                    [cell.contentView addSubview:self.receiveOrderButton];
                    [self.receiveOrderButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.8);
                     }];
                    switch (process) {
                        case 1:
                            [self.receiveOrderButton setTitle:@"等待商家接单" forState:UIControlStateNormal];
                            break;
                        case 2:
                            [self.receiveOrderButton setTitle:@"商家已接单" forState:UIControlStateNormal];
                            break;
                        case 3:
                            [self.receiveOrderButton setTitle:@"商家拒单" forState:UIControlStateNormal];
                            break;
                        case 4:
                            [self.receiveOrderButton setTitle:@"订单已完成" forState:UIControlStateNormal];
                            break;
                        case 5:
                            [self.receiveOrderButton setTitle:@"订单已取消" forState:UIControlStateNormal];
                            break;
                        case 6:
                            [self.receiveOrderButton setTitle:@"订单未支付" forState:UIControlStateNormal];
                            break;
                        case 7:
                            [self.receiveOrderButton setTitle:@"订单已取消,等待退款" forState:UIControlStateNormal];
                            break;
                        default:
                            break;
                    }
                }
            }
            else
            {
                if (process == 3 || process == 1 || process == 5 || process == 6 || process == 7)
                {
                    self.StateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, (CYScreanH - 64) * 0.08)];
                    self.StateView.backgroundColor = [UIColor clearColor];
                    [cell.contentView addSubview:self.StateView];
                    UIImageView *imageView = [[UIImageView alloc] init];
                    imageView.backgroundColor = [UIColor whiteColor];
                    [self.StateView addSubview:imageView];
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(self.StateView.mas_left).offset(CYScreanW * 0.4);
                         make.top.equalTo(self.StateView.mas_top).offset((CYScreanH - 64) * 0.02 - 0.5);
                         make.width.mas_equalTo(CYScreanW * 0.2);
                         make.height.mas_equalTo(1);
                     }];
                    UIImageView *leftImageView = [[UIImageView alloc] init];
                    leftImageView.image = [UIImage imageNamed:@"icon_order_round"];
                    [self.StateView addSubview:leftImageView];
                    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(imageView.mas_left).offset(0);
                         make.top.equalTo(self.StateView.mas_top).offset((CYScreanH - 64) * 0.015);
                         make.width.mas_equalTo((CYScreanH - 64) * 0.01);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.01);
                     }];
                    UIImageView *rightImageView = [[UIImageView alloc] init];
                    rightImageView.image = [UIImage imageNamed:@"icon_order_round"];
                    [self.StateView addSubview:rightImageView];
                    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(imageView.mas_right).offset(0);
                         make.top.equalTo(self.StateView.mas_top).offset((CYScreanH - 64) * 0.015);
                         make.width.mas_equalTo((CYScreanH - 64) * 0.01);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.01);
                     }];
                    //
                    UILabel *label = [[UILabel alloc] init];
                    label.font = [UIFont fontWithName:@"Arial" size:10];
                    label.textColor = [UIColor whiteColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = @"订单已提交";
                    [self.StateView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(self.StateView.mas_left).offset(CYScreanW * 0.3);
                         make.top.equalTo(self.StateView.mas_top).offset((CYScreanH - 64) * 0.03);
                         make.width.mas_equalTo(CYScreanW * 0.2);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
                     }];
                    UILabel *RefusedLabel = [[UILabel alloc] init];
                    RefusedLabel.font = [UIFont fontWithName:@"Arial" size:10];
                    RefusedLabel.textColor = [UIColor whiteColor];
                    RefusedLabel.textAlignment = NSTextAlignmentCenter;
                    if (process == 3)
                    {
                        RefusedLabel.text = @"商家拒单";
                    }
                    else if (process == 5 || process == 7)
                    {
                        RefusedLabel.text = @"订单取消";
                    }
                    else if (process == 6)
                    {
                        RefusedLabel.text = @"订单未支付";
                    }
                    else
                        RefusedLabel.text = @"等待商家接单";
                    [self.StateView addSubview:RefusedLabel];
                    [RefusedLabel mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(self.StateView.mas_right).offset(-CYScreanW * 0.3);
                         make.top.equalTo(self.StateView.mas_top).offset((CYScreanH - 64) * 0.03);
                         make.width.mas_equalTo(CYScreanW * 0.2);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
                     }];
                }
                else if (process > 0)
                {
                    UIImageView *imageView = [[UIImageView alloc] init];
                    imageView.backgroundColor = [UIColor whiteColor];
                    [cell addSubview:imageView];
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.3);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02 - 0.5);
                         make.width.mas_equalTo(CYScreanW * 0.4);
                         make.height.mas_equalTo(1);
                     }];
                    UIImageView *leftImageView = [[UIImageView alloc] init];
                    leftImageView.image = [UIImage imageNamed:@"icon_order_round"];
                    [cell addSubview:leftImageView];
                    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(imageView.mas_left).offset(0);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
                         make.width.mas_equalTo((CYScreanH - 64) * 0.01);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.01);
                     }];
                    UIImageView *rightImageView = [[UIImageView alloc] init];
                    rightImageView.image = [UIImage imageNamed:@"icon_order_round"];
                    [cell addSubview:rightImageView];
                    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(imageView.mas_right).offset(0);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
                         make.width.mas_equalTo((CYScreanH - 64) * 0.01);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.01);
                     }];
                    UIImageView *middleImageView = [[UIImageView alloc] init];
                    middleImageView.image = [UIImage imageNamed:@"icon_order_round"];
                    [cell addSubview:middleImageView];
                    [middleImageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.495);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
                         make.width.mas_equalTo((CYScreanH - 64) * 0.01);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.01);
                     }];
                    //
                    UILabel *label = [[UILabel alloc] init];
                    label.font = [UIFont fontWithName:@"Arial" size:10];
                    label.textColor = [UIColor whiteColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = @"订单已提交";
                    [cell.contentView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.2);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.03);
                         make.width.mas_equalTo(CYScreanW * 0.2);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
                     }];
                    UILabel *rightlabel = [[UILabel alloc] init];
                    rightlabel.font = [UIFont fontWithName:@"Arial" size:10];
                    rightlabel.textColor = [UIColor whiteColor];
                    rightlabel.textAlignment = NSTextAlignmentCenter;
                    [cell.contentView addSubview:rightlabel];
                    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.4);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.03);
                         make.width.mas_equalTo(CYScreanW * 0.2);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
                     }];
                    UILabel *middleLabel = [[UILabel alloc] init];
                    middleLabel.font = [UIFont fontWithName:@"Arial" size:10];
                    middleLabel.textColor = [UIColor whiteColor];
                    middleLabel.textAlignment = NSTextAlignmentCenter;
                    [cell.contentView addSubview:middleLabel];
                    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.2);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.03);
                         make.width.mas_equalTo(CYScreanW * 0.2);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
                     }];
                    if (process == 2)
                    {
                        rightlabel.text = @"商家已接单";
                        middleLabel.text = @"等待送达";
                    }
                    else if (process == 4)
                    {
                        rightlabel.text = @"商家已接单";
                        middleLabel.text = @"已送达";
                    }
                }
            }
        }
        else if (indexPath.section == 1)
        {
            if (self.receivePOButton == nil && self.OrderDetailsDict)
            {
                NSString *receiver = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"receiver"]];//姓名
                NSString *address = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"address"]];//地址
                //收货人
                self.receivePOButton = [[UIButton alloc] init];
                self.receivePOButton.backgroundColor = [UIColor clearColor];
                [self.receivePOButton setTitle:[NSString stringWithFormat:@"收货人:%@",[receiver isEqualToString:@"<null>"] ? @"未添加" : receiver] forState:UIControlStateNormal];
                self.receivePOButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
                [self.receivePOButton setTitleColor:[UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00] forState:UIControlStateNormal];
                [self.receivePOButton setImage:[UIImage imageNamed:@"icon_receive_person"] forState:UIControlStateNormal];
                self.receivePOButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
                self.receivePOButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                self.receivePOButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                self.receivePOButton.userInteractionEnabled = NO;//不可点击
                [cell.contentView addSubview:self.receivePOButton];
                [self.receivePOButton mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                     make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                     make.width.mas_equalTo(CYScreanW * 0.6);
                 }];
                //地址
                UIButton *locationButton = [[UIButton alloc] init];
                locationButton.backgroundColor = [UIColor clearColor];
                locationButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
                [locationButton setTitle:[address isEqualToString:@"<null>"] ? @"未添加" : address forState:UIControlStateNormal];
                [locationButton setTitleColor:[UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00] forState:UIControlStateNormal];
                [locationButton setImage:[UIImage imageNamed:@"icon_receive_addr"] forState:UIControlStateNormal];
                locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
                locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                locationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                locationButton.userInteractionEnabled = NO;//不可点击
                [cell.contentView addSubview:locationButton];
                [locationButton mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                     make.top.equalTo(self.receivePOButton.mas_bottom).offset(0);
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
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 0)
            {
                if (self.OrderDetailsDict)
                {
                    UIImageView *imageView = [[UIImageView alloc] init];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.OrderDetailsDict objectForKey:@"shopImg"]]];
                    [cell.contentView addSubview:imageView];
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                         make.width.mas_equalTo((CYScreanH - 64) * 0.06);
                         make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
                     }];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( CYScreanW * 0.1, 0, CYScreanW * 0.9, (CYScreanH - 64) * 0.04)];
                    label.font = [UIFont fontWithName:@"Arial" size:15];
                    label.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                    label.text = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"shopName"]];
                    [cell.contentView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(imageView.mas_right).offset(CYScreanW * 0.02);
                        make.height.and.top.equalTo(imageView);
                        make.width.mas_equalTo(CYScreanW * 0.5);
                    }];
                }
            }
        }
        else if (indexPath.section == 3)
        {
            NSString *useScoreString = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"useScore"]];
             cell.detailTextLabel.textColor = [UIColor colorWithRed:0.925 green:0.600 blue:0.098 alpha:1.00];
            if (indexPath.row == 6)
            {
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
            else if (indexPath.row == 1)
            {
                cell.textLabel.text = @"商品总价";
                NSString *totalMoney = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"totalMoney"]];
                NSString *busFee = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"busFee"]];
                if ([totalMoney isEqualToString:@"<null>"] && [busFee isEqualToString:@"<null>"])
                {
                    cell.detailTextLabel.text = @"￥0.00";
                }
                else if ([busFee isEqualToString:@"<null>"])
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",[[self.OrderDetailsDict objectForKey:@"totalMoney"] floatValue]];
                }
                else if ([totalMoney isEqualToString:@"<null>"])
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",[[self.OrderDetailsDict objectForKey:@"busFee"] floatValue]];
                }
                else
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",[[self.OrderDetailsDict objectForKey:@"totalMoney"] floatValue] - [[self.OrderDetailsDict objectForKey:@"busFee"] floatValue]];
                }
            }
            else if (indexPath.row == 2)
            {
                cell.textLabel.text = @"活动";
                NSString *cutInfoString = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"cutInfo"]];
                if ([cutInfoString isEqualToString:@"<null>"])
                {
                    cell.detailTextLabel.text = @"-¥0.00";
                }
                else
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"-%@",[self.OrderDetailsDict objectForKey:@"cutInfo"]];
            }
            else if (indexPath.row == 3)
            {
                cell.textLabel.text = @"配送费";
                NSString *busFeeString = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"busFee"]];
                if ([busFeeString isEqualToString:@"<null>"])
                {
                    cell.detailTextLabel.text = @"¥0.00";
                }
                else
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"+￥%@",[self.OrderDetailsDict objectForKey:@"busFee"]];
            }
            else if (indexPath.row == 4)
            {
                cell.textLabel.text = @"积分抵现";
                
                if (![useScoreString isEqual:@"<null>"] && [useScoreString integerValue] == 1)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"-￥%@",[self.OrderDetailsDict objectForKey:@"score2money"]];
                }
                else
                {
                    cell.detailTextLabel.text = @"-¥0.00";
                }
            }
            else if (indexPath.row == 5)
            {
                cell.textLabel.text = @"实付款";
                if (![useScoreString isEqual:@"<null>"] && [useScoreString integerValue] == 1)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",[[self.OrderDetailsDict objectForKey:@"nowMoney"] floatValue] - [[self.OrderDetailsDict objectForKey:@"score2money"] floatValue]];
                }
                else if((![useScoreString isEqual:@"<null>"]) && ([useScoreString integerValue] !=1))
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",[self.OrderDetailsDict objectForKey:@"nowMoney"]];

                }else
                {
                    cell.detailTextLabel.text =@"无";

                
                }
                
            }
        }
        else if (indexPath.section == 4)
        {
            if (indexPath.row == 3)
            {
                if (process == 1)
                {
                    //查看订单
                    UIButton *SOrderButton = [[UIButton alloc] init];
                    [SOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    SOrderButton.layer.cornerRadius = 5;
                    [SOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
                    SOrderButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                    [SOrderButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:SOrderButton];
                    [SOrderButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.width.mas_equalTo(CYScreanW * 0.9);
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }];
                }
                else if (process == 2)
                {
                    //确认收货
                    _confirmButton = [[UIButton alloc] init];
                    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    _confirmButton.layer.cornerRadius = 5;
                    [_confirmButton setTitle:@"确认收货" forState:UIControlStateNormal];
                    _confirmButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                    [_confirmButton addTarget:self action:@selector(confirmReceiveGoods) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:_confirmButton];
                    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.width.mas_equalTo(CYScreanW * 0.9);
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }];
                }
                else if (process == 3 || process == 5 || process == 7)
                {
                    //再来一单
                    UIButton *backButton = [[UIButton alloc] init];
                    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    backButton.layer.cornerRadius = 5;
                    [backButton setTitle:@"再来一单" forState:UIControlStateNormal];
                    backButton.backgroundColor = [UIColor colorWithRed:0.925 green:0.600 blue:0.098 alpha:1.00];
                    [backButton addTarget:self action:@selector(buttonLeftClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:backButton];
                    [backButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.9);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }]; 
                }
                else if (process == 4)
                {
                    //再来一单
                    UIButton *backButton = [[UIButton alloc] init];
                    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    backButton.layer.cornerRadius = 5;
                    [backButton setTitle:@"再来一单" forState:UIControlStateNormal];
                    backButton.backgroundColor = [UIColor colorWithRed:0.925 green:0.600 blue:0.098 alpha:1.00];
                    [backButton addTarget:self action:@selector(buttonLeftClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:backButton];
                    [backButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.4);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }];
                    //查看订单
                    UIButton *SOrderButton = [[UIButton alloc] init];
                    [SOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    SOrderButton.layer.cornerRadius = 5;
                    [SOrderButton setTitle:@"去评价" forState:UIControlStateNormal];
                    SOrderButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                    [SOrderButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:SOrderButton];
                    [SOrderButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.width.mas_equalTo(CYScreanW * 0.4);
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }];
                }
                else if (process == 6)
                {
                    //取消订单
                    UIButton *backButton = [[UIButton alloc] init];
                    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    backButton.layer.cornerRadius = 5;
                    [backButton setTitle:@"取消订单" forState:UIControlStateNormal];
                    backButton.backgroundColor = [UIColor colorWithRed:0.925 green:0.600 blue:0.098 alpha:1.00];
                    [backButton addTarget:self action:@selector(CancelPayOrder) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:backButton];
                    [backButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                         make.width.mas_equalTo(CYScreanW * 0.4);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }];
                    //去支付
                    UIButton *SOrderButton = [[UIButton alloc] init];
                    [SOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    SOrderButton.layer.cornerRadius = 5;
                    [SOrderButton setTitle:@"去支付" forState:UIControlStateNormal];
                    SOrderButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                    [SOrderButton addTarget:self action:@selector(GoToPayOrder) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:SOrderButton];
                    [SOrderButton mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.width.mas_equalTo(CYScreanW * 0.4);
                         make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                         make.bottom.equalTo(cell.mas_bottom).offset(-20*CXCWidth);
                         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                     }];
                }
            }
            else if(indexPath.row == 1)
            {
                cell.textLabel.text = @"订单号";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"NO.%@",[self.OrderDetailsDict objectForKey:@"id"]];
            }
            else if(indexPath.row == 2)
            {
                cell.textLabel.text = @"下单时间";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"gmtCreate"]];
            }
        }
        return cell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
            MPController.MerchantsId = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"shopId"]];
            [self.navigationController pushViewController:MPController animated:YES];
        }
    }
}
//左侧
- (void) buttonLeftClick:(UIButton *)sender
{
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    MPController.MerchantsId = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"shopId"]];
    NSLog(@"MPController.MerchantsId = %@",MPController.MerchantsId);
    [self.navigationController pushViewController:MPController animated:YES];
}
//右侧
- (void) buttonClick:(UIButton *)sender
{
    if ([[self.OrderDetailsDict objectForKey:@"process"] integerValue] == 1)//取消订单
    {
        [self cannelOrderRequest];
    }
    else if ([[self.OrderDetailsDict objectForKey:@"process"] integerValue] == 4)//去评价
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        SendCommentViewController *sendController = [[SendCommentViewController alloc] init];
        sendController.shopId = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"shopId"]];
        [self.navigationController pushViewController:sendController animated:YES];
    }
}
//确认收货
- (void) confirmReceiveGoods
{
    [MBProgressHUD showLoadToView:self.view];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  self.selectOrderId;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/receiveOrder",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestODWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"确认收货请求成功JSON = %@,%@",JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [MBProgressHUD showError:@"已确认收货" ToView:self.navigationController.view];
            [self backButtonODVC];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//取消订单->未支付
- (void) CancelPayOrder
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/cancelOrder",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    
    [self requestODWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"取消订单接口 = %@,%@",JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [MBProgressHUD showError:@"订单已取消" ToView:self.navigationController.view];
            [self backButtonODVC];
        }
        else
            [MBProgressHUD showError:@"取消失败" ToView:self.view];
    }];
}
//去支付
- (void) GoToPayOrder
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    SubmitMOrderViewController *SMOController = [[SubmitMOrderViewController alloc] init];
    SMOController.OrderDict = [NSDictionary dictionaryWithDictionary:self.OrderDetailsDict];
    SMOController.MerchantsDict = [NSDictionary dictionaryWithDictionary:self.OrderDetailsDict];
    SMOController.SelectGoodsMoney = [NSString stringWithFormat:@"%@",[self.OrderDetailsDict objectForKey:@"nowMoney"]];
    [self.navigationController pushViewController:SMOController animated:YES];
}
//取消订单->退款接口
- (void) cannelOrderRequest
{
    [MBProgressHUD showLoadToView:self.view];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"id"]        =  self.selectOrderId;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/refundApply",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [self requestODWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"退款接口请求成功JSON = %@,%@",JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [MBProgressHUD showError:@"订单已取消,等待退款" ToView:self.navigationController.view];
            [self backButtonODVC];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//获取订单详情
- (void) getOrderDetailsRequest
{
    [MBProgressHUD showLoadToView:self.view];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]        =  self.selectOrderId;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/orderDetail",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    [self requestODWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取订单详情请求成功JSON = %@",JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            self.OrderDetailsDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
            [self initOrderDeData:[self.OrderDetailsDict objectForKey:@"detailList"]];
//            [self.OrderMTableView reloadData];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//数据请求
- (void)requestODWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
