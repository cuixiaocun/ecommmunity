//
//  ProPayCConfirmViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/10.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ProPayCConfirmViewController.h"

@interface ProPayCConfirmViewController ()

@end
@implementation ProPayCConfirmViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self ProPayConControllers];
    [self setPPCCStyle];
}
- (void) viewWillAppear:(BOOL)animated
{
}
- (void) viewWillDisappear:(BOOL)animated
{
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count - 2] == self) {
        //当前视图控制器在栈中，故为push操作
        NSLog(@"push");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        [self cannelOrderRequest:@"back"];
        NSLog(@"pop");
    }
}
- (void) setPPCCStyle
{
    self.view.backgroundColor = BGColor;
    self.navigationItem.title = @"确认缴费";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
- (void) ProPayConControllers
{
    //支付结果
    self.ProPayController = [[ProPayResultViewController alloc] init];
    //支付结果
    ProPayResultViewController *PPRController = [[ProPayResultViewController alloc] init];
    //缴费详情
    self.ProPayConfirmTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0,0, CYScreanW, CXCWidth*700)];
    self.ProPayConfirmTableView.delegate = self;
    self.ProPayConfirmTableView.dataSource = self;
    self.ProPayConfirmTableView.scrollEnabled = YES;
    self.ProPayConfirmTableView.showsVerticalScrollIndicator = NO;
    self.ProPayConfirmTableView.backgroundColor = [UIColor whiteColor];
    self.ProPayConfirmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ProPayConfirmTableView];
    UIView *bottomV =[[UIView alloc]initWithFrame:CGRectMake( 0,CXCScreanH-64-300*CXCWidth, CYScreanW, 300*CXCWidth)];
    bottomV.backgroundColor =BGColor;
    
    [self.view addSubview:bottomV];
    
    //立即缴费
    self.ImmediatePaymentButton = [[UIButton alloc] init];
    [self.ImmediatePaymentButton setTitle:@"立即缴费" forState:UIControlStateNormal];
    [self.ImmediatePaymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.ImmediatePaymentButton.layer.cornerRadius = 5;
    self.ImmediatePaymentButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [self.ImmediatePaymentButton addTarget:self action:@selector(showPayTypeButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:self.ImmediatePaymentButton];
    _ImmediatePaymentButton.frame =CGRectMake(30*CXCWidth, 100*CXCWidth, 690*CXCWidth,100*CXCWidth );
    //提示
    UIButton *promptButton = [[UIButton alloc] init];
    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
//    [promptButton setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];

    promptButton.backgroundColor = [UIColor clearColor];
    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [bottomV addSubview:promptButton];
    promptButton.frame =CGRectMake(30*CXCWidth, 220*CXCWidth, 690*CXCWidth,50*CXCWidth );
    promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.shadowImage = [[UIImageView alloc] init];
//    self.shadowImage.image = [UIImage imageNamed:@"222支付"];
//    [bottomV addSubview:self.shadowImage];
//    _shadowImage.frame =CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    [self.shadowImage mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.equalTo(self.view.mas_left).offset(0);
//        make.width.mas_equalTo(CYScreanW);
//        make.bottom.equalTo(self.view.mas_bottom).offset(0);
//        make.height.mas_equalTo((CYScreanH - 64) * 0.43);
//    }];
//    self.shadowImage.hidden = YES;
  }
//使用积分
- (void) useIntegralButton:(UIButton *)sender
{
    NSString *score2money = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"score2money"]];
    if (self.useIntegralButton.selected == NO)
    {
        self.useIntegralButton.selected = YES;
        self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[self.priceLabel.text substringFromIndex:1] floatValue]- [score2money floatValue]];
    }
    else
    {
        self.useIntegralButton.selected = NO;
        self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[self.priceLabel.text substringFromIndex:1] floatValue] + [score2money floatValue]];
    }
    
}
// - - - - -- - - - -- - - -- - - - - -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.selectPayTypeTableView)
    {
        if (indexPath.row == 0)
        {
            return 96*CXCWidth;
        }
        else if (indexPath.row == 1)
        {
            return 220*CXCWidth;
        }
        else
            return 135*CXCWidth;
    }
    else
        if (indexPath.row==2) {
            return 120*CXCWidth;
        }
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
    if (tableView == self.selectPayTypeTableView)
    {
        return 5;
    }
    else
        return 7;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (tableView == self.selectPayTypeTableView)
    {
        static NSString *ID = @"cellPPCId";
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
//        //分割线
        

        if (indexPath.row == 0)
        {
            UILabel *detailabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, 96*CXCWidth)];
            [cell.contentView addSubview:detailabel];
            detailabel.text =@"请选择支付方式";
            detailabel.textAlignment =NSTextAlignmentCenter;
            detailabel.textColor =TEXTColor;
            detailabel.font =[UIFont systemFontOfSize:14];
            detailabel.textAlignment =NSTextAlignmentCenter;
            
            //x按钮
            self.detelBtn = [[UIButton alloc] initWithFrame:CGRectMake(690*CXCWidth, 32*CXCWidth, 30*CXCWidth, 30*CXCWidth)];
            [self.detelBtn setBackgroundImage:[UIImage imageNamed:@"pay_icon_close"] forState:UIControlStateNormal];
            [self.detelBtn setBackgroundImage:[UIImage imageNamed:@"pay_icon_close"] forState: UIControlStateSelected];
            [cell.contentView addSubview:self.detelBtn];
            [self.detelBtn addTarget:self action:@selector(hiddenBtn) forControlEvents:UIControlEventTouchUpInside];
            self.detelBtn.backgroundColor = [UIColor clearColor];
            
            
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = BGColor;
            [cell.contentView addSubview:segmentationImmage];
            segmentationImmage.frame =CGRectMake(0, 95*CXCWidth, CYScreanW, CXCWidth);
        }
        else if (indexPath.row == 1)
        {
            UILabel *monayL =[[UILabel alloc]initWithFrame:CGRectMake(0, 40*CXCWidth, CYScreanW, 80*CXCWidth)];
            [cell.contentView addSubview:monayL];
            monayL.text =_priceLabel.text;
           NSString *str =_priceLabel.text;
            monayL.textColor =NavColor;
            monayL.tag =333;
            monayL.textAlignment =NSTextAlignmentCenter;
//            NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:_priceLabel.text];
            
//            monayL.backgroundColor =[UIColor redColor];
            monayL.font =[UIFont systemFontOfSize:25];
//            NSLog(@"%d",_priceLabel.text.length);
//            
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
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = BGColor;
            [cell.contentView addSubview:segmentationImmage];
            segmentationImmage.frame =CGRectMake(0,219*CXCWidth, CYScreanW, CXCWidth);
        }
        else if (indexPath.row == 2)
        {
            
            self.orderType = @"alipay";
            //图标
            UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(32*CXCWidth, 32*CXCWidth, 70*CXCWidth, 70*CXCWidth)];
            headImage.image = [UIImage imageNamed:@"pay_icon_alipay"];
            [cell.contentView addSubview:headImage];
            //方式
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text = @"支付宝支付";
            nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
            [cell.contentView addSubview:nameLabel];
            nameLabel.frame =CGRectMake(headImage.right+24*CXCWidth,32*CXCWidth, 300*CXCWidth, 40*CXCWidth);
            
            //描述
            UILabel *promptLabel = [[UILabel alloc] init];
            promptLabel.text = @"支持有支付宝账号的用户使用";
            promptLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
            promptLabel.font = [UIFont fontWithName:@"Arial" size:12];
            [cell.contentView addSubview:promptLabel];
            
            promptLabel.frame =CGRectMake(headImage.right+24*CXCWidth,nameLabel.bottom, 600*CXCWidth, 40*CXCWidth);
