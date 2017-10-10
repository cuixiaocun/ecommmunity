//
//  MallViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MallViewController.h"

@interface MallViewController ()

@end

@implementation MallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setCMallStryle];
    [self initMallController];
    
   
    
    
}
//设置样式
- (void) setCMallStryle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"社区商城";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [messageBtn addTarget:self action:@selector(seachButton) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonRight1 = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem = buttonRight1;
    
    //初始化
    
    
    
}
//搜索框
- (void) seachButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    SearchViewController *seauchController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:seauchController animated:YES];
}
//初始化数据源
-(void)initMallModelDataTwo:(NSArray *)array
{
    self.recommendedMArray = [[NSMutableArray alloc] init];
    self.recommendModelArray = [[NSMutableArray alloc] init];
    //数据源
    for (NSDictionary *goodsDict in array)
    {
        NSDictionary *dataDict = @{
                                   @"goodsPictureString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"img"]],
                                   @"goodsNameString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"name"]],
                                   @"goodsPromptString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"intro"]],
                                   @"goodsPriceString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"price"]],
                                   @"goodsSellNumberString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"successnum"]]
                                   };
            [self.recommendedMArray addObject:goodsDict];
        ComMallTModel *model = [ComMallTModel bodyWithDict:dataDict];
        [self.recommendModelArray addObject:model];
    }
    [self.comMallTableView reloadData];

}
- (void) initMallModelData:(NSArray *)array
{
    self.hotSellMArray = [[NSMutableArray alloc] init];
    self.hotSellModelArray = [[NSMutableArray alloc] init];
    //数据源
    for (NSDictionary *goodsDict in array)
    {
        NSDictionary *dataDict = @{
                                   @"goodsPictureString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"img"]],
                                   @"goodsNameString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"name"]],
                                   @"goodsPromptString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"intro"]],
                                   @"goodsPriceString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"price"]],
                                   @"goodsSellNumberString":[NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"successnum"]]
                                   };
        [self.hotSellMArray addObject:goodsDict];
        ComMallTModel *model = [ComMallTModel bodyWithDict:dataDict];
        [self.hotSellModelArray addObject:model];
    }
      [self.comMallTableView reloadData];
}
//设置控件
- (void) initMallController
{
    //背景
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( 0,CYScreanW*0.03 , CYScreanW, CYScreanW*120/750)];
    image.image = [UIImage imageNamed:@"pic_pull_down"];
    [self.view addSubview:image];    //显示
    self.comMallTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 113)];
    self.comMallTableView.delegate = self;
    self.comMallTableView.dataSource = self;
    self.comMallTableView.showsVerticalScrollIndicator = NO;
    self.comMallTableView.backgroundColor = [UIColor clearColor];
    self.comMallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.comMallTableView];
}
- (void) viewWillAppear:(BOOL)animated
{
    //刷新数据
    [self getRecommendedRequest];
    [self getSellCakes];
   
    [self.tabBarController.tabBar setHidden:NO];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==2)
    {
        return 0;
    }
    return 10;
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return (CYScreanH - 64) * 0.34+10;
    }
    else if (indexPath.section == 1)
    {
                   return 250*CXCWidth;
    }
    else
    {
        
            return 250*CXCWidth;
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.hotSellModelArray.count ;
    }
    else if (section == 1)
        return self.recommendModelArray.count ;
    else
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0)
    {
        return 0;
    }
  
    else
        return CYScreanW * 0.12;


}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    

    if (section==0) {
        return nil;
        
    }else if(section ==1)
    {
        UIView *view =[[UIView alloc]init ];
        [view setBackgroundColor:[UIColor whiteColor]];
        
    
        //图标
        _recommendedButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.05, 0, CYScreanW * 0.4, CYScreanW * 0.12)];
        _recommendedButton.backgroundColor = [UIColor clearColor];
        [_recommendedButton setTitle:@"推荐" forState:UIControlStateNormal];
        [_recommendedButton setTitleColor:[UIColor colorWithRed:242/255.0 green:107/255.0 blue:17/255.0 alpha:1.00] forState:UIControlStateNormal];
        [_recommendedButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _recommendedButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _recommendedButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _recommendedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [view addSubview:_recommendedButton];
        
        
        
        UIImageView*img =[[UIImageView alloc]initWithFrame:CGRectMake(23*CXCWidth,20*CXCWidth , 29*CXCWidth, 50*CXCWidth)];
        [img setImage:[UIImage imageNamed:@"icon_tuijian"]];
        [view addSubview:img];
        
        UIImageView*xianimg =[[UIImageView alloc]initWithFrame:CGRectMake(0,_recommendedButton.bottom ,CYScreanW, 1*CXCWidth)];
        xianimg.backgroundColor =BGColor;
        [view addSubview:xianimg];
        
        return view;
        

        

    }else
    {
        UIView *view =[[UIView alloc]init ];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        
        //图标
        _recommendedButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.05, 0, CYScreanW * 0.4, CYScreanW * 0.12)];
        _recommendedButton.backgroundColor = [UIColor clearColor];
        [_recommendedButton setTitle:@"热销" forState:UIControlStateNormal];
        [_recommendedButton setTitleColor:[UIColor colorWithRed:242/255.0 green:107/255.0 blue:17/255.0 alpha:1.00] forState:UIControlStateNormal];
        [_recommendedButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _recommendedButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _recommendedButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _recommendedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [view addSubview:_recommendedButton];
        
        
        
        UIImageView*img =[[UIImageView alloc]initWithFrame:CGRectMake(23*CXCWidth,20*CXCWidth , 29*CXCWidth, 50*CXCWidth)];
        [img setImage:[UIImage imageNamed:@"icon_rexiao"]];
        [view addSubview:img];
        
        UIImageView*xianimg =[[UIImageView alloc]initWithFrame:CGRectMake(0,_recommendedButton.bottom ,CYScreanW, 1*CXCWidth)];
        xianimg.backgroundColor =BGColor;
        [view addSubview:xianimg];
        
        return view;
        
        
        

        
    
    }

}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 )
    {
        static NSString *ID = @"cellComMallId2";
        self.comMallTCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.comMallTCell == nil)
        {
            self.comMallTCell = [[ComMallTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            self.comMallTCell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        self.comMallTCell.mallModel = self.hotSellModelArray[indexPath.row ];

        return  self.comMallTCell;
    }
    else if(indexPath.section == 1 )
    {
    
        
            static NSString *ID = @"cellComMallId4";
            ComMallTableViewCell*  comMallTCell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (comMallTCell == nil)
            {
                comMallTCell = [[ComMallTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                comMallTCell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
        comMallTCell.mallModel = self.recommendModelArray[indexPath.row ];

            return  comMallTCell;
        
    
    
    }
        if (indexPath.section == 0)
        {
            static NSString *ID = @"cellComMallId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];

            if (self.comMallView == nil)
            {
                self.comMallView = [[ComMallView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, (CYScreanH - 64) * 0.34)];
                self.comMallView.CMallDelegate = self;
                self.comMallView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:self.comMallView];
            }
            }

            return cell;

        }
    
    return nil;

}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 )
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.hotSellMArray[indexPath.row ]];
        MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
        MPController.MerchantsId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shopId"]];
        NSLog(@"MPController.MerchantsId = %@",MPController.MerchantsId);
        [self.navigationController pushViewController:MPController animated:YES];
    }else if(indexPath.section == 1 )
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.recommendedMArray[indexPath.row ]];
        MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
        MPController.MerchantsId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shopId"]];
        NSLog(@"MPController.MerchantsId = %@",MPController.MerchantsId);
        [self.navigationController pushViewController:MPController animated:YES];
    
    }
}
//手势
-(void) recommendedTap:(UITapGestureRecognizer *)sender
{
    NSDictionary *dict;
    if (sender.view.tag == 1001)
    {
        dict = [NSDictionary dictionaryWithDictionary:self.recommendedMArray[1]];
        NSLog(@"dict = %@",dict);
    }
    else if(sender.view.tag == 1002)
    {
        dict = [NSDictionary dictionaryWithDictionary:self.recommendedMArray[2]];
        NSLog(@"dict = %@",dict);
    }
    else
    {
        dict = [NSDictionary dictionaryWithDictionary:self.recommendedMArray[0]];
        NSLog(@"dict = %@",dict);
    }
    MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
    MPController.MerchantsId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shopId"]];
    [self.navigationController pushViewController:MPController animated:YES];
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 按钮代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//外卖
- (void) TakeOutFood
{
    [self jumpStyle:@"外卖" withIdString:@"01"];
}
//超市
- (void) supermarketFunction
{
    [self jumpStyle:@"超市" withIdString:@"02"];
}
//团购
- (void) foodMarket
{
    [self jumpStyle:@"团购" withIdString:@"04"];
}
//微店
- (void) microShop
{
    [self jumpStyle:@"微店" withIdString:@"03"];
}
//菜市场
- (void) groupPurchase
{
    [self jumpStyle:@"菜市场" withIdString:@"05"];
}
//跳转页面
- (void) jumpStyle:(NSString *)type withIdString:(NSString *)idString
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    TakeOutViewController *TOController = [[TakeOutViewController alloc] init];
    TOController.ChooseClassificationString = [NSString stringWithFormat:@"%@",type];
    TOController.LabelCategoryId = idString;
    [self.navigationController pushViewController:TOController animated:YES];
}
//获取推荐商家
- (void) getRecommendedRequest
{
    self.recommendedMArray = [[NSMutableArray alloc] init];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/roundRecomPros",POSTREQUESTURL];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    NSLog(@"parames = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            self.recommendedMArray = [NSMutableArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
                    NSLog(@"推荐请求成功JSON:%@", JSON);
            [self initMallModelDataTwo:[NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]]];

        }
        
//        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];

    }];
}
//获取热销商家
- (void) getSellCakes
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/hotSellPros",POSTREQUESTURL];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    NSLog(@"parames = %@",parames);
    
    [self requestWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"热销请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {;
            [self initMallModelData:[NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]]];
        }
    }];
    
}
//数据请求
- (void)requestWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
