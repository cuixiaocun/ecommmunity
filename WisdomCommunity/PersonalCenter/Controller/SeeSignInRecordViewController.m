//
//  SeeSignInRecordViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SeeSignInRecordViewController.h"

@interface SeeSignInRecordViewController ()

@end

@implementation SeeSignInRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSignInStyle];
    
    [self initSignInControllers];
    //总数据
    self.SignInArray = [[NSMutableArray alloc] init];
    //初始化
    self.UserDate = [NSDate date];
    
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
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    //数据请求
    [self RequestSingInRecord:[NSString stringWithFormat:@"%ld",comp.year]];
}

//设置样式
- (void) setSignInStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"签到记录";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void) initSignInControllers
{
    //说明
    UILabel *promptLable = [[UILabel alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.05, CYScreanW, (CYScreanH - 64) * 0.06)];
    promptLable.text = @"蓝色背景为签到记录";
    promptLable.textColor = [UIColor blackColor];
    promptLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:promptLable];
    
    
    
    
    self.dataView = [[CYSignInRecord alloc] initWithFrame:CGRectMake(CYScreanW * 0.05, 64+(CYScreanH) * 0.05, CYScreanW * 0.9, (CYScreanH) * 0.4)];
  
    self.dataView.layer.borderColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.812 alpha:1.00].CGColor;
    self.dataView.layer.borderWidth = 1;
    [self.view addSubview:self.dataView];
    __weak typeof(self)weakSelf = self;
    self.dataView.dateYearBlock = ^(NSString *date,NSDate *date2){
        BOOL whetherThereAre = NO;//默认是不存在的
        NSLog(@"");
        //遍历签到数据，查看是否已存在当年度数据
        for (NSDictionary *dict in weakSelf.SignInArray)
        {
            NSLog(@"%@,date = %@",[dict objectForKey:@"Year"],date);
            
            if ([[dict objectForKey:@"Year"] isEqualToString:date])
            {
                whetherThereAre = YES;
            }
        }
        //如果不存在
        if (whetherThereAre == NO)
        {
            [weakSelf RequestSingInRecord:date];
            weakSelf.UserDate = date2;
        }
    };
}


//获取签到记录
- (void) RequestSingInRecord:(NSString *)year
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"year"]      =  [NSString stringWithFormat:@"%@",year];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/mySignLog",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestSignWithUrl:requestUrl parames:parames Success:^(id responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//         NSLog(@"获取签到记录请求成功JSON = %@",JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [self dealWithData:[JSON objectForKey:@"returnValue"] withYear:year];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     }];
}
//数据处理
- (void) dealWithData:(NSArray *)array withYear:(NSString *)year
{
    if (!array.count)
    {
        [MBProgressHUD showError:@"没有签到记录" ToView:self.view];
    }
    NSMutableArray *yearArray = [[NSMutableArray alloc] init];//每一年的总数据
    NSMutableArray *everyMonthDataArray = [[NSMutableArray alloc] init];//每个月的数据
    NSString *monthString;
    for (NSInteger i = array.count - 1; i >= 0 ; i --)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
        NSLog(@"签到日数据dict = %@",dict);
        NSString *createTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ymd"]];//获取记录时间
        NSArray *BreakUpArray = [createTime componentsSeparatedByString:@"-"];//拆分成数组
        if (BreakUpArray.count != 3)//如果分拆不对，数据有问题
        {
            continue;
        }
        monthString = [NSString stringWithFormat:@"%@",i == array.count - 1 ? BreakUpArray[1] : monthString];//如果是第一个数据就赋值，否则不变
        NSLog(@"拆分后数据BreakUpArray = %@,使用月份数据monthString = %@",BreakUpArray,monthString);
        
        if ([monthString isEqualToString:[NSString stringWithFormat:@"%@",BreakUpArray[1]]])//1.上一个月份与当前月份相同；2.第一条数据
        {
            [everyMonthDataArray addObject:[NSString stringWithFormat:@"%@",BreakUpArray[2]]];
            if ((i - 1) < 0)
            {
                //跳出循环的时候everyMonthDataArray和monthString肯定有数据，并且尚未添加到总数据
                NSDictionary *dictMonth = @{@"month":monthString,@"data":everyMonthDataArray};//每个月一个字典格式
                [yearArray addObject:dictMonth];//将整月的数据添加到总数据
            }
        }
        else//上一个月与当前月不相同
        {
            NSDictionary *dictMonth = @{@"month":monthString,@"data":everyMonthDataArray};//每个月一个字典格式
            NSLog(@"每个月数据dictMonth = %@",dictMonth);
            
            [yearArray addObject:dictMonth];//将整月的数据添加到总数据
            NSLog(@"实时总数据self.SignInArray = %@",self.SignInArray);
            
            everyMonthDataArray = [[NSMutableArray alloc] init];//清空数据
            [everyMonthDataArray addObject:[NSString stringWithFormat:@"%@",BreakUpArray[2]]];//将下个月第一个数据添加进来
            monthString = [NSString stringWithFormat:@"%@",BreakUpArray[1]];//月份数据重新赋值
            NSLog(@"切换后的月份monthString = %@",monthString);
        }
    }
    //将每一年数据添加进来
    NSDictionary *dict = @{@"Year":year,@"YearData":yearArray};
    [self.SignInArray addObject:dict];
    NSLog(@"self.SignInArray = %@",self.SignInArray);
    self.dataView.SignInAllDataArray = [NSArray arrayWithArray:self.SignInArray];
    //刷新
    [self.dataView reloadDataView:self.UserDate];
}
//数据请求
- (void)requestSignWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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