//            cell.contentView.backgroundColor =[UIColor blueColor];
            
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*CXCWidth, 25*CXCWidth,30*CXCWidth , 50*CXCWidth)];
            [cell addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = BGColor;
            [cell.contentView addSubview:segmentationImmage];
            segmentationImmage.frame =CGRectMake(0, 134*CXCWidth, CYScreanW, CXCWidth);
        }
        else if (indexPath.row == 3)
        {
            
            //图标
            UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(32*CXCWidth, 32*CXCWidth, 70*CXCWidth, 70*CXCWidth)];
            headImage.image = [UIImage imageNamed:@"pay_icon_weChat"];
            [cell.contentView addSubview:headImage];
            //方式
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text = @"微信支付";
            nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
            [cell.contentView addSubview:nameLabel];
            //描述
            UILabel *promptLabel = [[UILabel alloc] init];
            promptLabel.text = @"推荐已安装微信的用户使用";
            promptLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
            promptLabel.font = [UIFont fontWithName:@"Arial" size:12];
            [cell.contentView addSubview:promptLabel];
            nameLabel.frame =CGRectMake(headImage.right+24*CXCWidth,32*CXCWidth, 300*CXCWidth, 40*CXCWidth);
            promptLabel.frame =CGRectMake(headImage.right+24*CXCWidth,nameLabel.bottom, 600*CXCWidth, 40*CXCWidth);
            UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*CXCWidth, 25*CXCWidth,30*CXCWidth , 50*CXCWidth)];
            [cell addSubview:jiantou];
            [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = BGColor;
            [cell.contentView addSubview:segmentationImmage];
            segmentationImmage.frame =CGRectMake(0,134*CXCWidth, CYScreanW, CXCWidth);

            }else
            {
            
                //方式
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                nameLabel.textColor = [UIColor blackColor];
                nameLabel.text = @"";
                nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
                [cell.contentView addSubview:nameLabel];
                
                
            }
        return cell;
    }
    else
    {
        static NSString *ID = @"cellPPCId2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.textLabel.textColor =TEXTColor;
        cell.detailTextLabel.textColor = TextGroColor;
        
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:14];
        
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *promptArray = @[@"户名",@"手机号",@"住址信息",@"缴费单位",@"缴费金额"];
        if(tableView == self.ProPayConfirmTableView && indexPath.row < 6)
        {
            //分割线
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = BGColor;
            [cell.contentView addSubview:segmentationImmage];
                    if (indexPath.row==2) {
                        segmentationImmage.frame =CGRectMake(0, 100*CXCWidth, CYScreanW, 20*CXCWidth);
                        
            }else
                
                segmentationImmage.frame =CGRectMake(0, 100*CXCWidth, CYScreanW, 1*CXCWidth);

        }
        if (indexPath.row == 4)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",promptArray[indexPath.row]];
            self.priceLabel = [[UILabel alloc] init];
            self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.proPayConArray[indexPath.row]];
            self.priceLabel.font = [UIFont fontWithName:@"Arial" size:12];
            self.priceLabel.textAlignment = NSTextAlignmentRight;
           self.priceLabel.textColor = TextGroColor;
            [cell.contentView addSubview:self.priceLabel];
            [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.6);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];        }
        else if (indexPath.row == 5)
        {
            
            //选择阅读协议按钮
            self.useIntegralButton = [[UIButton alloc] init];
            [self.useIntegralButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
            [self.useIntegralButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
            [cell.contentView addSubview:self.useIntegralButton];
            [self.useIntegralButton addTarget:self action:@selector(useIntegralButton:) forControlEvents:UIControlEventTouchUpInside];
            self.useIntegralButton.backgroundColor = [UIColor clearColor];
            [self.useIntegralButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.width.mas_equalTo(CYScreanW * 0.06);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             }];
            self.useIntegralButton.selected = NO;
            
            
            //积分
            NSString *totalScore = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"totalScore"]];
            NSString *scoreUsed = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"scoreUsed"]];
            NSString *score2money = [NSString stringWithFormat:@"%@",[self.orderDetailsDict objectForKey:@"score2money"]];
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"可用积分%.0f,消耗积分%.0f,抵现%.2f元",[totalScore floatValue],[scoreUsed floatValue],[score2money floatValue]];
            label.font = [UIFont fontWithName:@"Arial" size:14];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = TEXTColor;

            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CXCWidth*30);
                 make.width.mas_equalTo(CYScreanW);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo(100*CXCWidth);
             }];
        }
        else if (indexPath.row == 6)
        {
            cell.contentView.backgroundColor =BGColor;
            //选择阅读协议按钮
            self.agreementPPCButton = [[UIButton alloc] init];
            [self.agreementPPCButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
            [self.agreementPPCButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
            [cell.contentView addSubview:self.agreementPPCButton];
            [self.agreementPPCButton addTarget:self action:@selector(agreementOnOClickButton:) forControlEvents:UIControlEventTouchUpInside];
            self.agreementPPCButton.backgroundColor = [UIColor clearColor];
            [self.agreementPPCButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.04);
                 make.width.mas_equalTo(CYScreanW * 0.06);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.01);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             }];
            self.agreementPPCButton.selected = YES;
            //协议
            UIButton *agreementButton = [[UIButton alloc] init];
            [agreementButton setTitle:@"同意《瀧璟智慧社区使用条款与隐私规则》" forState:UIControlStateNormal];
            agreementButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
            agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左
            [agreementButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [cell.contentView addSubview:agreementButton];
            [agreementButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(self.agreementPPCButton.mas_right).offset(CYScreanW * 0.01);
                 make.right.equalTo(cell.mas_right).offset(- CYScreanW * 0.05);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
             }];
            NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:agreementButton.titleLabel.text];
            [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.255 green:0.557 blue:0.910 alpha:1.00] range:NSMakeRange(2,17)];

            
            
            agreementButton.titleLabel.attributedText = sendMessageString;
        }
        else
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.proPayConArray[indexPath.row]];
            cell.detailTextLabel.textColor=TextGroColor;
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",promptArray[indexPath.row]];
        }
        return cell;

    }
    
    return nil;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _selectPayTypeTableView)
    {
        if (indexPath.row == 2)
        {
            self.selectPayTreasureButton.hidden = NO;
            self.selectWeChatButton.hidden = YES;
            self.orderType = @"alipay";
            
            [self ProPayRequest];
            
            
            
        }
        else if (indexPath.row == 3)
        {
            self.selectPayTreasureButton.hidden = YES;
            self.selectWeChatButton.hidden = NO;
            self.orderType = @"wx";
            [self ProPayRequest];

        }
    }
    else
    {
//        self.selectPayTypeTableView.hidden = YES;
//        self.shadowImage.hidden = YES;
    }
}
//是否遵循协议按钮
- (void) agreementOnOClickButton:(UIButton *)sender
{
    if (self.agreementPPCButton.selected == YES)
    {
        self.ImmediatePaymentButton.backgroundColor = [UIColor grayColor];
        self.ImmediatePaymentButton.userInteractionEnabled = NO;
        self.agreementPPCButton.selected = NO;
    }
    else
    {
        self.ImmediatePaymentButton.userInteractionEnabled = YES;
        self.ImmediatePaymentButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        self.agreementPPCButton.selected = YES;
    }
}

