//
//  AnnounDetailsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/23.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AnnounDetailsViewController.h"

@interface AnnounDetailsViewController ()
{


    UIScrollView *bgScrollView;//背景scrollview
}
@end

@implementation AnnounDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    bgScrollView.scrollEnabled = YES;
    //    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];
    if (self.detailsDict)
    {
        [self initAnnounDetailsController];
    }
    else
        [self getAnnounRequest];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self setAnnounDeStyle];
   
    
}
//设置样 式
- (void) setAnnounDeStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"公告详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//初始化控件
- (void) initAnnounDetailsController
{
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, [self.whetherJPushInput integerValue] == 111 ? 64 : 0, CYScreanW, (CYScreanH - 64) * 0.1)];
    titleLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDict objectForKey:@"title"]];
    titleLabel.numberOfLines =0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Airla" size:20];
    [self.view addSubview:titleLabel];
    //内容
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(CYScreanW * 0.05, [self.whetherJPushInput integerValue] == 111 ? (CYScreanH - 64) * 0.1 + 64 : (CYScreanH - 64) * 0.1, CYScreanW * 0.9, (CYScreanH - 64) * 0.75)];
    text.text = [NSString stringWithFormat:@"%@",[self.detailsDict objectForKey:@"content"]];
    text.textColor = [UIColor grayColor];
    [text setEditable:NO];
    text.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:text];
    //时间戳
    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = [NSString stringWithFormat:@"%@",[CYSmallTools timeWithTimeIntervalString:[self.detailsDict objectForKey:@"publishTime"]]];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CYScreanW * 0.7);
        make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.05);
        make.height.mas_equalTo((CYScreanH - 64) * 0.06);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.04);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取公告详情
- (void) getAnnounRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"id"]     =  self.detailsId;
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/noticeInfo",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"消息列表请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSString *returnValue = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"returnValue"]];
             if (returnValue.length > 6 && ![returnValue isEqualToString:@"<null>"])
             {
                 self.detailsDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
                 [self initAnnounDetailsController];
             }
             else
             {
                 [MBProgressHUD showError:@"获取数据失败" ToView:self.view];
             }
         }
         else
         {
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}

@end
