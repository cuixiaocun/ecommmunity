//
//  GoodsDetailsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "GoodsDetailsViewController.h"

@interface GoodsDetailsViewController ()

@end

@implementation GoodsDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initGDController];
//    [self initGDModelData];
    
    
    [self getGoodsRequest];
    [self getGoodsCommentRequest];
}

//初始化数据源
- (void) initGDModelData
{
    //初始化
    self.detailsCommentArray = [[NSMutableArray alloc] init];
    //数据源
    for (NSInteger i = 0; i < 8; i ++)
    {
        NSDictionary *dict = @{@"headString":@"头像",
                               @"nameString":@"hello world",
                               @"startString":@"7.5",
                               @"timeString":@"2017-01-18 12:30",
                               @"contentString":@"味道纯正，鲜美，经常定他们家的小厨，赞赞赞！！！送的很快~~~~~味道纯正，鲜美，经常定他们家的小厨，赞赞赞！！！送的很快~~~~~味道纯正，鲜美，经常定他们家的小厨，赞赞赞！！！送的很快~~~~~味道纯正，鲜美，经常定他们家的小厨，赞赞赞！！！送的很快~~~~~"
                               };
        MerchantsCommentModel *model = [MerchantsCommentModel bodyWithDict:dict];
        [self.detailsCommentArray addObject:model];
    }
    [self.GoodsDetailsTableView reloadData];
}
//设置控件
- (void) initGDController
{
    //显示
    self.GoodsDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
    self.GoodsDetailsTableView.delegate = self;
    self.GoodsDetailsTableView.dataSource = self;
    self.GoodsDetailsTableView.showsVerticalScrollIndicator = NO;
    self.GoodsDetailsTableView.backgroundColor = BGColor;
    self.GoodsDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.GoodsDetailsTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //控制显示与隐藏
    self.backTopView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 64)];
    self.backTopView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backTopView];
    UILabel *GoodsLabel = [[UILabel alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, 20, CYScreanW * 0.6, 35)];
    GoodsLabel.text = @"辣家小厨";
    GoodsLabel.textAlignment = NSTextAlignmentCenter;
    GoodsLabel.backgroundColor = [UIColor clearColor];
    GoodsLabel.textColor = [UIColor whiteColor];
    [self.backTopView addSubview:GoodsLabel];
    self.GoodsLabel = GoodsLabel;
    //左
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.01, 20, 44, 44)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(backMerchants) forControlEvents:UIControlEventTouchUpInside];
    [self.backTopView addSubview:btnLeft];
}
//返回按钮
- (void) backMerchants
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    [self.backTopView setHidden:NO];
}
- (void) viewDidDisappear:(BOOL)animated
{
    [self.backTopView setHidden:YES];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return CYScreanH * 0.08 + [self.detailsCommentHeight[indexPath.row] floatValue];
    }
    else
    {
        if (indexPath.row == 0)
        {
            return CYScreanH * 0.25;
        }
        else if (indexPath.row == 1 || indexPath.row == 2)
        {
            return CYScreanH * 0.04;
        }
        else if (indexPath.row == 5)
        {
            NSString *intro = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"intro"]];
            NSString *image = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"img"]];
            CGSize sizeP = CGSizeMake(CYScreanW * 0.7, CGFLOAT_MAX);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:intro.length > 0 ? intro : @""]];
            return  layout.textBoundingSize.height + (image.length > 6 ? CYScreanH * 0.23 : CYScreanH * 0.02);
        }
        else //4,6
        {
            return CYScreanH * 0.06;
        }
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 7;
    }
    else
        return self.detailsCommentArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:13];
    if (indexPath.section == 0)
    {
        static NSString *ID = @"cellComMallId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *showImageString;//显示图片
        NSString *nameString;//
        NSString *numberString;//
        NSString *moneyString;//
        NSString *contentString;//
        if (self.GoodsDetailsDict)
        {
            showImageString = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"img"]];
            nameString = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"name"]];
            numberString = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"successnum"]];
            moneyString = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"price"]];
            contentString = [NSString stringWithFormat:@"%@",[self.GoodsDetailsDict objectForKey:@"intro"]];
        }
        //头部名字
        self.GoodsLabel.text = [NSString stringWithFormat:@"%@",nameString];
        
        if (indexPath.row == 0)
        {
            if (self.showImmage == nil && showImageString.length)
            {
                self.showImmage = [[UIImageView alloc] init];
                [self.showImmage sd_setImageWithURL:[NSURL URLWithString:showImageString]];
                [cell.contentView addSubview:self.showImmage];
                [self.showImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(0);
                     make.right.equalTo(cell.mas_right).offset(0);
                     make.top.equalTo(cell.mas_top).offset(0);
                     make.height.mas_equalTo(CYScreanH * 0.25);
                 }];
            }
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = nameString;
            cell.textLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
            cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15];
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"月售 %@",numberString];
            cell.textLabel.textColor = [UIColor colorWithRed:0.318 green:0.318 blue:0.318 alpha:1.00];
            cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
        }
        else if (indexPath.row == 3)
        {
            if (self.hideButtonStepper == nil && moneyString.length)
            {
                UILabel *label = [[UILabel alloc] init];
                label.text = [NSString stringWithFormat:@"￥%@",moneyString];
                label.textAlignment = NSTextAlignmentLeft;
                label.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                label.font = [UIFont fontWithName:@"Arial" size:15];
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
                    make.top.equalTo(cell.mas_top).offset(0);
                    make.width.mas_equalTo(CYScreanW * 0.3);
                    make.height.mas_equalTo(CYScreanH * 0.04);
                }];
                //加减按钮
                self.hideButtonStepper = [[PKYStepper alloc] init];
                [cell.contentView addSubview:self.hideButtonStepper];
                [_hideButtonStepper mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.01);
                     make.width.mas_equalTo(CYScreanW * 0.25);
                     make.height.mas_equalTo(CYScreanH * 0.04);
                     make.top.equalTo(cell.mas_top).offset(0);
                 }];
                self.hideButtonStepper.maximum = 100000.0f;
                self.hideButtonStepper.hidesDecrementWhenMinimum = YES;
                self.hideButtonStepper.hidesIncrementWhenMaximum = YES;
                self.hideButtonStepper.buttonWidth = CYScreanH * 0.05;
                
                [self.hideButtonStepper setBorderWidth:0.0f];
                
                self.hideButtonStepper.countLabel.layer.borderWidth = 0.0f;
                self.hideButtonStepper.countLabel.textColor = [UIColor blackColor];
                
                [self.hideButtonStepper.incrementButton setTitle:@"" forState:UIControlStateNormal];
                [self.hideButtonStepper.incrementButton setImage:[UIImage imageNamed:@"icon_add_03"] forState:UIControlStateNormal];
                self.hideButtonStepper.incrementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                //self.hideButtonStepper.incrementButton.imageEdgeInsets = UIEdgeInsetsMake(0, (width - sizeImage.width) / 2, 0, 0);
                
                
                //减按钮
                [self.hideButtonStepper.decrementButton setTitle:@"" forState:UIControlStateNormal];
                [self.hideButtonStepper.decrementButton setImage:[UIImage imageNamed:@"icon_des_03"] forState:UIControlStateNormal];
                self.hideButtonStepper.decrementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                
                [self.hideButtonStepper setButtonTextColor:[UIColor whiteColor] forState:UIControlStateNormal];
                Singleton *shareSing = [Singleton getSingleton];
                for (NSDictionary *dict in shareSing.SelectMerchantsGArray)
                {
                    MerchantsModel *model = [dict objectForKey:@"goods"];
                    NSLog(@"model.goodsId = %@,self.GoodsIdString = %@",model.goodsId,self.GoodsIdString);
                    
                    if ([model.goodsId isEqualToString:self.GoodsIdString])
                    {
                        self.hideButtonStepper.value = [[dict objectForKey:@"number"] floatValue];
                        self.hideButtonStepper.countLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"number"]];
                        break;
                    }
                }
                //创建一个本地变量
                __weak typeof(self) weakSelf = self;
                //增
                self.hideButtonStepper.incrementCallback = ^(PKYStepper *stepper, float count)
                {
                    NSLog(@"count = %.0f",count);
                    if (count != 0)
                    {
                        stepper.countLabel.text = [NSString stringWithFormat:@"%ld",[stepper.countLabel.text integerValue] + 1];
                        stepper.value = [stepper.countLabel.text floatValue];
                        [weakSelf setCarData];
                    }
                };
                //减
                self.hideButtonStepper.decrementCallback = ^(PKYStepper *stepper, float count)
                {
                    NSLog(@"count = %.0f",count);
                    if (count != 0.0)
                    {
                        stepper.countLabel.text = [NSString stringWithFormat:@"%ld",[stepper.countLabel.text integerValue] - 1];
                        stepper.value = [stepper.countLabel.text floatValue];
                        [weakSelf setCarData];
                    }
                    else
                    {
                        stepper.countLabel.text = @"";
                        [weakSelf setCarData];
                    }
                };
                [self.hideButtonStepper setup];
                //分割线
                UIImageView *segmentationImmage = [[UIImageView alloc] init];
                segmentationImmage.backgroundColor = BGColor;
                [cell.contentView addSubview:segmentationImmage];
                [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(0);
                     make.right.equalTo(cell.mas_right).offset(0);
                     make.bottom.equalTo(cell.mas_bottom).offset(0);
                     make.height.mas_equalTo(1);
                 }];
            }
        }
        else if (indexPath.row == 4)
        {
            if (self.promptImmage == nil)
            {
                //图片
                self.promptImmage = [[UIImageView alloc] init];
                self.promptImmage.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                [cell.contentView addSubview:self.promptImmage];
                [self.promptImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
                     make.width.mas_equalTo(3);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.015);
                     make.height.mas_equalTo(CYScreanH * 0.03);
                 }];
                //
                UILabel *shopLabel = [[UILabel alloc] init];
                shopLabel.textColor = [UIColor colorWithRed:0.318 green:0.318 blue:0.318 alpha:1.00];
                shopLabel.text = @"商品详情";
                shopLabel.textAlignment = NSTextAlignmentLeft;
                shopLabel.font = [UIFont fontWithName:@"Arial" size:15];
                [cell.contentView addSubview:shopLabel];
                [shopLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(self.promptImmage.mas_right).offset(CYScreanW * 0.01);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.01);
                     make.height.mas_equalTo(CYScreanH * 0.04);
                     make.width.mas_equalTo(CYScreanW * 0.3);
                 }];
            }
        }
        else if (indexPath.row == 5)
        {
            if (self.goodsImmage == nil && contentString.length)
            {
                NSString *intro = [NSString stringWithFormat:@"%@",contentString];
                UILabel *promptLabel = [[UILabel alloc] init];
                promptLabel.textColor = [UIColor colorWithRed:0.318 green:0.318 blue:0.318 alpha:1.00];
                promptLabel.text = [NSString stringWithFormat:@"%@",intro];
                promptLabel.textAlignment = NSTextAlignmentLeft;
                promptLabel.numberOfLines = 0;
                [promptLabel sizeToFit];
                promptLabel.font = [UIFont fontWithName:@"Arial" size:15];
                [cell.contentView addSubview:promptLabel];
                [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.01);
                     make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.03);
                 }];
                //图片
                self.goodsImmage = [[UIImageView alloc] init];
                [self.goodsImmage sd_setImageWithURL:[NSURL URLWithString:showImageString]];
                [cell.contentView addSubview:self.goodsImmage];
                [self.goodsImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.2);
                     make.width.mas_equalTo(CYScreanW * 0.6);
                     make.top.equalTo(promptLabel.mas_bottom).offset(CYScreanH * 0.01);
                     make.height.mas_equalTo(CYScreanH * 0.2);
                 }];
                
                //分割线
                UIImageView *segmentationImmage = [[UIImageView alloc] init];
                segmentationImmage.backgroundColor = BGColor;
                [cell.contentView addSubview:segmentationImmage];
                [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(0);
                     make.right.equalTo(cell.mas_right).offset(0);
                     make.bottom.equalTo(cell.mas_bottom).offset(0);
                     make.height.mas_equalTo(1);
                 }];
            }
        }
        else if (indexPath.row == 6)
        {
            if (self.commentImmage == nil)
            {
                //图片
                self.commentImmage = [[UIImageView alloc] init];
                self.commentImmage.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
                [cell.contentView addSubview:self.commentImmage];
                [self.commentImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.03);
                     make.width.mas_equalTo(3);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.015);
                     make.height.mas_equalTo(CYScreanH * 0.03);
                 }];
                //
                UILabel *shopLabel = [[UILabel alloc] init];
                shopLabel.textColor = [UIColor colorWithRed:0.318 green:0.318 blue:0.318 alpha:1.00];
                shopLabel.text = @"商品评价";
                shopLabel.textAlignment = NSTextAlignmentLeft;
                shopLabel.font = [UIFont fontWithName:@"Arial" size:15];
                [cell.contentView addSubview:shopLabel];
                [shopLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(self.commentImmage.mas_right).offset(CYScreanW * 0.01);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.01);
                     make.height.mas_equalTo(CYScreanH * 0.04);
                     make.width.mas_equalTo(CYScreanW * 0.3);
                 }];
                //分割线
                UIImageView *segmentationImmage = [[UIImageView alloc] init];
                segmentationImmage.backgroundColor = BGColor;
                [cell.contentView addSubview:segmentationImmage];
                [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(0);
                     make.right.equalTo(cell.mas_right).offset(0);
                     make.bottom.equalTo(cell.mas_bottom).offset(0);
                     make.height.mas_equalTo(1);
                 }];
            }
        }
        else if (indexPath.row == 7)
        {
            if (self.commentNumberLabel == nil)
            {
                //评分
                self.commentNumberLabel = [[UILabel alloc] init];
                self.commentNumberLabel.textColor = [UIColor colorWithRed:0.176 green:0.506 blue:0.906 alpha:1.00];
                self.commentNumberLabel.text = @"9.5";
                self.commentNumberLabel.textAlignment = NSTextAlignmentCenter;
                self.commentNumberLabel.font = [UIFont fontWithName:@"Arial" size:30];
                [cell.contentView addSubview:self.commentNumberLabel];
                [self.commentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(0);
                     make.width.mas_equalTo(CYScreanW * 0.3);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04);
                     make.height.mas_equalTo(CYScreanH * 0.06);
                 }];
                //提示
                UILabel *promptLabel = [[UILabel alloc] init];
                promptLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
                promptLabel.font = font;
                promptLabel.textAlignment = NSTextAlignmentCenter;
                promptLabel.text = @"综合评分";
                [cell.contentView addSubview:promptLabel];
                [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(0);
                     make.width.mas_equalTo(CYScreanW * 0.3);
                     make.top.equalTo(self.commentNumberLabel.mas_bottom).offset(0);
                     make.height.mas_equalTo(CYScreanH * 0.04);
                 }];
                //竖线  vertical
                UIImageView *verticalImmage = [[UIImageView alloc] init];
                verticalImmage.backgroundColor = BGColor;
                [cell.contentView addSubview:verticalImmage];
                [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(self.commentNumberLabel.mas_right).offset(0);
                     make.width.mas_equalTo(1);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04);
                     make.height.mas_equalTo(CYScreanH * 0.1);
                 }];
                //服务、送达
                NSArray *array = @[@"服务态度",@"商品评分",@"送达时间"];
                for (NSInteger i = 0; i < array.count; i ++)
                {
                    UILabel *label = [[UILabel alloc] init];
                    label.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
                    label.font = font;
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = [NSString stringWithFormat:@"%@",array[i]];
                    [cell.contentView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.left.equalTo(verticalImmage.mas_right).offset(CYScreanW * 0.06);
                         make.width.mas_equalTo(CYScreanW * 0.25);
                         make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04 + i * CYScreanH * 0.1 / 3);
                         make.height.mas_equalTo(CYScreanH * 0.1 / 3);
                     }];
                }
                
                
                //服务态度星星
                UIView *blackStart = [[UIView alloc] init];
                blackStart.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:blackStart];
                [blackStart mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(verticalImmage.mas_right).offset(CYScreanW * 0.32);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04 + (CYScreanH * 0.1 / 3 - (CYScreanH - 64) * 0.02) / 2);
                     make.width.mas_equalTo(CYScreanW * 0.15);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.02);
                 }];
                for (NSInteger i = 0; i < 5; i ++)
                {
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
                    image.image = [UIImage imageNamed:@"star_blank"];
                    image.userInteractionEnabled = YES;
                    [blackStart addSubview:image];
                }
                UIView *_redStart = [[UIView alloc] init];
                _redStart.backgroundColor = [UIColor clearColor];
                _redStart.clipsToBounds = YES;//超出部分不显示
                [cell.contentView addSubview:_redStart];
                [_redStart mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.height.and.left.and.top.equalTo(blackStart);
                     make.width.equalTo(blackStart.mas_width).multipliedBy(.75f);
                 }];
                for (NSInteger i = 0; i < 5; i ++)
                {
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(  CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, (CYScreanH - 64) * 0.02)];
                    image.image = [UIImage imageNamed:@"star"];
                    [_redStart addSubview:image];
                }
                //
                UILabel *startLabel = [[UILabel alloc] init];
                startLabel.textColor = [UIColor colorWithRed:0.812 green:0.471 blue:0.000 alpha:1.00];
                startLabel.font = font;
                startLabel.textAlignment = NSTextAlignmentLeft;
                startLabel.text = @"9.5分";
                [cell.contentView addSubview:startLabel];
                [startLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(blackStart.mas_right).offset(CYScreanW * 0.02);
                     make.width.mas_equalTo(CYScreanW * 0.15);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04);
                     make.height.mas_equalTo(CYScreanH * 0.1 / 3);
                 }];
                
                
                
                //商品评分
                UIView *blackStartt = [[UIView alloc] init];
                blackStartt.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:blackStartt];
                [blackStartt mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(verticalImmage.mas_right).offset(CYScreanW * 0.32);
                     make.top.equalTo(blackStart.mas_bottom).offset(CYScreanH * 0.1 / 3 - (CYScreanH - 64) * 0.02);
                     make.width.mas_equalTo(CYScreanW * 0.15);
                     make.height.mas_equalTo((CYScreanH - 64) * 0.02);
                 }];
                for (NSInteger i = 0; i < 5; i ++)
                {
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, (CYScreanH - 64) * 0.02)];
                    image.image = [UIImage imageNamed:@"star_blank"];
                    image.userInteractionEnabled = YES;
                    [blackStartt addSubview:image];
                }
                UIView *_redStartt = [[UIView alloc] init];
                _redStartt.backgroundColor = [UIColor clearColor];
                _redStartt.clipsToBounds = YES;//超出部分不显示
                [cell.contentView addSubview:_redStartt];
                [_redStartt mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.height.and.left.and.top.equalTo(blackStartt);
                     make.width.equalTo(blackStartt.mas_width).multipliedBy(.75f);
                 }];
                for (NSInteger i = 0; i < 5; i ++)
                {
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(  CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
                    image.image = [UIImage imageNamed:@"star"];
                    [_redStartt addSubview:image];
                }
                //
                UILabel *startTLabel = [[UILabel alloc] init];
                startTLabel.textColor = [UIColor colorWithRed:0.812 green:0.471 blue:0.000 alpha:1.00];
                startTLabel.font = font;
                startTLabel.textAlignment = NSTextAlignmentLeft;
                startTLabel.text = @"9.5分";
                [cell.contentView addSubview:startTLabel];
                [startTLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(blackStartt.mas_right).offset(CYScreanW * 0.02);
                     make.width.mas_equalTo(CYScreanW * 0.15);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04 + 1 * CYScreanH * 0.1 / 3);
                     make.height.mas_equalTo(CYScreanH * 0.1 / 3);
                 }];
                
                
                
                //时间
                UILabel *timeLabel = [[UILabel alloc] init];
                timeLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
                timeLabel.font = font;
                timeLabel.textAlignment = NSTextAlignmentLeft;
                timeLabel.text = @"39分钟";
                [cell.contentView addSubview:timeLabel];
                [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(verticalImmage.mas_right).offset(CYScreanW * 0.32);
                     make.width.mas_equalTo(CYScreanW * 0.25);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.04 + 2 * CYScreanH * 0.1 / 3);
                     make.height.mas_equalTo(CYScreanH * 0.1 / 3);
                 }];
                
            }
        }
        return cell;
    }
    else
    {
        static NSString *ID = @"merComCellId";
        self.merchantsCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.merchantsCell == nil)
        {
            self.merchantsCell = [[MerchantsCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.merchantsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.merchantsCell.model = self.detailsCommentArray[indexPath.row];
        return  self.merchantsCell;
    }
    
    

}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
    CGFloat alpha = scrollView.contentOffset.y / (CYScreanH * 0.25);

//    NSLog(@"alpha = %f,scrollView.contentOffset.y = %f",alpha,scrollView.contentOffset.y);
    // 设置导航条的背景图片 其透明度随  alpha 值 而改变
    [self.backTopView setBackgroundColor:[UIColor colorWithPatternImage:[self imageWithColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:alpha]]]];
}
/// 使用颜色填充图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
//获取商品详情
- (void) getGoodsRequest
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/productDetail",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:self.GoodsIdString forKey:@"id"];
    NSLog(@"parames = %@",parames);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"获取商品详情请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             self.GoodsDetailsDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
             [self.GoodsDetailsTableView reloadData];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
