//
//  ProPayResultViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/10.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ProPayResultViewController.h"
#import "ProPaycostViewController.h"
@interface ProPayResultViewController ()

@end

@implementation ProPayResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.promptArray = @[@"订单号",@"缴费账户",@"当前状态",@"支付方式"];
    [self setPPResultStyle];
    [self ProPayConControllers];
}
- (void) viewWillDisappear:(BOOL)animated
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProPaycostViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    [self.ProPayResultTableView removeFromSuperview];
}
- (void) setPPResultStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"缴费结果";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    //左
//    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    btn1.backgroundColor = [UIColor clearColor];
//    [btn1 setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:btn1];
//    self.navigationItem.leftBarButtonItem = buttonLeft;
}
- (void) ProPayConControllers
{
    //缴费详情
    self.ProPayResultTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.ProPayResultTableView.delegate = self;
    self.ProPayResultTableView.dataSource = self;
    self.ProPayResultTableView.scrollEnabled = NO;
    self.ProPayResultTableView.showsVerticalScrollIndicator = NO;
    self.ProPayResultTableView.backgroundColor = BGColor;
    self.ProPayResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.ProPayResultTableView];
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 124*CXCWidth;
    }
    else if (indexPath.row == 1)
    {
        return 220*CXCWidth;
    }
    else if (indexPath.row == 6)
    {
        return 340*CXCWidth;
    }
    else
        return 100*CXCWidth;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellPPCId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.textColor = TEXTColor;
    cell.detailTextLabel.textColor = TextGroColor;
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:14];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 4 && [self.dataArray[4] isEqual:@"缴费失败"])
    {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:255/255.0 green:86/255.0 blue:102/255.0 alpha:1];
    }else if (indexPath.row == 4 && [self.dataArray[4] isEqual:@"缴费成功"])
    {
        cell.detailTextLabel.textColor = NavColor;

    
    
    }
    if (indexPath.row == 0)
    {
        
        cell.contentView .backgroundColor =BGColor;
        if (self.showImage == nil)
        {
            //图标
            self.showImage = [[UIImageView alloc] initWithFrame:CGRectMake(32*CXCWidth, 32*CXCWidth, 60*CXCWidth, 60*CXCWidth)];
            [cell.contentView addSubview:self.showImage];
        }
        if (self.resultLabel == nil)
        {
            //方式
            self.resultLabel = [[UILabel alloc] init];
            self.resultLabel.textColor = [UIColor  colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            self.resultLabel.font = [UIFont fontWithName:@"Arial" size:18];
            self.resultLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:self.resultLabel];
            self.resultLabel.frame = CGRectMake(_showImage.right+12*CXCWidth, 32*CXCWidth,550*CXCWidth , 60*CXCWidth);
            
        }
        if ([self.dataArray[0] integerValue] == 0)
        {
            self.showImage.image = [UIImage imageNamed:@"jiaofei_icon_failure-"];
            self.resultLabel.text = @"缴费失败";
            self.resultLabel.textColor =[UIColor colorWithRed:255/255.0 green:86/255.0 blue:102/255.0 alpha:1];
            
            
        }
        else
        {
            self.showImage.image = [UIImage imageNamed:@"jiaofei_icon_success"];
            self.resultLabel.text = @"缴费成功";
            self.resultLabel.textColor =NavColor;
        }
        
    }
    else if (indexPath.row == 1)
    {
       
        UILabel *monayL =[[UILabel alloc]initWithFrame:CGRectMake(0, 40*CXCWidth, CYScreanW, 80*CXCWidth)];
        [cell.contentView addSubview:monayL];
        NSString *str =[NSString stringWithFormat:@"￥%@",self.dataArray[indexPath.row]];
        
        if (([self.dataArray[0] integerValue] == 0)) {
            monayL.textColor =[UIColor colorWithRed:255/255.0 green:86/255.0 blue:102/255.0 alpha:1];

        }else
        {
            monayL.textColor =NavColor;

        }
        monayL.textAlignment =NSTextAlignmentCenter;
        NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:str];
        monayL.font =[UIFont systemFontOfSize:25];
        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(str.length-2,2)];
        monayL.attributedText =sendMessageString;

        UILabel *detailabel =[[UILabel alloc]initWithFrame:CGRectMake(0, monayL.bottom, CYScreanW, 50*CXCWidth)];
        [cell.contentView addSubview:detailabel];
        
        
        detailabel.text =@"支付金额";
        detailabel.textAlignment =NSTextAlignmentCenter;
        detailabel.textColor =TextGroColor;
        detailabel.font =[UIFont systemFontOfSize:14];
  
    }
    else if (indexPath.row == 6)
    {
        UIButton *backButton = [[UIButton alloc] init];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.layer.cornerRadius = 5;
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        cell.contentView .backgroundColor =BGColor;
        [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:backButton];
        backButton.frame =CGRectMake(30*CXCWidth, 100*CXCWidth, 690*CXCWidth, 100*CXCWidth);
    
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.promptArray[indexPath.row - 2]];
        cell.contentView .backgroundColor =[UIColor whiteColor];

    }
    
    //分割线
    if (indexPath.row != 0 && indexPath.row != 5 && indexPath.row != 6)
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
//返回到查询页面
- (void) backButton:(UIButton *)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProPaycostViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

    
//    
//    UIViewController *viewCtl = self.navigationController.viewControllers[0];
//    [self.navigationController popToViewController:viewCtl animated:YES];
}


@end
