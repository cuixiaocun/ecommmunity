//
//  TakeOutViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "TakeOutViewController.h"

@interface TakeOutViewController ()

@end

@implementation TakeOutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTakeOutStryle];
    [self initTakeOutController];
    
    [self getMallListRequest:self.LabelCategoryId];//首页数据
    [self getSecondaryData];//二级分类列表
}

//设置样式
- (void) setTakeOutStryle
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@",self.ChooseClassificationString];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    //显示导航栏
    [self.navigationController.navigationBar setHidden:NO];
}

//设置控件
- (void) initTakeOutController
{
    //
    CGSize size = [@"分类" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    CGSize sizeImage = [UIImage imageNamed:@"icon_drop_down_def"].size;
    self.classificationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CYScreanW / 3, (CYScreanH - 64) * 0.08)];
    self.classificationButton.backgroundColor = [UIColor whiteColor];
    [self.classificationButton setTitle:@"分类" forState:UIControlStateNormal];
    [self.classificationButton setTitleColor:[UIColor colorWithRed:0.102 green:0.494 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.classificationButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.classificationButton setImage:[UIImage imageNamed:@"icon_drop_down_def"] forState:UIControlStateNormal];
    [self.classificationButton setImage:[UIImage imageNamed:@"icon_drop_down_selected"] forState:UIControlStateSelected];
    self.classificationButton.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + 5, 0, - size.width - 5);
    self.classificationButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizeImage.width, 0, sizeImage.width);
    [self.classificationButton addTarget:self action:@selector(labelClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.classificationButton];
    self.classificationButton.selected = YES;
    //
    size = [@"综合排序" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    self.sortingButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3, 0, CYScreanW / 3, (CYScreanH - 64) * 0.08)];
    self.sortingButton.backgroundColor = [UIColor whiteColor];
    [self.sortingButton setImage:[UIImage imageNamed:@"icon_drop_down_def"] forState:UIControlStateNormal];
    [self.sortingButton setImage:[UIImage imageNamed:@"icon_drop_down_selected"] forState:UIControlStateSelected];
    self.sortingButton.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + 5, 0, - size.width - 5);
    self.sortingButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizeImage.width, 0, sizeImage.width);
    [self.sortingButton setTitle:@"综合排序" forState:UIControlStateNormal];
    [self.sortingButton setTitleColor:[UIColor colorWithRed:0.102 green:0.494 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.sortingButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.sortingButton addTarget:self action:@selector(labelClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sortingButton];
    self.sortingButton.selected = NO;
    //
    size = [@"刷选" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    self.brushChooseButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3 * 2, 0, CYScreanW / 3, (CYScreanH - 64) * 0.08)];
    self.brushChooseButton.backgroundColor = [UIColor whiteColor];
    [self.brushChooseButton setImage:[UIImage imageNamed:@"icon_drop_down_selected"] forState:UIControlStateSelected];
    [self.brushChooseButton setImage:[UIImage imageNamed:@"icon_drop_down_def"] forState:UIControlStateNormal];
    self.brushChooseButton.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + 5, 0, - size.width - 5);
    self.brushChooseButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizeImage.width, 0, sizeImage.width);
    [self.brushChooseButton setTitle:@"筛选" forState:UIControlStateNormal];
    [self.brushChooseButton setTitleColor:[UIColor colorWithRed:0.102 green:0.494 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.brushChooseButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.brushChooseButton addTarget:self action:@selector(labelClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.brushChooseButton];
    self.brushChooseButton.selected = NO;
    //竖线  vertical
    UIImageView *verticalImmage = [[UIImageView alloc] init];
    verticalImmage.backgroundColor = BGColor;
    [self.view addSubview:verticalImmage];
    [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.classificationButton.mas_right).offset(0);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    UIImageView *verticalTImmage = [[UIImageView alloc] init];
    verticalTImmage.backgroundColor = BGColor;
    [self.view addSubview:verticalTImmage];
    [verticalTImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.sortingButton.mas_right).offset(0);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.01);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
     }];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [self.view addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.classificationButton.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //显示商品
    self.TakeOutTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, (CYScreanH - 64) * 0.94)];
    self.TakeOutTableView.delegate = self;
    self.TakeOutTableView.dataSource = self;
    self.TakeOutTableView.showsVerticalScrollIndicator = NO;
    self.TakeOutTableView.backgroundColor = [UIColor whiteColor];
    self.TakeOutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.TakeOutTableView];
    //提示模块
    UIImageView *PromptImageView = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, (CYScreanH - 64) * 0.25, CYScreanW * 0.6, (CYScreanH - 64) * 0.3)];
    PromptImageView.image = [UIImage imageNamed:@"missing_content_01"];
    [self.view addSubview:PromptImageView];
