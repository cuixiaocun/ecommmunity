//
//  PayDetailViewController.m
//  WisdomCommunity
//
//  Created by Admin on 2017/5/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "PayDetailViewController.h"

@interface PayDetailViewController ()<UITableViewDelegate,UITableViewDataSource,OnClickProPayDelegate>
{
    NSMutableArray *monthArr ;

}

@end

@implementation PayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yuanArray =[[NSMutableArray alloc]init];
    self.yuanArray =self.proPayModelArray;
    [self setProPayStyle];
    [self mainView];
    [self dictPPCTurnModel:_proPayModelArray];
    self.selectPayMonthArray = [[NSMutableArray alloc] init];
}
//转模型
- (void) dictPPCTurnModel:(NSArray *)array
{
    //没有缴费信息则显示没有
       self.proPayModelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array)
        {
            //记录小区编号和年份
//            self.communityId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"comNo"]];
//            self.yearString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"year"]];
            NSDictionary *dict2 = @{
                                    @"timeString":[dict objectForKey:@"month"],
                                    @"costOneString":[dict objectForKey:@"cheWeiFei"],
                                    @"costTwoString":[dict objectForKey:@"laJiChuLiFei"],
                                    @"costThreeString":[dict objectForKey:@"lvHuaChuLiFei"],
                                    @"costFourString":[dict objectForKey:@"wuYeFei"],
                                    @"stateString":[dict objectForKey:@"status"]
                                    };
            ProPayModel *model = [ProPayModel bodyWithDict:dict2];
            [self.proPayModelArray addObject:model];
        }
      
  }
