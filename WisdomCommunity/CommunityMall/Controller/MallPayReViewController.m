//
//  MallPayReViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MallPayReViewController.h"

@interface MallPayReViewController ()

@end

@implementation MallPayReViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    self.promptMallArray = @[@"订单号",@"下单时间",@"当前状态",@"支付方式"];
    [self setPPResultStyle];
    [self ProPayConControllers];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self.MallPayResultTableView removeFromSuperview];
}
- (void) setPPResultStyle
{
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"缴费结果";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
   // [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backButtonMPR) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    
    
    
    
    self.navigationItem.leftBarButtonItem = buttonLeft;
}
- (void) ProPayConControllers
{
    //缴费详情
    self.MallPayResultTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.MallPayResultTableView.delegate = self;
    self.MallPayResultTableView.dataSource = self;
    self.MallPayResultTableView.scrollEnabled = NO;
    self.MallPayResultTableView.showsVerticalScrollIndicator = NO;
    self.MallPayResultTableView.backgroundColor = [UIColor whiteColor];
    self.MallPayResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MallPayResultTableView];
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1)
    {
        return (CYScreanH - 64) * 0.08;
    }
    else if (indexPath.row == 6 || indexPath.row == 7)
    {
        return (CYScreanH - 64) * 0.2;
    }
    else
        return (CYScreanH - 64) * 0.06;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"mallPCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 4 && [self.dataMallArray[4] isEqual:@"缴费失败"])
    {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.957 green:0.561 blue:0.271 alpha:1.00];
    }
    //收货信息
    NSDictionary *dict = [CYSmallTools getDataKey:@"AddressDict"];
    if (indexPath.row == 0)
    {
        if (self.showImage == nil)
        {
            //图标
            self.showImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.4, (CYScreanH - 64) * 0.025, CYScreanW * 0.045, (CYScreanH - 64) * 0.03)];
            
            [cell.contentView addSubview:self.showImage];
        }
        if (self.resultLabel == nil)
        {
            //方式
            self.resultLabel = [[UILabel alloc] init];
            self.resultLabel.textColor = [UIColor  colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            
            self.resultLabel.font = [UIFont fontWithName:@"Arial" size:15];
            self.resultLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:self.resultLabel];
            [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(self.showImage.mas_right).offset(CYScreanW * 0.03);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.width.mas_equalTo (CYScreanW * 0.5);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
             }];
        }
        
        
        if ([self.dataMallArray[0] isEqualToString:@"0"])
        {
            self.showImage.image = [UIImage imageNamed:@"icon_failed_withbg"];
            
            self.resultLabel.text = @"缴费失败";
        }
        else
        {
            self.showImage.image = [UIImage imageNamed:@"icon_selected_withbg"];
            self.resultLabel.text = @"缴费成功";
        }
        
    }
    else if (indexPath.row == 1)
    {
        //描述
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.text = [NSString stringWithFormat:@"%@",self.dataMallArray[indexPath.row]];;
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.textColor = [UIColor  colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        promptLabel.font = [UIFont fontWithName:@"Arial" size:26];
        [cell.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(cell.mas_left).offset(0);
             make.width.mas_equalTo (CYScreanW);
             make.top.equalTo(cell.mas_top).offset(0);
             make.bottom.equalTo(cell.mas_bottom).offset(0);
         }];
    }
    else if (indexPath.row == 6)
    {
        if (self.receivePButton == nil)
        {
            //收货人
            self.receivePButton = [[UIButton alloc] init];
            self.receivePButton.backgroundColor = [UIColor clearColor];
            [self.receivePButton setTitle:[NSString stringWithFormat:@"收货人:%@",[dict objectForKey:@"name"]] forState:UIControlStateNormal];
            self.receivePButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
            [self.receivePButton setTitleColor:[UIColor colorWithRed:0.345 green:0.353 blue:0.357 alpha:1.00] forState:UIControlStateNormal];
            [self.receivePButton setImage:[UIImage imageNamed:@"icon_receive_person"] forState:UIControlStateNormal];
            self.receivePButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
            self.receivePButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            self.receivePButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.receivePButton.userInteractionEnabled = NO;//不可点击
            [cell.contentView addSubview:self.receivePButton];
            [self.receivePButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.07);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.5);
             }];
            //手机号
            UILabel *phoneLabel = [[UILabel alloc] init];
            phoneLabel.textColor = [UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00];
            phoneLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"phone"]];
            phoneLabel.textAlignment = NSTextAlignmentRight;
            phoneLabel.font = [UIFont fontWithName:@"Arial" size:13];
            [cell.contentView addSubview:phoneLabel];
            [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.07);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.4);
             }];
            //地址
            UIButton *locationButton = [[UIButton alloc] init];
            locationButton.backgroundColor = [UIColor clearColor];
            locationButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
            [locationButton setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"address"]]  forState:UIControlStateNormal];
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
                 make.top.equalTo(self.receivePButton.mas_bottom).offset(0);
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
    else if (indexPath.row == 7)
    {
        
        //只有支付成功才有查看订单
        if ([self.dataMallArray[0] isEqualToString:@"1"])
        {
            //再来一单
            UIButton *backButton = [[UIButton alloc] init];
            [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            backButton.layer.cornerRadius = 5;
            [backButton setTitle:@"再来一单" forState:UIControlStateNormal];
            backButton.backgroundColor = [UIColor colorWithRed:0.925 green:0.600 blue:0.098 alpha:1.00];
            [backButton addTarget:self action:@selector(backButtonMPR) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:backButton];
            [backButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.4);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
            //查看订单
            UIButton *SOrderButton = [[UIButton alloc] init];
            [SOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            SOrderButton.layer.cornerRadius = 5;
            [SOrderButton setTitle:@"查看订单" forState:UIControlStateNormal];
            SOrderButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            [SOrderButton addTarget:self action:@selector(checkOrder) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:SOrderButton];
            [SOrderButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.width.mas_equalTo(CYScreanW * 0.4);
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
        }
        else
        {
            //再来一单
            UIButton *backButton = [[UIButton alloc] init];
            [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            backButton.layer.cornerRadius = 5;
            [backButton setTitle:@"再来一单" forState:UIControlStateNormal];
            backButton.backgroundColor = [UIColor colorWithRed:0.925 green:0.600 blue:0.098 alpha:1.00];
            [backButton addTarget:self action:@selector(backButtonMPR) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:backButton];
            [backButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.9);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
        }
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.dataMallArray[indexPath.row]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.promptMallArray[indexPath.row - 2]];
    }
    //分割线
    if (indexPath.row != 0 && indexPath.row != 7)
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
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//返回
- (void) backButtonMPR
{
    //回到外卖首页
    UIViewController *viewCtl = self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:viewCtl animated:YES];
}
//查看订单
- (void) checkOrder
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    OrderDetailsViewController *ODController = [[OrderDetailsViewController alloc] init];
    ODController.selectOrderId = self.orderId;
    [self.navigationController pushViewController:ODController animated:YES];
}
@end
