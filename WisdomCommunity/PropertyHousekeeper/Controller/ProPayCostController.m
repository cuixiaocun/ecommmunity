//
//  ProPayCostController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业缴费

#import "ProPayCostController.h"

@interface ProPayCostController ()

@end

@implementation ProPayCostController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ProComArray =[[NSArray alloc]init];
    _showYearArray =[[NSMutableArray alloc]init];
    _choosePAddArray =[[NSMutableArray alloc]init];
    

    [self setProPayStyle];
    [self initProPayControllers];
    
    [self initDataPeripheralModel];
    
    [self getHousePlist];
    
}
//设置样式
- (void) setProPayStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物业缴费查询";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//初始化数据
- (void) initDataPeripheralModel
{
    self.ppccController = [[ProPayCConfirmViewController alloc] init];
    //
    Singleton *ProPaySing = [Singleton getSingleton];
    ProPaySing.selectProPayMonthArray = [[NSMutableArray alloc] init];
    //缴费月份
    self.selectPayMonthArray = [[NSMutableArray alloc] init];
//tableviewcell数据源
    self.proPayDatalArray = [[NSMutableArray alloc] init];
    self.proPayModelArray = [[NSMutableArray alloc] init];
    
    
    
//年份
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    // 获取各时间字段的数值
    NSLog(@"现在是%ld年" , comp.year);
    self.showYearArray = [[NSMutableArray alloc] init];
    for (NSInteger i = comp.year; i >= 2010; i --)
    {
        [self.showYearArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    NSLog(@"self.showYearArray = %@",self.showYearArray);
    [self.timeButton setTitle:[NSString stringWithFormat:@"%ld",comp.year] forState:UIControlStateNormal];
    [self.YearTableView reloadData];
    
}
//转模型
- (void) dictPPCTurnModel:(NSArray *)array
{
    //没有缴费信息则显示没有
    if (array.count)
    {
        self.proPayModelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array)
        {
            //记录小区编号和年份
            self.communityId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"comNo"]];
            self.yearString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"year"]];
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
        self.showImmage.hidden = YES;
        self.promptLabel.hidden = YES;
        self.PeripheralSTableView.hidden = NO;
        //刷新
        [self.PeripheralSTableView reloadData];
    }
    else
    {
        self.showImmage.hidden = NO;
        self.promptLabel.hidden = NO;
        self.PeripheralSTableView.hidden = YES;
    }
}
- (void) initProPayControllers
{
    
    NSArray*  wenziArr =@[@"缴费地址",@"查询年份"];
    for (int i=0; i<2; i++) {
        
        //大按钮
        UIButton *cell = [[UIButton alloc]init];
        if(i<4)
        {
            cell.frame = CGRectMake(0, 0+100*CXCWidth*i, CYScreanW, 100*CXCWidth);
        }
        [cell addTarget:self action:@selector(cellBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:cell];
        //左边文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32*CXCWidth, 0, 400*CXCWidth, 99*CXCWidth)];
        label.text = wenziArr[i];
        label.textColor = TEXTColor;
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        
        //右边文字
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(250*CXCWidth, 0, 420*CXCWidth, 99*CXCWidth)];
        label2.textColor = TextGroColor;
        label2.text =@"12345678";
        label2.textAlignment =NSTextAlignmentRight;
        label2.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label2];
        label2.tag =110+i;
        UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*CXCWidth, 25*CXCWidth,30*CXCWidth , 50*CXCWidth)];
        [cell addSubview:jiantou];
        [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];
        if (i==5) {
            NSLog(@"cell.frame.origin.y=%f",cell.frame.origin.y);
        }
        cell.tag =990+i;
        
        UIImageView *imagV3 = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 99*CXCWidth,710*CXCWidth,1*CXCWidth)];
        [imagV3 setBackgroundColor:BGColor];
        [cell addSubview:imagV3];

        
    }

    UIButton *queryButton = [[UIButton alloc] init];
    [queryButton setTitle:@"缴费查询" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton.layer.cornerRadius = 5;
    queryButton.titleLabel.font = [UIFont systemFontOfSize:16];
    queryButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [queryButton addTarget:self action:@selector(getHousePlist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];
    queryButton.frame =CGRectMake(30*CXCWidth, 300*CXCWidth, 690*CXCWidth, 100*CXCWidth);
    
    //选择年份
    self.YearTableView = [[UITableView alloc] init];
    self.YearTableView.delegate = self;
    self.YearTableView.dataSource = self;
    self.YearTableView.showsVerticalScrollIndicator = NO;
    self.YearTableView.layer.cornerRadius = 5;
    self.YearTableView.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    self.YearTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.YearTableView];
    self.YearTableView.frame =CGRectMake((CYScreanW * 0.3),200*CXCWidth , (CYScreanW * 0.3),((CYScreanH - 64) * 0.18) );
    self.YearTableView.hidden = YES;
}
- (void)cellBtnPressed:(UIButton*)btn
{
    if (btn.tag==990) {
        [self   selectCompanyButton ];
        
    }else
    {
        [self queryYearButton];
        
    }
}
//拨打电话
- (void) callPropertyPhone
{
    NSLog(@"[CYSmallTools getDataStringKey:PROPERTYCPHONE] = %@",[CYSmallTools getDataStringKey:PROPERTYCPHONE]);
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", [CYSmallTools getDataStringKey:PROPERTYCPHONE]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
//隐藏
-(void) maskTap:(UITapGestureRecognizer *)sender
{
    self.maskView.hidden = YES;
}

//设置物业公司布局
- (void) setButtonLayout:(NSString *)string
{
    CGSize sizeP = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
    [self.proComButton setTitle:string forState:UIControlStateNormal];
    self.proComButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
    self.proComButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
}
//物业公司
- (void) selectCompanyButton
{
    
    
    //物业公司
    self.ProComTableView = [[UITableView alloc] init];
    self.ProComTableView.delegate = self;
    self.ProComTableView.dataSource = self;
    self.ProComTableView.showsVerticalScrollIndicator = NO;
    self.ProComTableView.layer.cornerRadius = 5;
    self.ProComTableView.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    self.ProComTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.ProComTableView];

    self.YearTableView.hidden = YES;
    if (self.ProComTableView.hidden == YES)
    {
        self.ProComTableView.hidden = NO;
    }
    else
    {
        self.ProComTableView.hidden = YES;
    }
}
//查询年份
- (void) queryYearButton
{
    self.ProComTableView.hidden = YES;
    if (self.YearTableView.hidden == YES)
    {
        self.YearTableView.hidden = NO;
    }
    else
    {
        self.YearTableView.hidden = YES;
    }
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
    self.YearTableView.hidden = YES;
    self.ProComTableView.hidden = YES;
    self.maskView.hidden = YES;
//    [self.phonePCTextField resignFirstResponder];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
////section底部间距
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 2;
//}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.PeripheralSTableView)
    {
        return (CYScreanH - 64) * 0.26;
    }
    else if (tableView == self.ProComTableView)
    {
            return (CYScreanH - 64) * 0.06;
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
    if (tableView == self.ProComTableView)
    {
        return self.choosePAddArray.count;
    }
    else if (tableView == self.YearTableView)
    {
        return self.showYearArray.count;
    }
    else if (tableView == self.ChoosePAddTableView)
    {
        return self.choosePAddArray.count ;
    }
    else
    {
        return self.proPayModelArray.count;
    }
    
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.ProComTableView)
    {
        static NSString *ID = @"cellId2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10];
        NSDictionary *dict = self.choosePAddArray[indexPath.row];
        NSString *build = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
        NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
        NSLog(@"array = %@,cout = %ld",array,array.count);
        cell.textLabel.text = [NSString stringWithFormat:@"%@：%@号楼-%@单元-%@号",[dict objectForKey:@"comName"],array[0],array[1],array[2]];
        return cell;
        
    }

    if(tableView == self.PeripheralSTableView)
    {
        static NSString *ID = @"payCellId";
        self.payCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.payCell == nil)
        {
            self.payCell = [[ProPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.proPayModelArray[indexPath.row]);
//        self.payCell.delegate = self;
        self.payCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.payCell.model = self.proPayModelArray[indexPath.row];
        self.payCell.backgroundColor = [UIColor whiteColor];
        return self.payCell;
    }
       if (tableView == self.YearTableView)
        {
            static NSString *ID = @"cellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.showYearArray[indexPath.row]];
            return cell;

        }
        return nil;

}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.ProComTableView)
    {
        NSDictionary *dict = self.ProComArray[indexPath.row];
        self.selectProComId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        NSLog(@"self.selectProComId = %@",self.selectProComId);
        [self setButtonLayout:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]]];
    }
    else if (tableView == self.YearTableView)
    {
        self.YearTableView.hidden = YES;
        self.selectYearData = [NSString stringWithFormat:@"%@",self.showYearArray[indexPath.row]];
        [self.timeButton setTitle:[NSString stringWithFormat:@"%@",self.showYearArray[indexPath.row]] forState:UIControlStateNormal];
    }
    else if (tableView == self.ChoosePAddTableView)
    {
        if (indexPath.row != 0)
        {
            self.maskView.hidden = YES;
            NSDictionary *dict = self.choosePAddArray[indexPath.row - 1];
            self.selectBuild = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
            self.connunityName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"comName"]];
            NSString *build = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
            NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
            self.showAddressLabel.text = [NSString stringWithFormat:@"%@：%@号楼-%@单元-%@号",[dict objectForKey:@"comName"],array[0],array[1],array[2]];
            //立即查询
