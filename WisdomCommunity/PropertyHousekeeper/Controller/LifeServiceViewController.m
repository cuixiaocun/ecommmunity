//
//  LifeServiceViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "LifeServiceViewController.h"

@interface LifeServiceViewController ()

@end

@implementation LifeServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLifeStyle];
    [self initDataLifeModel];
    [self initLifeControls];
    
    
}
//设置样式
- (void) setLifeStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"生活服务";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//初始化数据
- (void) initDataLifeModel
{
    //数据源
    self.dataAllLifeSArray = [[NSMutableArray alloc] init];
    self.dataModelLifeSArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 15; i ++)
    {
        NSDictionary *dict = @{
                               @"lifeHeadString":@"头像",
                               @"lifeNameString":@"卓尔美发",
                               @"lifeStartString":@"9.5",
                               @"lifeNumberString":@"358",
                               @"lifeAddressString":@"南京路与上海路交汇处南100米",
                               @"lifePhooneString":@"icon_telephone",

                               };
        [self.dataAllLifeSArray addObject:dict];
        LifeServiceModel *model = [LifeServiceModel bodyWithDict:dict];
        [self.dataModelLifeSArray addObject:model];
    }
    //刷新
    [self.LifeSTableView reloadData];
}
//初始化首页控件
- (void) initLifeControls
{
    //显示
    self.LifeSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH - 64)];
    self.LifeSTableView.delegate = self;
    self.LifeSTableView.dataSource = self;
    self.LifeSTableView.showsVerticalScrollIndicator = NO;
    self.LifeSTableView.backgroundColor = [UIColor colorWithRed:0.765 green:0.765 blue:0.765 alpha:1.00];
    self.LifeSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.LifeSTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 2;
//}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CYScreanH - 64) * 0.135;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModelLifeSArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"RootTableViewCellId";
    self.lifeCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self.lifeCell == nil)
    {
        self.lifeCell = [[LifeServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.dataModelLifeSArray[indexPath.row]);
    self.lifeCell.model = self.dataModelLifeSArray[indexPath.row];
    self.lifeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.lifeCell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
