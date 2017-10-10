//
//  MyThumbUpViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyThumbUpViewController.h"

@interface MyThumbUpViewController ()

@end

@implementation MyThumbUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyComStyle];
    [self initMyComController];
    [self initMyComModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化数据
- (void) initMyComModel
{
    //数据源
    self.myThumbUpModelArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 18; i ++)
    {
        NSDictionary *dict = @{
                               @"headString":@"头像",
                               @"nameString":@"HappyLife",
                               @"timeString":@"03-18 12:32:09",
                               @"showImageString":@"论坛图片_01",
                               @"comNameString":@"Vicky",
                               @"titleString":@"云末社区第二届社区邻里节"
                               };
        NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithDictionary:dict];
        MyThumbUpModel *model = [MyThumbUpModel bodyWithDict:dict2];
        [self.myThumbUpModelArray addObject:model];
    }
    //刷新
    [self.MyThumbUpTableView reloadData];
}
//设置样式
- (void) setMyComStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的点赞";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}
//初始化控件
- (void) initMyComController
{
    //显示
    self.MyThumbUpTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH - 64)];
    self.MyThumbUpTableView.delegate = self;
    self.MyThumbUpTableView.dataSource = self;
    self.MyThumbUpTableView.showsVerticalScrollIndicator = NO;
    self.MyThumbUpTableView.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    self.MyThumbUpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyThumbUpTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.25;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myThumbUpModelArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"bbsCellId";
    self.myTUCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.myTUCell == nil)
    {
        self.myTUCell = [[MyThumbUpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.myThumbUpModelArray[indexPath.row]);
    self.myTUCell.model = self.myThumbUpModelArray[indexPath.row];
    self.myTUCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.myTUCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