//    PromptImageView.hidden = YES;
    self.TakeOutPromptImage = PromptImageView;
    
    //蒙版
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, (CYScreanH - 64) * 0.94)];
    self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.shadowView.userInteractionEnabled = YES;
    [self.view addSubview:self.shadowView];
    self.shadowView.hidden = YES;
    //添加单击手势防范
    UITapGestureRecognizer *postingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowViewHiddenTap:)];
    postingTap.numberOfTapsRequired = 1;
    [self.shadowView addGestureRecognizer:postingTap];
    
    //分类列表
    self.classificationTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, (CYScreanH - 64) * 0.24)];
    self.classificationTableView.delegate = self;
    self.classificationTableView.dataSource = self;
    self.classificationTableView.showsVerticalScrollIndicator = NO;
    self.classificationTableView.backgroundColor = [UIColor whiteColor];
    self.classificationTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.classificationTableView];
    self.classificationTableView.hidden = YES;
    //综合排序
    self.sortingTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, (CYScreanH - 64) * 0.18)];
    self.sortingTableView.delegate = self;
    self.sortingTableView.dataSource = self;
    self.sortingTableView.showsVerticalScrollIndicator = NO;
    self.sortingTableView.backgroundColor = [UIColor whiteColor];
    self.sortingTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.sortingTableView];
    self.sortingTableView.hidden = YES;
    //刷选
    self.brushChooseTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, (CYScreanH - 64) * 0.08, CYScreanW, (CYScreanH - 64) * 0.12)];
    self.brushChooseTableView.delegate = self;
    self.brushChooseTableView.dataSource = self;
    self.brushChooseTableView.showsVerticalScrollIndicator = NO;
    self.brushChooseTableView.backgroundColor = [UIColor whiteColor];
    self.brushChooseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.brushChooseTableView];
    self.brushChooseTableView.hidden = YES;
    
}
//蒙版点击方法
-(void) shadowViewHiddenTap:(UITapGestureRecognizer *)sender
{
    self.shadowView.hidden = YES;
    self.classificationTableView.hidden = YES;
    self.sortingTableView.hidden = YES;
    self.brushChooseTableView.hidden = YES;
}
//标签页选择
- (void) labelClickButton:(UIButton *)sender
{
    if (sender == self.classificationButton)
    {
        if (self.classDataArray.count)
        {
            [self classShowHidden];
        }
        else
            [MBProgressHUD showError:@"未获取分类信息" ToView:self.view];
    }
    else if (sender == self.sortingButton)
    {
        [self sortShowHidden];
    }
    else if (sender == self.brushChooseButton)
    {
        [self brushShowHidden];
    }
}
//分类
- (void) classShowHidden
{
    //选中状态
    self.classificationButton.selected = YES;
    self.sortingButton.selected = NO;
    self.brushChooseButton.selected = NO;
    //显示
    if (self.classificationTableView.hidden == YES)
    {
        self.classificationTableView.hidden = NO;
        self.shadowView.hidden = NO;
    }
    else
    {
        self.shadowView.hidden = YES;
        self.classificationTableView.hidden = YES;
    }
    self.sortingTableView.hidden = YES;
    self.brushChooseTableView.hidden = YES;
}
//排序
- (void) sortShowHidden
{
    //选中状态
    self.classificationButton.selected = NO;
    self.sortingButton.selected = YES;
    self.brushChooseButton.selected = NO;
    //显示
    if (self.sortingTableView.hidden == YES)
    {
        self.shadowView.hidden = NO;
        self.sortingTableView.hidden = NO;
    }
    else
    {
        self.shadowView.hidden = YES;
        self.sortingTableView.hidden = YES;
    }
    
    self.classificationTableView.hidden = YES;
    self.brushChooseTableView.hidden = YES;
}
//刷选
- (void) brushShowHidden
{
    //选中状态
    self.classificationButton.selected = NO;
    self.sortingButton.selected = NO;
    self.brushChooseButton.selected = YES;
    //显示
    if (self.brushChooseTableView.hidden == YES)
    {
        self.shadowView.hidden = NO;
        self.brushChooseTableView.hidden = NO;
    }
    else
    {
        self.shadowView.hidden = YES;
        self.brushChooseTableView.hidden = YES;
    }
    
    self.classificationTableView.hidden = YES;
    self.sortingTableView.hidden = YES;
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.TakeOutTableView)//内容
    {
        TakeOutModel *model = self.allDataTOModelArray[indexPath.row];
        NSLog(@"%d%d",[model.isNUJianMian integerValue],[model.isManJian integerValue]);
        
        if ([model.isNUJianMian integerValue] == 1 || [model.isManJian integerValue] == 1)
        {
            return (CYScreanH - 64) * 0.16;
        }
        else
            return (CYScreanH - 64) * 0.12;
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
    if (tableView == self.classificationTableView)//分类
    {
        return self.classDataArray.count;
    }
    else if (tableView == self.sortingTableView)//排序
    {
        return 3;
    }
    else if (tableView == self.brushChooseTableView)//刷选
    {
        return 2;
    }
    else//内容
    {
        return self.allDataTOModelArray.count;
    }
    
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.TakeOutTableView) //内容
    {
        static NSString *ID = @"takeoutcellid";
        self.takeCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.takeCell == nil)
        {
            self.takeCell = [[TakeOutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.takeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.takeCell.model = self.allDataTOModelArray[indexPath.row];
        return  self.takeCell;
    }
    else
    {
        static NSString *ID = @"takeoutcellidTwo";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0.549 green:0.549 blue:0.553 alpha:1.00];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //排序
        NSArray *sortArray = @[@"销量最高",@"起送价最低",@"配送费最低"];
        if (tableView == self.classificationTableView)//分类
        {
            NSDictionary *dict = [ NSDictionary dictionaryWithDictionary:self.classDataArray[indexPath.row]];
            NSLog(@"[dict objectForKey:name] = %@",[dict objectForKey:@"name"]);
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
        }
        else if (tableView == self.sortingTableView)//排序
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",sortArray[indexPath.row]];
        }
        else//筛选
        {
            if (indexPath.row == 0)
            {
                cell.imageView.image = [UIImage imageNamed:@"icon_new"];
                cell.textLabel.text = @"新用户优惠";
            }
            else
            {
                cell.imageView.image = [UIImage imageNamed:@"icon_reduce"];
                cell.textLabel.text = @"下单立减";
            }
        }
        return cell;
    }
    
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.classificationTableView)
    {
        [self classShowHidden];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.classDataArray[indexPath.row]];
        [self getMallListRequest:[dict objectForKey:@"code"]];
    }
    else if (tableView == self.sortingTableView)//排序
    {
        [self sortShowHidden];
        if (indexPath.row == 0)
        {
            [self RequestSortAndBrushRequest:@"/api/seller/shopXiaoLiangList"];
        }
        else if (indexPath.row == 1)
        {
            [self RequestSortAndBrushRequest:@"/api/seller/shopQiSongJiaList"];
        }
        else if (indexPath.row == 2)
        {
            [self RequestSortAndBrushRequest:@"/api/seller/shopBusFeeList"];
        }
    }
    else if (tableView == self.brushChooseTableView)//刷选
    {
        [self brushShowHidden];
        if (indexPath.row == 0)
        {
            [self RequestSortAndBrushRequest:@"/api/seller/shopCutNUList"];
        }
        else if (indexPath.row == 1)
        {
            [self RequestSortAndBrushRequest:@"/api/seller/shopCutMJList"];
        }
    }
    else if (tableView == self.TakeOutTableView)
    {
        TakeOutModel *model = self.allDataTOModelArray[indexPath.row];
        MerchantsPageViewController *MPController = [[MerchantsPageViewController alloc] init];
        NSLog(@"model.merchantsId = %@",model.merchantsId);
        MPController.MerchantsId = model.merchantsId;
        [self.navigationController pushViewController:MPController animated:YES];
    }
}
//根据分类获取商城首页数据
- (void) getMallListRequest:(NSString *)categoryId
{
    self.TakeOutPromptImage.hidden = YES;//默认隐藏
    //显示进度条
    [MBProgressHUD showLoadToView:self.view];
    //小区数据
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/shopCategoryList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",categoryId] forKey:@"category"];
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    NSLog(@"parames = %@",parames);
    [self requestTOWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"根据分类商城首页请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
            if (!array.count)
            {
                if (!self.allDataTOModelArray.count) {
                    self.TakeOutPromptImage.hidden = NO;
                }
                [MBProgressHUD showError:@"没有数据了" ToView:self.view];
            }
            else
                [self initTakeOutModel:array];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//获取综合排序和刷选数据
- (void) RequestSortAndBrushRequest:(NSString *)RequestType
{
    //显示进度条
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",POSTREQUESTURL,RequestType];
    
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",self.LabelCategoryId] forKey:@"category"];
    [parames setObject:[NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]] forKey:@"comNo"];
    NSLog(@"parames = %@,requestUrl = %@",parames,requestUrl);
    
    
    [self requestTOWithUrl:requestUrl parames:parames Success:^(id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取综合排序和刷选数据请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
            if (array.count)
            {
                [self initTakeOutModel:array];
            }
            else
                [MBProgressHUD showError:@"没有数据了" ToView:self.view];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//初始化数据源
- (void) initTakeOutModel:(NSArray *)array
{
    //初始化
    self.allDataTOArray = [[NSMutableArray alloc] init];
    self.allDataTOModelArray = [[NSMutableArray alloc] init];
    //数据源
    for (NSDictionary *MerchantsDict in array)
    {
        NSDictionary *dataDict = @{
                                   @"headString"        :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"imgBiao"]],
                                   @"nameString"        :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"shopName"]],
                                   @"startTOString"       :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"zongHePingFen"]],
                                   @"numberString"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"successNum"]],
                                   @"sendPriceString"   :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"minAmount"]],
                                   @"shippingFeeString" :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"busFee"]],
                                   @"onlineString"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"youHuiInfo"]],
                                   @"merchantsId"       :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"id"]],
                                   @"isManJian"         :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"isManJian"]],
                                   @"isNUJianMian"      :[NSString stringWithFormat:@"%@",[MerchantsDict objectForKey:@"isNUJianMian"]]
                                   };
        [self.allDataTOArray addObject:dataDict];
        TakeOutModel *model = [TakeOutModel bodyWithDict:dataDict];
        [self.allDataTOModelArray addObject:model];
    }
    [self.TakeOutTableView reloadData];
}
//获取二级分类数据
- (void) getSecondaryData
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/grade2CateOfShop",POSTREQUESTURL];
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",self.LabelCategoryId] forKey:@"pCode"];
    NSLog(@"parames = %@",parames);
    
    [self requestTOWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取二级页面数据请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            self.classDataArray = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
            self.classificationTableView.frame = CGRectMake( 0, (CYScreanH - 64) * 0.06, CYScreanW, (CYScreanH - 64) * 0.06 * self.classDataArray.count);
            [self.classificationTableView reloadData];
        }
    }];
}
//数据请求
- (void)requestTOWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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
         NSString *requestUrl2 = [NSString stringWithFormat:@"%@/api/seller/shopCategoryList",POSTREQUESTURL];
         if ([requestUrl isEqualToString:requestUrl2]) {
             self.TakeOutPromptImage.hidden = NO;
         }
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}

@end