//显示支付选择页面
- (void) showPayTypeButton
{
    if(!_selectPayTypeTableView)
    {
    
        self.shadowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, CXCScreanH)];
        self.shadowImage.backgroundColor =[UIColor blackColor];
        _shadowImage.alpha =0.3;
        [self.view addSubview:self.shadowImage];
        //支付方式列表
        self.selectPayTypeTableView = [[UITableView alloc] init];
        self.selectPayTypeTableView.delegate = self;
        self.selectPayTypeTableView.dataSource = self;
        self.selectPayTypeTableView.scrollEnabled = NO;
        self.selectPayTypeTableView.showsVerticalScrollIndicator = NO;
        self.selectPayTypeTableView.backgroundColor = [UIColor whiteColor];
        self.selectPayTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.selectPayTypeTableView];
    
        [self.selectPayTypeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
            make.height.mas_equalTo(700*CXCWidth);
        }];
        
        
    
    }
    
    self.shadowImage.hidden = NO;
    self.selectPayTypeTableView.hidden = NO;
//    [self.selectPayTypeTableView reloadData];
    UILabel *lab =[self.view viewWithTag:333];
    lab.text =_priceLabel.text;
//    lab.text =@"2";

}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.shadowImage.hidden = YES;
//    self.selectPayTypeTableView.hidden = YES;
}
//发起支付
- (void) ProPayRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //
//    self.shadowImage.hidden = YES;
//    self.selectPayTypeTableView.hidden = YES;
    
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"type"]        =  [NSString stringWithFormat:@"%@",self.orderType];;//
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderId];
    parames[@"useScore"]    =  [NSString stringWithFormat:@"%@",self.useIntegralButton.selected == YES ? @"1" : @"0"];
    NSLog(@"parames = %@",parames);
    //url  
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/pay",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"支付成功");
             self.chargeDict = [NSDictionary dictionaryWithDictionary:[[JSON objectForKey:@"param"] objectForKey:@"charge"]];
             [self wakeUpPingWithCharge:[[JSON objectForKey:@"param"] objectForKey:@"charge"]];
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

