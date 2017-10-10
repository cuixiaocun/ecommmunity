//
//  ProPaycostViewController.m
//  WisdomCommunity
//
//  Created by Admin on 2017/5/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ProPaycostViewController.h"
#import "PayDetailViewController.h"
@interface ProPaycostViewController ()

@end

@implementation ProPaycostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _HouseComArray =[[NSMutableArray alloc]init];
    _showYearArray =[[NSMutableArray alloc]init];

    [self setProPayStyle];
    [self mainView];
    [self getHousePlist];
    [self getHouseYear];
    





}
- (void)mainView
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
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(250*CXCWidth, 0, 450*CXCWidth, 99*CXCWidth)];
        label2.textColor = TextGroColor;

        
        
        if (i==0) {
            label2.text =@"请选择缴费地址";
            
        }else
        {
            label2.text =@"请选择年份";

        
        }
        
        label2.textAlignment =NSTextAlignmentRight;
        label2.font = [UIFont systemFontOfSize:13];
        [cell addSubview:label2];
        label2.tag =110+i;

        UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(700*CXCWidth, 40*CXCWidth,20*CXCWidth , 20*CXCWidth)];
        [imgV setImage:[UIImage imageNamed:@"icon_drop_down"]];
        [cell addSubview:imgV];
        

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
    [queryButton addTarget:self action:@selector(CaptureExpendsQuery) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];
    queryButton.frame =CGRectMake(30*CXCWidth, 300*CXCWidth, 690*CXCWidth, 100*CXCWidth);
    
    
    
    
    
    
    
    
    


}
- (void)cellBtnPressed:(UIButton*)btn
{
    if (btn.tag==990) {

        if (!_HouseComTableView) {
            //物业公司
           self.HouseComTableView = [[UITableView alloc] init];
            self.HouseComTableView.delegate = self;
            self.HouseComTableView.dataSource = self;
            self.HouseComTableView.showsVerticalScrollIndicator = NO;
            self.HouseComTableView.layer.cornerRadius = 5;
            self.HouseComTableView.layer.borderColor = BGColor.CGColor;
            self.HouseComTableView.layer.borderWidth = 1;
            self.HouseComTableView.backgroundColor =[UIColor whiteColor];
            self.HouseComTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            [self.view addSubview:self.HouseComTableView];
            if (_HouseComArray.count)
            {
                _HouseComTableView.frame =CGRectMake((CYScreanW * 0.2), 100*CXCWidth, (CYScreanW * 0.7), (_HouseComArray.count >= 3 ? (CYScreanH - 64) * 0.24 : (CYScreanH - 64) * 0.06 * self.HouseComArray.count));
                [_HouseComTableView reloadData];
            }
        }
        _HouseComTableView.hidden =NO;
        _YearTableView.hidden=YES;
        
    }else
    {
        if (!_YearTableView) {
        //选择年份
        self.YearTableView = [[UITableView alloc] init];
        self.YearTableView.delegate = self;
        self.YearTableView.dataSource = self;
        self.YearTableView.showsVerticalScrollIndicator = NO;
        self.YearTableView.layer.cornerRadius = 5;
        self.YearTableView.layer.borderWidth = 1;
        self.YearTableView.layer.borderColor = BGColor.CGColor;
        [self.YearTableView setShowsVerticalScrollIndicator:NO];
        [self.YearTableView setShowsHorizontalScrollIndicator:NO];

        self.YearTableView.backgroundColor = [UIColor whiteColor];
        self.YearTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [self.view addSubview:self.YearTableView];
        self.YearTableView.frame =CGRectMake((CYScreanW * 0.6),200*CXCWidth , (CYScreanW * 0.3),(_showYearArray .count >= 3 ? (CYScreanH - 64) * 0.24 : (CYScreanH - 64) * 0.06 * _showYearArray.count) );

        }
        _HouseComTableView.hidden=YES;
        _YearTableView.hidden =NO;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
            return (CYScreanH - 64) * 0.06;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.HouseComTableView)
    {
        return self.HouseComArray.count;
    }
    else
        return self.showYearArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.HouseComTableView)
    {
        static NSString *ID = @"cellId2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.backgroundColor =BGColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor grayColor];
        NSDictionary *dict = self.HouseComArray[indexPath.row];
        NSString *build = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
        NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
        NSLog(@"array = %@,cout = %ld",array,array.count);
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@号楼-%@单元-%@号",[dict objectForKey:@"comName"],array[0],array[1],array[2]];
        return cell;
        
    }
    if (tableView == self.YearTableView)
    {
        static NSString *ID = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.showYearArray[indexPath.row]];
        return cell;
        
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.HouseComTableView)
    {
        self.HouseComTableView.hidden = YES;

        NSDictionary *dict = self.HouseComArray[indexPath.row];
        NSString *build = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
        NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
        NSLog(@"array = %@,cout = %ld",array,array.count);
        UILabel *labe =[self.view viewWithTag:110];
        labe.text = [NSString stringWithFormat:@"%@%@号楼%@单元%@室",[dict objectForKey:@"comName"],array[0],array[1],array[2]];

        self.selectBuild = [NSString stringWithFormat:@"%@",[dict objectForKey:@"build"]];
        self.selectProComId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"comNo"]];
    
    
    }
    else if (tableView == self.YearTableView)
    {
        self.YearTableView.hidden = YES;
        UILabel *labe =[self.view viewWithTag:111];
        labe.text = [NSString stringWithFormat:@"%@",_showYearArray[indexPath.row]];
       
    }

}
//设置样式
- (void) setProPayStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物业缴费查询";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
                 //将审核通过的显示出来
                 for (NSDictionary *dict in array)
                 {
                     NSString *stateString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
                     if ([stateString integerValue] == 1)
                     {
                         [_HouseComArray addObject:dict];
                         
                         
                     }
                 }
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getHouseYear
{
    
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
    self.showYearArray = [[NSMutableArray alloc] init];
    for (NSInteger i = comp.year; i >= 2010; i --)
    {
        [self.showYearArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    NSLog(@"self.showYearArray = %@",self.showYearArray);



}
//缴费查询
- (void) CaptureExpendsQuery
{
    
    UILabel *labeb =[self.view viewWithTag:110];
    UILabel *labeb2 =[self.view viewWithTag:111];

    if ([labeb.text isEqualToString: @"请选择缴费地址"]) {
        
        [MBProgressHUD showError:@"请选择缴费地址" ToView:self.view];
        return;

    }  if ([labeb2.text isEqualToString:@"请选择年份"]) {
        
        [MBProgressHUD showError:@"请选择年份" ToView:self.view];
        return;

    }
    //清空缴费月份
    Singleton *ProPaySing = [Singleton getSingleton];
    [ProPaySing.selectProPayMonthArray removeAllObjects];
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
    parames[@"year"]        = [NSString stringWithFormat:@"%@", labeb2.text] ;//
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
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"缴费查询成功");
             NSArray *arr =[[NSArray alloc]init];
             arr =[JSON objectForKey:@"returnValue"];
             
             if([arr isEqual:[NSNull null]]||[arr isEqual:nil]||arr.count==0)
             {
                 [MBProgressHUD showError:@"暂无缴费信息" ToView:self.view];
                 
                 return ;
                 
             
             }
             UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
             [self.navigationItem setBackBarButtonItem:backItem];

             PayDetailViewController *paydetail=[[PayDetailViewController alloc]init];
             paydetail.proPayModelArray =[JSON objectForKey:@"returnValue"];
             paydetail.proPay = [self.HouseComArray[0] objectForKey:@"comName"];
             NSString *build = [NSString stringWithFormat:@"%@",[self.HouseComArray[0] objectForKey:@"build"]];
             NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
             NSLog(@"array = %@,cout = %ld",array,array.count);
             NSString*house = [NSString stringWithFormat:@"%@%@号楼%@单元%@室",[self.HouseComArray[0] objectForKey:@"comName"],array[0],array[1],array[2]];
             
             paydetail.house =house;
             [self.navigationController  pushViewController:paydetail animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