//            [self CaptureExpendsQuery];
            UILabel *labe =[self.view viewWithTag:110];
            labe.text =[NSString stringWithFormat:@"%@号楼-%@单元-%@号",array[0],array[1],array[2]];
            
            
        }
    }
    else
    {
        
    }
}
//获取社区列表
- (void) getCommunityPlist
{
    [MBProgressHUD showLoadToView:self.view];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStringUTF8 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        self.ProComArray = [NSArray arrayWithArray:[[JSON objectForKey:@"param"] objectForKey:@"comList"]];
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([[JSON objectForKey:@"success"]integerValue] == 1)
        {
            if (self.ProComArray.count > 0)
            {
                [self setProComTableViewFram:self.ProComArray];
            }
            else
                [MBProgressHUD showError:@"没有社区信息" ToView:self.view];
        }
        else if([[JSON objectForKey:@"success"] integerValue] == 0)
        {
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error.description);
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
    }];
}
//设置小区控件
- (void) setProComTableViewFram:(NSArray *)array
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.ProComArray[0]];
    self.selectProComId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    NSString *string = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]];
    //物业公司
    [self setButtonLayout:string];
//    [self.ProComTableView mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
//         make.top.equalTo(self.proComButton.mas_bottom).offset(0);
//         make.height.mas_equalTo(self.ProComArray.count >= 4 ? (CYScreanH - 64) * 0.24 : (CYScreanH - 64) * 0.06 * self.ProComArray.count);
//     }];
    _ProComTableView.frame =CGRectMake((CYScreanW * 0.3), 100*CXCWidth, (CYScreanW * 0.6), (self.ProComArray.count >= 4 ? (CYScreanH - 64) * 0.24 : (CYScreanH - 64) * 0.06 * self.ProComArray.count));
    [self.ProComTableView reloadData];
}
//获取房屋列表
- (void) getHousePlist
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/myBuilds",POSTREQUESTURL];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
    dict[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    dict[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"dict = %@",dict);
    [manager POST:requestUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         [MBProgressHUD hideHUDForView:self.view];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             //如果有房屋信息
             if (array.count)
             {
                 [self setChooseTableViewFrame:array];
             }
             else//没有房屋信息
             {
                 [MBProgressHUD showSuccess:@"没有房屋数据" ToView:self.view];
             }
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"获取房屋列表失败:%@", error.description);
     }];
}
//设置房屋列表
- (void) setChooseTableViewFrame:(NSArray *)array
{
    self.choosePAddArray = [[NSMutableArray alloc] init];
    //将审核通过的显示出来
    for (NSDictionary *dict in array)
    {
        NSString *stateString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
        if ([stateString integerValue] == 1)
        {
            [self.choosePAddArray addObject:dict];
        }
    }
    if (self.choosePAddArray.count)
    {
        _ProComTableView.frame =CGRectMake((CYScreanW * 0.3), 100*CXCWidth, (CYScreanW * 0.6), (self.choosePAddArray.count >= 4 ? (CYScreanH - 64) * 0.24 : (CYScreanH - 64) * 0.06 * self.ProComArray.count));
        [_ProComTableView reloadData];
        self.maskView.hidden = NO;
    }
    else
    {
        [MBProgressHUD showSuccess:@"房屋数据未审核通过" ToView:self.view];
    }
}
//缴费查询
- (void) CaptureExpendsQuery
{
    //清空缴费月份
    Singleton *ProPaySing = [Singleton getSingleton];
    [ProPaySing.selectProPayMonthArray removeAllObjects];
    [self.selectPayMonthArray removeAllObjects];
    //
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"build"]       =  self.selectBuild;//
    parames[@"comNo"]       =  self.selectProComId;
    parames[@"year"]        =  [NSString stringWithFormat:@"%@",self.timeButton.titleLabel.text];//
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/costOfyear",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         self.proPayDatalArray = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [self dictPPCTurnModel:self.proPayDatalArray];
             NSLog(@"缴费查询成功");
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
    //显示数据
    self.ppccController.proPayConArray = @[self.connunityName,[CYSmallTools getDataStringKey:ACCOUNT],trueName,self.showAddressLabel.text,money];
    NSLog(@"month = %@,money = %@",month,money);
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"build"]       =  [NSString stringWithFormat:@"%@",self.selectBuild];;//
    parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",self.communityId];
    parames[@"year"]        =  [NSString stringWithFormat:@"%@",self.yearString];//
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
- (void) remComputingMoney:(NSDictionary *) model
{
    NSLog(@"选择 = %@",[model objectForKey:@"month"]);
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


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UILabel*headerLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 134, CYScreanW)];
//    headerLabel.text =@"选择缴费地址";
//    headerLabel.backgroundColor =NavColor;
//    
//    return headerLabel;
//
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0,CYScreanW, CYScreanW)];
//    view.backgroundColor =[UIColor whiteColor];
//    return view;
//    
//   
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 100;
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
