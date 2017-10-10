//
//  CZExhibitionViewController.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CZExhibitionViewController.h"
#import "CZExhibitionTableViewCell.h"
#import "CZExhibitionDetailsController.h"

@interface CZExhibitionViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation CZExhibitionViewController
- (instancetype)initWithType:(ExhibitionType)type
{
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExhibitionPStyle];
    [self initExhibitionController];
    [self initData];
}

//初始化数据
- (void) initData
{
    self.CZExhibitionPromptImage.hidden = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    
    NSString *decorationList = @"exhibition/decorationList";//装潢
    NSString *oilPaitList = @"exhibition/oilPaitList";//油画
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/%@",POSTREQUESTURL,self.type == TypeOilPainting?oilPaitList:decorationList];
    NSLog(@"requestUrl = %@",requestUrl);
    [MBProgressHUD showLoadToView:self.view];
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
             if (!array.count)
             {
                 NSArray *array = [NSArray arrayWithArray:self.type == TypeOilPainting ? self.listOilPainArray : self.listDecorationArray];
                 if (!array.count) {
                     self.CZExhibitionPromptImage.hidden = NO;
                 }
                 [MBProgressHUD showError:self.type == TypeOilPainting ? @"没有油画数据" : @"没有装潢数据" ToView:self.view];
             }
             else
             {
                 [self dataWithDictModel:array];
             }
        }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         self.CZExhibitionPromptImage.hidden = NO;
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
    
}
- (void) dataWithDictModel:(NSArray *)array
{
    for (NSInteger i = 0; i < array.count; i ++)
    {
        NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:array[i]];
        CZExhibitionModel *model = [[CZExhibitionModel alloc] init];
        model.imageUrl = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"imgAddress"]];
        model.name = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"exhName"]];
        model.account = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"masterUnit"]];
        model.date = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"exhTime"]];
        model.modelID = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"id"]];
        model.state = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"status"]];
        model.flag = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"flag"]];
        model.content = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"content"]];
        if (self.type == TypeOilPainting)//油画
        {
            model.type = @"0";
            [self.listOilPainArray addObject:model];
        }
        else//装饰
        {
            model.type = @"1";
            [self.listDecorationArray addObject:model];
        }
    }
    //刷新
    [self.tableview reloadData];
}
//初始化导航栏
- (void) setExhibitionPStyle
{
    self.view.backgroundColor                         = [UIColor whiteColor];
    self.title                                        = self.type == TypeOilPainting?@"油画展览":@"装潢展览";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    //数据源
    self.listOilPainArray = [NSMutableArray array];
    self.listDecorationArray = [NSMutableArray array];
}
//初始化控件
- (void) initExhibitionController
{
    self.tableview                = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)
                                                                 style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate       = self;
    self.tableview.dataSource     = self;
    [self.view addSubview:self.tableview];
   
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
    PromptImageView.hidden = YES;
    self.CZExhibitionPromptImage = PromptImageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type == TypeOilPainting)
    {
        return self.listOilPainArray.count;
    }
    else
        return self.listDecorationArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"ExhiditionCell";
    CZExhibitionTableViewCell *cell = (CZExhibitionTableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[CZExhibitionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_id];
    }
    if (self.type == TypeOilPainting)
    {
        [cell setExhibitionCell:self.listOilPainArray[indexPath.row]];
    }
    else
        [cell setExhibitionCell:self.listDecorationArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    CZExhibitionModel *model;
    CZExhibitionDetailsController *exhibitionDetailsController;
    if (self.type == TypeOilPainting)
    {
        model = self.listOilPainArray[indexPath.row];
        exhibitionDetailsController = [[CZExhibitionDetailsController alloc] initWithID:model andType:DetailsTypeOilPainting];
    }
    else
    {
        NSLog(@"self.listDecorationArray = %@,indexPath.row = %ld",self.listDecorationArray,indexPath.row);
        model = self.listDecorationArray[indexPath.row];
        exhibitionDetailsController = [[CZExhibitionDetailsController alloc] initWithID:model andType:DetailsTypeDecoration];
    }
    [self.navigationController pushViewController:exhibitionDetailsController animated:YES];

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