- (void)mainView
{
   
    NSArray*  wenziArr =@[@"缴费地址",@"查询年份"];
    for (int i=0; i<2; i++) {
        //大按钮
        UIButton *cell = [[UIButton alloc]init];
        cell.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:cell];
        cell.frame = CGRectMake(0, 0+100*CXCWidth*i, CYScreanW, 100*CXCWidth);
        
        //左边文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32*CXCWidth, 0, 400*CXCWidth, 99*CXCWidth)];
        label.text = wenziArr[i];
        label.textColor = TEXTColor;
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        //右边文字
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(270*CXCWidth, 0, 450*CXCWidth, 99*CXCWidth)];
        label2.textColor = TextGroColor;
        label2.textAlignment =NSTextAlignmentRight;
        label2.font = [UIFont systemFontOfSize:13];
        [cell addSubview:label2];
        label2.tag =110+i;
        if (i==0) {
            label2.text =_house;
        }else{
            label2.text =[NSString stringWithFormat:@"%@",[self.yuanArray [0] objectForKey:@"year"]];
        }
        cell.tag =990+i;
        UIImageView *imagV3 = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 99*CXCWidth,710*CXCWidth,1*CXCWidth)];
        [imagV3 setBackgroundColor:BGColor];
        [cell addSubview:imagV3];
    }
    //缴费明细
    self.payDetailTableview = [[UITableView alloc] init];
    self.payDetailTableview.delegate = self;
    self.payDetailTableview.dataSource = self;
    self.payDetailTableview.showsVerticalScrollIndicator = NO;
    self.payDetailTableview.layer.cornerRadius = 5;
    self.payDetailTableview.backgroundColor = [UIColor whiteColor];
    self.payDetailTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.payDetailTableview];
    self.payDetailTableview.frame =CGRectMake(0,200*CXCWidth +20*CXCWidth, CYScreanW,CYScreanH-64-CXCWidth*200-300*CXCWidth );
    
    
    UIView *  bottomView= [[UIView alloc]initWithFrame:CGRectMake(0, CXCScreanH-520*CXCScreanH-64,CYScreanW ,CXCWidth*300)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor =BGColor;
    
    //立即缴费
    self.complaintsButton = [[UIButton alloc] init];
    [self.complaintsButton setTitle:@"立即缴费" forState:UIControlStateNormal];
    [self.complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complaintsButton.layer.cornerRadius = 5;
    self.complaintsButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:19];
    self.complaintsButton.backgroundColor = [UIColor colorWithRed:0.463 green:0.463 blue:0.471 alpha:1.00];
    [self.complaintsButton addTarget:self action:@selector(generatePayOrder) forControlEvents:UIControlEventTouchUpInside];
    self.complaintsButton.userInteractionEnabled = NO;
    [self.view addSubview:self.complaintsButton];
    [self.complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.1);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    //提示
    UIButton *promptButton = [[UIButton alloc] init];
    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
//    [promptButton setImage:[UIImage imageNamed:@"icon_pro_tel"] forState:UIControlStateNormal];//
    promptButton.backgroundColor = [UIColor clearColor];
    [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];
    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:promptButton];
    [promptButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.top.equalTo(self.complaintsButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
     }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500*CXCWidth;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return _proPayModelArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"payCellId";
    self.payCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.payCell == nil)
    {
        self.payCell = [[ProPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.proPayModelArray[indexPath.row]);
    self.payCell.delegate = self;
    self.payCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.payCell.model = self.proPayModelArray[indexPath.row];
    self.payCell.backgroundColor = [UIColor whiteColor];
    return self.payCell;
    

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    
    
    
    
    
}
- (void) setProPayStyle
{
    self.view.backgroundColor=BGColor;
    self.navigationItem.title = @"物业缴费明细";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//计算缴费金额 +
- (void) addComputingMoney:(ProPayModel *) model
{
    NSLog(@"选择 = %@",model.timeString);
    [self.selectPayMonthArray addObject:model];
    NSLog(@"self.selectPayMonthArray = %@",self.selectPayMonthArray);
    //选择了数据
    if (self.selectPayMonthArray.count)
    {
        self.complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        self.complaintsButton.userInteractionEnabled = YES;
    }
    else
    {
        self.complaintsButton.backgroundColor = [UIColor colorWithRed:0.463 green:0.463 blue:0.471 alpha:1.00];
        self.complaintsButton.userInteractionEnabled = NO;
    }
}
//计算缴费金额 -
- (void) remComputingMoney:(ProPayModel *) model
{
    NSLog(@"选择 = %@",model.timeString);
    [self.selectPayMonthArray removeObject:model];
    NSLog(@"self.selectPayMonthArray = %@",self.selectPayMonthArray);
    //选择了数据
    if (self.selectPayMonthArray.count)
    {
        self.complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        self.complaintsButton.userInteractionEnabled = YES;
    }
    else
    {
        self.complaintsButton.backgroundColor = [UIColor colorWithRed:0.463 green:0.463 blue:0.471 alpha:1.00];
        self.complaintsButton.userInteractionEnabled = NO;
    }
}

//生成支付订单
- (void) generatePayOrder
{
    [MBProgressHUD showLoadToView:self.view];
    //缴费金额
    NSString *money = [[NSString alloc] init];
    //缴费月数
    NSString *month = [[NSString alloc] init];
    for (ProPayModel *model in self.selectPayMonthArray)
    {
        if (month.length) {
            month = [NSString stringWithFormat:@"%@,%@",month,model.timeString];
        }
        else
            month = [NSString stringWithFormat:@"%@",model.timeString];
        money = [NSString stringWithFormat:@"%.2f",([model.costOneString floatValue] + [model.costTwoString floatValue] + [model.costThreeString floatValue] + [model.costFourString floatValue] + [money integerValue])];
    }
    NSString *trueName = [[CYSmallTools getDataKey:PERSONALDATA] objectForKey:@"trueName"];
   
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"build"]       =  [NSString stringWithFormat:@"%@",[self.yuanArray [0] objectForKey:@"build"]];;//
    parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[self.yuanArray [0] objectForKey:@"comNo"]];
    parames[@"year"]        =  [NSString stringWithFormat:@"%@",[self.yuanArray [0] objectForKey:@"year"]];//
    parames[@"payMonth"]    =  [NSString stringWithFormat:@"%@",month];;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/popcostOrder",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"支付订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"支付订单生成成功");
             UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
             [self.navigationItem setBackBarButtonItem:backItem];
             _ppccController =[[ProPayCConfirmViewController alloc]init];
             //显示数据
             self.ppccController.proPayConArray = @[trueName,[CYSmallTools getDataStringKey:ACCOUNT],_house,self.proPay,money];
             NSLog(@"month = %@,money = %@",month,money);
             self.ppccController.orderId = [[JSON objectForKey:@"returnValue"] objectForKey:@"id"];
             self.ppccController.orderDetailsDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
             [self.navigationController pushViewController:self.ppccController animated:YES];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"支付订单请求失败:%@", error.description);
     }];
}
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