- (void)wakeUpPingWithCharge:(NSDictionary *)charge
{
    NSString *kURLScheme = @"BridgeworldWisdomCommunity";
    [Pingpp createPayment:charge
           viewController:self.ProPayController
             appURLScheme:kURLScheme
           withCompletion:^(NSString *result, PingppError *error) {
               if ([result isEqualToString:@"success"]){
                   // 支付成功
                   NSLog(@"支付成功");
                   [self paySayResult];
               }else{
                   // 支付失败或取消
                   NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                   [self paySayResult];
               }
           }];
}

//注册成为监听者
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        //注册成为监听者
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySayResult:) name:@"payResult" object:nil];
    }
    return self;
}
//声明通知
- (void)paySayResult//:(NSNotification *)payNotificat
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"charge_id"]   =  [NSString stringWithFormat:@"%@",[self.chargeDict objectForKey:@"id"]];;//
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/paySelect",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         NSString *type = [[NSString alloc] init];
         if ([self.orderType isEqual:@"alipay"])
         {
             type = @"支付宝";
         }
         else
         {
             type = @"微信";
         }
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"后台支付成功");
             self.ProPayController.dataArray = @[@"1",self.proPayConArray[4],self.orderId,self.proPayConArray[2],@"缴费成功",type,@"返回"];
         }
         else
         {
             self.ProPayController.dataArray = @[@"0",self.proPayConArray[4],self.orderId,self.proPayConArray[2],@"缴费失败",type,@"返回缴费"];;
             NSLog(@"后台支付失败");
             [self cannelOrderRequest:@"cancel"];
         }
         //跳转
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
         [self.navigationItem setBackBarButtonItem:backItem];
         [self.navigationController pushViewController:self.ProPayController animated:YES];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"后台支付结果请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payResult" object:nil];
}

//取消订单
- (void) cannelOrderRequest:(NSString *)type
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"id"]          =  [NSString stringWithFormat:@"%@",self.orderId];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/cancelPopOrder",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
        
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"取消订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             if ([type isEqualToString:@"back"])
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }
         else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"取消订单请求失败:%@", error.description);
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)hiddenBtn
{

    self.selectPayTypeTableView.hidden = YES;
    self.shadowImage.hidden = YES;

}
//拨打电话
- (void) callPropertyPhone
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", [CYSmallTools getDataStringKey:PROPERTYCPHONE]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
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