//获取商品评论列表
- (void) getGoodsCommentRequest
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/shopEvaluateList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:self.MerchantsId forKey:@"shopId"];
    NSLog(@"parames = %@",parames);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"获取商品评论列表请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [self initCommentModel:[NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]]];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
}
//评论数据
- (void) initCommentModel:(NSArray *)array
{
    NSArray *commentArrayAll = [MercahntsPageDataDealW initCommentModel:array];
    if (commentArrayAll.count) {
        self.detailsCommentArray = [NSMutableArray arrayWithArray:commentArrayAll[0]];
        self.detailsCommentHeight = [NSMutableArray arrayWithArray:commentArrayAll[1]];
    }
    [self.GoodsDetailsTableView reloadData];
}
//设置购物车数据
- (void) setCarData
{
    Singleton *goodsSing = [Singleton getSingleton];
    BOOL whetherFirst = NO;//是否有数据
    //遍历已选择商家数据
    for (NSInteger i = 0; i < goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *goodsDict = [NSDictionary dictionaryWithDictionary:goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [goodsDict objectForKey:@"goods"];
        //获取存入的商品id
        if ([model.goodsId integerValue]  == [self.GoodsIdString integerValue])
        {
            whetherFirst = YES;
            if ([self.hideButtonStepper.countLabel.text integerValue] > 0)
            {
                //保存商品数据和商品数量
                NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
                parames[@"goods"] = model;
                parames[@"number"] = self.hideButtonStepper.countLabel.text;
                [goodsSing.SelectMerchantsGArray replaceObjectAtIndex:i withObject:parames];
            }
            else
            {
                //如果为0则删除本条记录:可能之前有，但是操作之后数量变为0就没有了
                [goodsSing.SelectMerchantsGArray removeObjectAtIndex:i];
            }
        }
    }
    //没有则添加进去
    if (whetherFirst == NO)
    {
        //保存商品数据和商品数量
        NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
        parames[@"goods"] = self.model;
        parames[@"number"] = self.hideButtonStepper.countLabel.text;
        
        [goodsSing.SelectMerchantsGArray addObject:parames];
        [self addModelDeToSID:parames];
    }
    NSLog(@"goodsSing.SelectMerchantsGArray = %@，goodsSing.SelectIdGArray = %@",goodsSing.SelectMerchantsGArray,goodsSing.SelectIdGArray);
    
}
//将没有的id添加进来
- (void) addModelDeToSID:(NSDictionary *)parames
{
    Singleton *goodsSing = [Singleton getSingleton];
    BOOL whether = NO;
    for (NSDictionary *dict in goodsSing.SelectIdGArray)
    {
        MerchantsModel *model = [dict objectForKey:@"goods"];
        if ([model.goodsId integerValue] == [self.GoodsIdString integerValue])
        {
            whether = YES;
        }
    }
    if (whether == NO)
    {
        [goodsSing.SelectIdGArray addObject:parames];
    }
}
@end
