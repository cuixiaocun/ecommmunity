//
//  MerchantsPageViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MerchantsPageViewController.h"

@interface MerchantsPageViewController ()

@end

@implementation MerchantsPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setGoodsStyle];
    [self initCommentModel:nil];
//    [self initHeadController];
    [self initGoodsController];
    [self shopControllers];
    
    //数据请求
    [self getMerchantsGoodsRequest];
    [self getMerchantsRequest];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    
    //隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    //防止滑动返回隐藏
    self.shoppingBarView.hidden = NO;
    //选择过商品
    if (self.goodsSing.SelectIdGArray.count)
    {
        //每次都要赋值
        self.goodsSing.RemoveArray = [NSMutableArray arrayWithArray:self.goodsSing.SelectIdGArray];
        NSLog(@"self.goodsSing.RemoveArray = %@,self.goodsSing.SelectIdGArray = %@",self.goodsSing.RemoveArray,self.goodsSing.SelectIdGArray);
        [self.GoodsPlistTableView reloadData];
        [self setPlistModel];
        [self.shopListTableView reloadData];
    }
    //计算购物车总价
    [self calculateSelectGoodsMoney];
}
- (void) viewWillDisappear:(BOOL)animated
{
    self.maskView.hidden = YES;

    [MBProgressHUD hideHUDForView:self.view];//离开页面是将进度条隐藏
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count - 2] == self) {
        //当前视图控制器在栈中，故为push操作
        self.shoppingBarView.hidden = YES;
        NSLog(@"push");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        [self.shoppingBarView removeFromSuperview];
        [self.navigationController.navigationBar setHidden:NO];
        NSLog(@"pop");
    }
}
//设置样式
- (void) setGoodsStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.GoodsTypeArray = [[NSMutableArray alloc] init];
    self.GoodsPlistModelArray = [[NSMutableArray alloc] init];
    self.commentArray = [[NSMutableArray alloc] init];
    self.commentHighArray = [[NSMutableArray alloc] init];
    self.shopListArray = [[NSMutableArray alloc] init];
    //每个商家选择的商品
    self.goodsSing = [Singleton getSingleton];
    self.goodsSing.SelectMerchantsGArray = [[NSMutableArray alloc] init];
    self.goodsSing.NowMerchsntsGArray = [[NSMutableArray alloc] init];
    self.goodsSing.SelectIdGArray = [[NSMutableArray alloc] init];
    self.goodsSing.whetherBeginSelect = NO;
}
//返回
- (void) backButtonAD
{
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化商品页面
- (void) initGoodsController
{
    self.headView = [[MerchantsHeadView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH * 0.27)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    //背景图
    self.backView = [[UIView alloc] initWithFrame:CGRectMake( 0, CYScreanH * 0.27, CYScreanW, CYScreanH * 0.73)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.userInteractionEnabled = NO;
    [self.view addSubview:self.backView];
    
    //商品按钮
    CGSize size = [@"商品" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    CGSize sizeImage = [UIImage imageNamed:@"icon_drop_down_def"].size;
    self.goodsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CYScreanW / 2, CYScreanH * 0.05)];
    self.goodsButton.backgroundColor = [UIColor whiteColor];
    [self.goodsButton setTitle:@"商品" forState:UIControlStateNormal];
    [self.goodsButton setTitleColor:[UIColor colorWithRed:0.102 green:0.494 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.goodsButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.goodsButton setImage:[UIImage imageNamed:@"icon_drop_down_def"] forState:UIControlStateNormal];
    [self.goodsButton setImage:[UIImage imageNamed:@"icon_drop_down_selected"] forState:UIControlStateSelected];
    self.goodsButton.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + 5, 0, - size.width - 5);
    self.goodsButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizeImage.width, 0, sizeImage.width);
    [self.goodsButton addTarget:self action:@selector(merchantsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.goodsButton];
    self.goodsButton.selected = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW / 2 - 0.5, CYScreanH * 0.005, 1, CYScreanH * 0.04)];
    imageView.backgroundColor = [UIColor grayColor];
    [self.backView addSubview:imageView];
    //评论
    size = [@"评价" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 2, 0, CYScreanW / 2, CYScreanH * 0.05)];
    self.commentButton.backgroundColor = [UIColor whiteColor];
    [self.commentButton setImage:[UIImage imageNamed:@"icon_drop_down_def"] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"icon_drop_down_selected"] forState:UIControlStateSelected];
    self.commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + 5, 0, - size.width - 5);
    self.commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizeImage.width, 0, sizeImage.width);
    [self.commentButton setTitle:@"评价" forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor colorWithRed:0.102 green:0.494 blue:0.898 alpha:1.00] forState:UIControlStateSelected];
    [self.commentButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(merchantsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.commentButton];
    self.commentButton.selected = NO;
    //拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    
    [self.backView addGestureRecognizer:panGesture];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [self.backView addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.backView.mas_left).offset(0);
         make.right.equalTo(self.backView.mas_right).offset(0);
         make.bottom.equalTo(self.goodsButton.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //商品分类
    self.GoodsTypeTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, CYScreanH * 0.05, CYScreanW * 0.2, CYScreanH * 0.68)];
    self.GoodsTypeTableView.delegate = self;
    self.GoodsTypeTableView.dataSource = self;
    self.GoodsTypeTableView.showsVerticalScrollIndicator = NO;
    self.GoodsTypeTableView.scrollEnabled = NO;
    self.GoodsTypeTableView.backgroundColor = [UIColor colorWithRed:0.863 green:0.863 blue:0.863 alpha:1.00];
    self.GoodsTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.backView addSubview:self.GoodsTypeTableView];
    [self.GoodsTypeTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.backView.mas_left).offset(0);
         make.top.equalTo(self.backView.mas_top).offset(CYScreanH * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.2);
         make.bottom.equalTo(self.backView.mas_bottom).offset(0);
    }];
    //商品列表
    self.GoodsPlistTableView = [[UITableView alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, CYScreanH * 0.05, CYScreanW * 0.8, CXCScreanH-64-(CYScreanH * 0.08)- CYScreanH * 0.05)];
    self.GoodsPlistTableView.delegate = self;
    self.GoodsPlistTableView.dataSource = self;
    self.GoodsPlistTableView.scrollEnabled = NO;
    self.GoodsPlistTableView.showsVerticalScrollIndicator = NO;
    self.GoodsPlistTableView.backgroundColor = [UIColor whiteColor];
    self.GoodsPlistTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.backView addSubview:self.GoodsPlistTableView];
//    [self.GoodsPlistTableView mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.GoodsTypeTableView.mas_right).offset(0);
//         make.top.and.bottom.equalTo(self.GoodsTypeTableView);
//         make.width.mas_equalTo(CYScreanW * 0.8);
//     }];
    //评论列表
    self.GoodsCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, CYScreanH * 0.05, CYScreanW,  CXCScreanH-64-(CYScreanH * 0.05))];
    self.GoodsCommentTableView.delegate = self;
    self.GoodsCommentTableView.dataSource = self;
    self.GoodsCommentTableView.scrollEnabled = NO;
    self.GoodsCommentTableView.showsVerticalScrollIndicator = NO;
    self.GoodsCommentTableView.backgroundColor = [UIColor whiteColor];
    self.GoodsCommentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.backView addSubview:self.GoodsCommentTableView];
    self.GoodsCommentTableView.hidden = YES;
    //初始化导航栏
    [self initNavigation];
}
//导航栏
- (void) initNavigation
{
    //控制显示与隐藏
    self.navigationMView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, 64)];
    self.navigationMView.backgroundColor = [UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:1.0];
    [self.view addSubview:self.navigationMView];
    
    
    
    
    //左
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake( 0, 0, 100, 64)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setImageEdgeInsets:UIEdgeInsetsMake(20,10,20,-50)];
//    [btnLeft setImage:[UIImage imageNamed:@"未标题-1_06"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(backButtonAD) forControlEvents:UIControlEventTouchUpInside];
    //图片
    UIImageView *showImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 13,20)];
    [showImage setImage:[UIImage imageNamed:@"nav_back"]];
    [btnLeft addSubview:showImage];

    
    
    
    [self.navigationMView addSubview:btnLeft];
}
//购物栏
- (void) shopControllers
{
    //购物背景view
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.navigationController.view addSubview:self.maskView];
    self.maskView.hidden = YES;
    //添加单击手势防范
    UITapGestureRecognizer *rightTapT = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskHidden:)];
    rightTapT.numberOfTapsRequired = 1;
    [self.maskView addGestureRecognizer:rightTapT];

    //提示
    self.promptView = [[UIView alloc] initWithFrame:CGRectMake( 0, CYScreanH * 0.2, CYScreanW, CYScreanH * 0.06)];
    self.promptView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
    [self.maskView addSubview:_promptView];
    //图片
    UIImageView *showImage = [[UIImageView alloc] init];
    showImage.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [self.promptView addSubview:showImage];
    [showImage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.promptView.mas_left).offset(CYScreanW * 0.02);
         make.width.mas_equalTo(5);
         make.top.equalTo(self.promptView.mas_top).offset(CYScreanH * 0.01);
         make.height.mas_equalTo(CYScreanH * 0.04);
     }];
    //
    UILabel *shopLabel = [[UILabel alloc] init];
    shopLabel.textColor = [UIColor blackColor];
    shopLabel.text = @"购物车";
    shopLabel.textAlignment = NSTextAlignmentLeft;
    shopLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.promptView addSubview:shopLabel];
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(showImage.mas_right).offset(CYScreanW * 0.01);
         make.top.equalTo(self.promptView.mas_top).offset(CYScreanH * 0.01);
         make.height.mas_equalTo(CYScreanH * 0.04);
         make.width.mas_equalTo(CYScreanW * 0.3);
     }];
    //清空按钮
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.75, CYScreanH * 0.01, CYScreanW * 0.2, CYScreanH * 0.04)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setTitle:@"清空" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(removeAllData) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [btnLeft setTitleColor:[UIColor colorWithRed:0.318 green:0.318 blue:0.318 alpha:1.00] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"icon_bin_shopping"] forState:UIControlStateNormal];
    btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.promptView addSubview:btnLeft];
    
    //购物列表
    self.shopListTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, CYScreanH * 0.26, CYScreanW, CYScreanH * 0.62)];
    self.shopListTableView.delegate = self;
    self.shopListTableView.dataSource = self;
    self.shopListTableView.showsVerticalScrollIndicator = NO;
    self.shopListTableView.backgroundColor = [UIColor whiteColor];
    self.shopListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.maskView addSubview:self.shopListTableView];
    


    //提示
    UILabel *needLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, CYScreanH * 0.88, CYScreanW, CYScreanH * 0.04)];
    needLabel.text = @"商品如需分开发包，请使用多人订餐";
    needLabel.textColor = [UIColor grayColor];
    needLabel.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
    needLabel.textAlignment = NSTextAlignmentCenter;
    needLabel.font = [UIFont fontWithName:@"Arial" size:11];
    [self.maskView addSubview:needLabel];
    //购物栏
    self.shoppingBarView = [[UIView alloc] init];
    self.shoppingBarView.tag = 1234;
    self.shoppingBarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.navigationController.view addSubview:self.shoppingBarView];
    [self.shoppingBarView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.navigationController.view.mas_left).offset(0);
         make.right.equalTo(self.navigationController.view.mas_right).offset(0);
         make.bottom.equalTo(self.navigationController.view.mas_bottom).offset(0);
         make.height.mas_equalTo(CYScreanH * 0.08);
     }];
    //添加单击手势防范
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SeeOrderTap:)];
    rightTap.numberOfTapsRequired = 1;
    [self.shoppingBarView addGestureRecognizer:rightTap];
    //购物车图标
    UIImageView *shopCartImage = [[UIImageView alloc] init];
    shopCartImage.backgroundColor = [UIColor clearColor];
//    shopCartImage.userInteractionEnabled = YES;
    shopCartImage.image = [UIImage imageNamed:@"icon_shopping_trolley_def"];//icon_shopping_trolley_selected
    [self.shoppingBarView addSubview:shopCartImage];
    [shopCartImage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.shoppingBarView.mas_left).offset(CYScreanW * 0.08);
         make.width.mas_equalTo(CYScreanH * 0.1);
         make.bottom.equalTo(self.shoppingBarView.mas_bottom).offset(-CYScreanH * 0.03);
         make.height.mas_equalTo(CYScreanH * 0.1);
     }];
    self.shopCartImage = shopCartImage;
//    //添加单击手势防范
//    [self.shopCartImage addGestureRecognizer:rightTap];
    //选择的商品数量
    UIImageView *selectImage = [[UIImageView alloc] init];
    selectImage.backgroundColor = [UIColor clearColor];
    selectImage.image = [UIImage imageNamed:@"icon_round_bg_yellow"];
    [self.shoppingBarView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.shoppingBarView.mas_left).offset(CYScreanW * 0.08 + CYScreanH * 0.07);
         make.width.mas_equalTo(CYScreanH * 0.04);
         make.top.equalTo(shopCartImage.mas_top).offset(0);
         make.height.mas_equalTo(CYScreanH * 0.04);
     }];
    selectImage.hidden = YES;
    self.selectImage = selectImage;
    //商品数量
    UILabel *selectNumberLabel = [[UILabel alloc] init];
    selectNumberLabel.font = [UIFont fontWithName:@"Arial" size:11];
    selectNumberLabel.textAlignment = NSTextAlignmentCenter;
    selectNumberLabel.textColor = [UIColor whiteColor];
    [self.shoppingBarView addSubview:selectNumberLabel];
    [selectNumberLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.shoppingBarView.mas_left).offset(CYScreanW * 0.08 + CYScreanH * 0.07);
         make.width.mas_equalTo(CYScreanH * 0.04);
         make.top.equalTo(shopCartImage.mas_top).offset(0);
         make.height.mas_equalTo(CYScreanH * 0.04);
     }];
    self.selectNumberLabel = selectNumberLabel;
    //商品价格
    UILabel *selectPriceLabel = [[UILabel alloc] init];
    selectPriceLabel.font = [UIFont fontWithName:@"Arial" size:13];
    selectPriceLabel.textColor = [UIColor whiteColor];
    [self.shoppingBarView addSubview:selectPriceLabel];
    [selectPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(shopCartImage.mas_right).offset(CYScreanW * 0.03);
         make.width.mas_equalTo(CYScreanW * 0.3);
         make.top.equalTo(self.shoppingBarView.mas_top).offset(CYScreanH * 0.01);
         make.height.mas_equalTo(CYScreanH * 0.03);
     }];
    self.selectPriceLabel = selectPriceLabel;
    //配送费
    UILabel *sendMoneyLabel = [[UILabel alloc] init];
    sendMoneyLabel.font = [UIFont fontWithName:@"Arial" size:13];
    sendMoneyLabel.textColor = [UIColor whiteColor];
    [self.shoppingBarView addSubview:sendMoneyLabel];
    [sendMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(selectPriceLabel);
         make.width.mas_equalTo(CYScreanW * 0.3);
         make.top.equalTo(selectPriceLabel.mas_bottom).offset(0);
         make.height.mas_equalTo(CYScreanH * 0.03);
     }];
    self.sendMoneyLabel = sendMoneyLabel;
    //按钮
    UIButton *confirmButton = [[UIButton alloc] init];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    confirmButton.userInteractionEnabled = NO;
    confirmButton.backgroundColor = [UIColor grayColor];
    [confirmButton addTarget:self action:@selector(settlementButton) forControlEvents:UIControlEventTouchUpInside];
    [self.shoppingBarView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.shoppingBarView.mas_right).offset(0);
         make.width.mas_equalTo(CYScreanW * 0.3);
         make.top.equalTo(self.shoppingBarView.mas_top).offset(0);
         make.bottom.equalTo(self.shoppingBarView.mas_bottom).offset(0);
     }];
    self.confirmButton = confirmButton;
}
//清空购物车
- (void) removeAllData
{
    [self calculateSelectGoodsMoney];
    //每次都要赋值
    self.goodsSing.RemoveArray = self.goodsSing.SelectMerchantsGArray;
//    self.goodsSing.SelectMerchantsGArray = [[NSMutableArray alloc] init];

//    [self setPlistModel];
    
    
    self.shopCartImage.image = [UIImage imageNamed:@"icon_shopping_trolley_def"];
    self.selectPriceLabel.text = @"";
    [self.confirmButton setTitle:[NSString stringWithFormat:@"%@起送",[self.MerchantsDetailsDict objectForKey:@"minAmount"]] forState:UIControlStateNormal];//起送价格
    self.selectImage.hidden = YES;
    self.selectNumberLabel.text = @"";
    
    
    [self  setCarData ];
}
//设置购物车数据
- (void) setCarData
{
    Singleton *goodsSing = [Singleton getSingleton];
    
    //清空种类的数量
    for (NSInteger i = 0; i < _GoodsTypeArray.count; i ++)
    {
        GoodsTypeModel *goodm =[_GoodsTypeArray objectAtIndex:i];
        goodm.selectGoodsNumber =0;
    }
     self.goodsSing.SelectMerchantsGArray = [[NSMutableArray alloc] init];
    
    [self  setPlistModel ];
    [self.GoodsPlistTableView reloadData];
   
    NSLog(@"goodsSing.SelectMerchantsGArray = %@",goodsSing.SelectMerchantsGArray);
    [self.GoodsTypeTableView reloadData];
 


}

//切换按钮
- (void) merchantsButton:(UIButton *)sender
{
    if (sender == self.goodsButton)//点击了商品按钮
    {
        //控制显示
        self.GoodsCommentTableView.hidden = YES;
        self.GoodsTypeTableView.hidden = NO;
        self.GoodsPlistTableView.hidden = NO;
        self.shoppingBarView.hidden = NO;
        //切换装填
        self.goodsButton.selected = YES;
        self.commentButton.selected = NO;
    }
    if (sender == self.commentButton)
    {
        //固定位置
//        self.backView.frame = CGRectMake( 0, CYScreanH * 0.27, CYScreanW, CYScreanH * 0.73);
        //切换按钮状态
        self.commentButton.selected = YES;
        self.goodsButton.selected = NO;
        //控制显示
        self.GoodsCommentTableView.hidden = NO;
        self.GoodsTypeTableView.hidden = YES;
        self.GoodsPlistTableView.hidden = YES;
        self.shoppingBarView.hidden = YES;
        if (!self.commentArray.count)//尚未回去评价总数据
        {
            [self getMerchantsCommentRequest];
        }
    }
}
// -- - - - - - - -- - - - - - - - - - - - - - -- - - - - - -- - - - - - - 拖动手势 -- - - - - - -- - - - - - - -- - - - - - -- - - - - - - -- - - -
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown)
    {
        
        NSLog(@"swipe down");
        //执行程序
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"swipe up");
        //执行程序
    }
}
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.backView];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];

    CGRect rect = [self.backView convertRect:self.backView.bounds toView:window];
    NSLog(@"translation.y = %f,rect.origin.y = %f,recognizer.view.center.y + translation.y = %f",translation.y,rect.origin.y,recognizer.view.center.y + translation.y);

    //区别上滑下滑
    if (translation.y < 0)//上滑
    {
        if (rect.origin.y > 64 - 0.000015)
        {
            //控制选择按钮
            self.backView.frame = CGRectMake( 0, (rect.origin.y + translation.y) <= 64 ? 64 : rect.origin.y + translation.y, CYScreanW, (rect.size.height - translation.y) >= (CYScreanH - 64) ? CYScreanH - 64 : rect.size.height - translation.y);
        }
        //处于顶部
        if (rect.origin.y == 64)
        {
            NSLog(@"wwww%d", self.whetherCommentScroll);
            self.GoodsTypeTableView.scrollEnabled  = YES;
            self.GoodsPlistTableView.scrollEnabled = YES;
            self.GoodsCommentTableView.scrollEnabled =YES;
            self.whetherPlistScroll = YES;
            self.whetherTypeScroll = YES;
            self.whetherCommentScroll =YES;
        }
    }
    else//下滑
    {
        if (rect.origin.y < CYScreanH * 0.27 - 0.000015)
        {
            
            self.backView.frame = CGRectMake( 0, (rect.origin.y + translation.y) >= (CYScreanH * 0.27 - 0.000015) ? CYScreanH * 0.27 : rect.origin.y + translation.y, CYScreanW, (rect.size.height - translation.y) <= CYScreanH * 0.73 ? CYScreanH * 0.73 : rect.size.height - translation.y);
        }
        //处于顶部
        if (rect.origin.y == 64)
        {
            self.GoodsTypeTableView.scrollEnabled  = NO;
            self.GoodsPlistTableView.scrollEnabled = NO;
            self.GoodsCommentTableView.scrollEnabled =NO;
            self.whetherPlistScroll = NO;
            self.whetherTypeScroll = NO;
            self.whetherCommentScroll =NO;
        }
    }
    
//    NSLog(@"rect.size.height = %f,CYScreanH * 0.73 = %f",rect.size.height,CYScreanH * 0.73 + 0.000015);
    
    //是否处于下方静止
    if ((rect.size.height - (CYScreanH * 0.73 + 0.000015)) < 0.000001 || ((CYScreanH * 0.73 + 0.000015) - rect.size.height) < 0.000001)
    {
        
        if (self.GoodsTypeY >= 0)
        {
            self.GoodsTypeTableView.scrollEnabled = YES;
            self.whetherTypeScroll = YES;
        }
        else
        {
            self.GoodsTypeTableView.scrollEnabled = NO;
            self.whetherTypeScroll = NO;
        }
        
        if (self.GoodsPlistY >= 0)
        {
            self.GoodsPlistTableView.scrollEnabled = YES;
            self.whetherPlistScroll = YES;
        }
        else
        {
            self.GoodsPlistTableView.scrollEnabled = NO;
            self.whetherPlistScroll = NO;
        }
        
        
        if (self.commentPlistY >= 0)
        {
            self.GoodsCommentTableView.scrollEnabled = YES;
            self.whetherCommentScroll = YES;
        }
        else
        {
            self.GoodsCommentTableView.scrollEnabled = NO;
            self.whetherCommentScroll = NO;
        }

    }
    
    //控制导航栏颜色
    //tableView相对于图片的偏移量
    CGFloat reOffset = rect.size.height - CYScreanH * 0.73;
    //当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
    CGFloat alpha = reOffset / ((CYScreanH - 64) - CYScreanH * 0.73);
    // 设置导航条的背景图片 其透明度随  alpha 值 而改变
    [self.navigationMView setBackgroundColor:[UIColor colorWithPatternImage:[self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]]]];
}
//查看订单列表
-(void) SeeOrderTap:(UITapGestureRecognizer *)sender
{
    //有选择的商品数据
    if (self.goodsSing.SelectMerchantsGArray.count)
    {
        if (self.maskView.hidden == YES)
        {
            self.maskView.hidden = NO;
        }
        else
            self.maskView.hidden = YES;
        [self setPlistModel];
    }
}
//隐藏蒙版
-(void) maskHidden:(UITapGestureRecognizer *)sender
{
    self.maskView.hidden = YES;
}

// -- - - - - - - -- - - - - - - - - - - - - - -- - - - - - -- - - - - - - 滚动 -- - - - - - -- - - - - - - -- - - - - - -- - - - - - - -- - - -
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//滑动结束
{
    if (scrollView == self.GoodsPlistTableView)//商品列表
    {
        //记录滚动坐标
        self.GoodsPlistY = scrollView.contentOffset.y;
        
    }
    else if(scrollView == self.GoodsTypeTableView)//商品类型
    {
        //记录滚动坐标
        self.GoodsTypeY = scrollView.contentOffset.y;
    }else if(scrollView==self.GoodsCommentTableView)//评论
    {
    
        self.commentPlistY = scrollView.contentOffset.y;

    
    }
    
}

//滑动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
       if (scrollView == self.GoodsPlistTableView)//商品列表
    {
        //滑动整体
        if (scrollView.contentOffset.y <= 0)//tableviewcell滑到顶部
        {
            self.GoodsPlistTableView.scrollEnabled = NO;
            return;
        }
        else if(self.whetherPlistScroll == YES)
        {
            
            if ((scrollView.contentOffset.y - self.GoodsPlistY) > 0.000001 && self.whetherPlistScroll == YES)//上划且允许滑动
            {
                [UIView animateWithDuration:0.3 // 动画时长
                                 animations:^{
                                     
                                     //控制选择按钮
                                     self.backView.frame = CGRectMake( 0, 64, CYScreanW, CYScreanH - 64);
                                 }];

               
            }
            self.GoodsPlistTableView.scrollEnabled = YES;
        }
        //记录滚动坐标
        self.GoodsPlistY = scrollView.contentOffset.y;
        
        //二级联动
        if(self.GoodsPlistTableView.dragging)
        {
            // 取出显示在 视图 且最靠上 的 cell 的 indexPath
            NSIndexPath *topHeaderViewIndexpath = [[self.GoodsPlistTableView indexPathsForVisibleRows] firstObject];
            NSLog(@"topHeaderViewIndexpath = %ld,%ld",topHeaderViewIndexpath.row,topHeaderViewIndexpath.section);
            // 左侧 talbelView 移动到的位置 indexPath
            
            NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
            // 移动 左侧 tableView 到 指定 indexPath 居中显示
            
            [self.GoodsTypeTableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];

        CGRect rect = [self.backView convertRect:self.backView.bounds toView:window];

        //tableView相对于图片的偏移量
        CGFloat reOffset = rect.size.height - CYScreanH * 0.73;
        //当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
        CGFloat alpha = reOffset / ((CYScreanH - 64) - CYScreanH * 0.73);
        // 设置导航条的背景图片 其透明度随  alpha 值 而改变
        [self.navigationMView setBackgroundColor:[UIColor colorWithPatternImage:[self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]]]];

    }
    else if(scrollView == self.GoodsTypeTableView)//商品类型
    {
        if (scrollView.contentOffset.y <= 0)//tableviewcell滑到顶部
        {
            self.GoodsTypeTableView.scrollEnabled = NO;
            return;
        }
        else if (self.whetherTypeScroll == YES)
        {
            self.GoodsTypeTableView.scrollEnabled = YES;
        }
        //记录滚动坐标
        self.GoodsTypeY = scrollView.contentOffset.y;
    } else if(scrollView == self.GoodsCommentTableView)//评论
    {
        if (scrollView.contentOffset.y <= 0)//tableviewcell滑到顶部
        {
            self.GoodsCommentTableView.scrollEnabled = NO;
            return;
        }
        else if (self.whetherCommentScroll == YES)
        {
            if ((scrollView.contentOffset.y - self.commentPlistY) > 0.000001 && self.whetherCommentScroll == YES)//上划且允许滑动
            {
                
                [UIView animateWithDuration:0.3 // 动画时长
                                 animations:^{
                                     
                                     //控制选择按钮
                                     self.backView.frame = CGRectMake( 0, 64, CYScreanW, CYScreanH - 64);
                                 }];
                

                //控制选择按钮
//                self.backView.frame = CGRectMake( 0, 64, CYScreanW, CYScreanH - 64);
            }

            self.GoodsCommentTableView.scrollEnabled = YES;
        }
        //记录滚动坐标
        self.commentPlistY = scrollView.contentOffset.y;
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        
        CGRect rect = [self.backView convertRect:self.backView.bounds toView:window];
        
        //tableView相对于图片的偏移量
        CGFloat reOffset = rect.size.height - CYScreanH * 0.73;
        //当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
        CGFloat alpha = reOffset / ((CYScreanH - 64) - CYScreanH * 0.73);
        // 设置导航条的背景图片 其透明度随  alpha 值 而改变
        [self.navigationMView setBackgroundColor:[UIColor colorWithPatternImage:[self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]]]];
        

    }
    
    
//    NSLog(@"scrollView.contentOffset.y = %f",scrollView.contentOffset.y);
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
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - - - - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.GoodsTypeTableView)
    {
        if (indexPath.row == self.GoodsTypeArray.count - 1)
        {
            return CYScreanH * 0.08;
        }
        else
            return CYScreanH * 0.1;
    }
    else if (tableView == self.shopListTableView)
    {
        return CYScreanH * 0.08;
    }
    else if (tableView == self.GoodsCommentTableView)
    {
       if (indexPath.row == 0)
       {
           return CYScreanH * 0.18;
       }
       else
            return (CYScreanH-64) * 0.15 + [self.commentHighArray[indexPath.row-1] floatValue];
    }
    else
    {
//        if (indexPath.section == self.GoodsPlistModelArray.count - 1)
//        {
//            return CYScreanH * 0.08;
//        }
//        else
            return CYScreanH * 0.15;
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.GoodsPlistTableView)
    {
        return self.GoodsTypeArray.count;
    }
    else
        return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.GoodsTypeTableView)//左边
    {
        return self.GoodsTypeArray.count;
    }
    else if (tableView == self.shopListTableView)//右边
    {
        NSLog(@"商品行数%ld",self.shopListArray.count);
        
        return self.shopListArray.count;
        
    }
    else if (tableView == self.GoodsCommentTableView) // 评论列表
    {
        return self.commentArray.count;
    }
    else
    {
        
        NSArray *array = [NSArray arrayWithArray:self.GoodsPlistModelArray[section]];
        NSLog(@"count = %ld",array.count);
        return array.count;
    }
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:13];
    if (tableView == self.GoodsPlistTableView) //商品列表
    {
        static NSString *ID = @"merchantsCellId";
        self.merchantsCell = [tableView cellForRowAtIndexPath:indexPath];
        if (self.merchantsCell == nil)
        {
            self.merchantsCell = [[MerchantsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.merchantsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = [NSArray arrayWithArray:self.GoodsPlistModelArray[indexPath.section]];
        self.merchantsCell.model = array[indexPath.row];
        self.merchantsCell.delegate = self;
        return  self.merchantsCell;
    }
    else if (tableView == self.shopListTableView)
    {
        static NSString *ID = @"merComCellIdT";
        self.shopCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.shopCell == nil)
        {
            self.shopCell = [[ShopListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.shopCell.backgroundColor = [UIColor whiteColor];
        self.shopCell.model = self.shopListArray[indexPath.row];
        self.shopCell.delegate = self;
        return self.shopCell;
    }
    else if (tableView == self.GoodsCommentTableView)
    {
        if (indexPath.row == 0)
        {
            static NSString *ID = @"merComCellIdT";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.backgroundColor = [UIColor whiteColor];
            //
            if (self.commentNumberLabel == nil && self.MerchantsDetailsDict)
            {
                NSString *zongHePingFen = [NSString stringWithFormat:@"%@",[self.MerchantsDetailsDict objectForKey:@"zongHePingFen"]];
                NSString *serverPingFen = [NSString stringWithFormat:@"%@",[self.MerchantsDetailsDict objectForKey:@"serverPingFen"]];
                NSString *productPingFen = [NSString stringWithFormat:@"%@",[self.MerchantsDetailsDict objectForKey:@"productPingFen"]];
                //评分
                self.commentNumberLabel = [[UILabel alloc] init];
                self.commentNumberLabel.textColor = [UIColor colorWithRed:0.176 green:0.506 blue:0.906 alpha:1.00];
                self.commentNumberLabel.text = [NSString stringWithFormat:@"%.1f",[zongHePingFen floatValue] / 10];
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
                NSArray *array = @[@"服务态度",@"商品评分"];
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
                         make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.05 + i * CYScreanH * 0.04);
                         make.height.mas_equalTo(CYScreanH * 0.04);
                     }];
                }
                //服务态度星星
                UIView *blackStart = [[UIView alloc] init];
                blackStart.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:blackStart];
                [blackStart mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(verticalImmage.mas_right).offset(CYScreanW * 0.32);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.06);
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
                     make.width.mas_equalTo(CYScreanW * 0.15 * [serverPingFen floatValue] / 10);
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
                startLabel.text = [NSString stringWithFormat:@"%.1f分",[serverPingFen floatValue] / 10];
                [cell.contentView addSubview:startLabel];
                [startLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(blackStart.mas_right).offset(CYScreanW * 0.02);
                     make.width.mas_equalTo(CYScreanW * 0.15);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.05);
                     make.height.mas_equalTo(CYScreanH * 0.04);
                 }];
                //商品评分
                UIView *blackStartt = [[UIView alloc] init];
                blackStartt.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:blackStartt];
                [blackStartt mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(verticalImmage.mas_right).offset(CYScreanW * 0.32);
                     make.top.equalTo(blackStart.mas_bottom).offset(CYScreanH * 0.02);
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
                     make.width.mas_equalTo(CYScreanW * 0.15 * [productPingFen floatValue] / 10);
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
                startTLabel.text = [NSString stringWithFormat:@"%.1f分",[productPingFen floatValue] / 10];
                [cell.contentView addSubview:startTLabel];
                [startTLabel mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(blackStartt.mas_right).offset(CYScreanW * 0.02);
                     make.width.mas_equalTo(CYScreanW * 0.15);
                     make.top.equalTo(cell.mas_top).offset(CYScreanH * 0.09);
                     make.height.mas_equalTo(CYScreanH * 0.04);
                 }];
            }
            return cell;
        }
        else
        {
            static NSString *ID = @"merComCellId";
            self.commentCell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (self.commentCell == nil)
            {
                self.commentCell = [[MerchantsCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            self.commentCell.selectionStyle = UITableViewCellSelectionStyleGray;
            self.commentCell.model = self.commentArray[indexPath.row - 1];
            return  self.commentCell;
        }
    }
    else
    {
        static NSString *ID = @"merchantsCellIdTwo";
        self.GoodsCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.GoodsCell == nil)
        {
            self.GoodsCell = [[GoodsTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.GoodsCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.GoodsCell.model = self.GoodsTypeArray[indexPath.row];
        self.GoodsCell.backgroundColor = [UIColor colorWithRed:0.863 green:0.863 blue:0.863 alpha:1.00];
        UIColor *color =  [UIColor whiteColor];
        //通过RGB来定义自己的颜色
        self.GoodsCell.selectedBackgroundView = [[UIView alloc] initWithFrame:self.GoodsCell.frame];
        self.GoodsCell.selectedBackgroundView.backgroundColor = color;
        return  self.GoodsCell;
    }
}

//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.GoodsTypeTableView)//商品分类
    {
        // 计算出 右侧 tableView 将要 滚动的 位置
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:NSNotFound inSection:indexPath.row];
        NSLog(@"moveToIndexPath = %ld,%ld,%@",moveToIndexPath.row,moveToIndexPath.section,self.GoodsPlistModelArray[indexPath.row]);
        // 将 rightTableView 移动到对应的 位置
        [self.GoodsPlistTableView scrollToRowAtIndexPath:moveToIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else if (self.shopListTableView)
    {
        
    }
    if (tableView == self.GoodsPlistTableView)//商品列表
    {
        NSArray *array = [NSArray arrayWithArray:self.GoodsPlistModelArray[indexPath.section]];
        MerchantsModel *model = array[indexPath.row];
        NSLog(@"model.goodsId = %@",model.goodsId);
        GoodsDetailsViewController *GDCotnrooler = [[GoodsDetailsViewController alloc] init];
        GDCotnrooler.GoodsIdString = [NSString stringWithFormat:@"%@",model.goodsId];
        GDCotnrooler.model = model;
        GDCotnrooler.MerchantsId = self.MerchantsId;
        [self.navigationController pushViewController:GDCotnrooler animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// - - - -- - - - - -- - - - - -- - - -- - - - -- - - - -- - - -- -- - - - - -- 数据请求 - - - -- - - -- - - - -- - - - -- - - -- - - -- - - - -- - - - --- -
//获取商家详情
- (void) getMerchantsRequest
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/shopDetail",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",self.MerchantsId] forKey:@"id"];
    NSLog(@"parames = %@",parames);
    [self requestMerWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取商家详情请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSDictionary *dict = [JSON objectForKey:@"returnValue"];
            if ([[dict objectForKey:@"available"] integerValue] == 0)//休息中
            {
                [MBProgressHUD showError:@"商家休息中,暂不接单" ToView:self.navigationController.view];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
                [self initHeadController:dict withJson:[CYSmallTools JsonModel:[JSON objectForKey:@"returnValue"]]];//设置详情
        }
        else
        {
            [MBProgressHUD showError:@"商家信息获取失败" ToView:self.view];
            [self initNavigation];
        }
    }];
}
//初始化头部控件
- (void) initHeadController:(NSDictionary *)dict withJson:(NSString *)jsonString
{
    self.MerchantsDetailsDict = [NSDictionary dictionaryWithDictionary:dict];
    NSString *minAmount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"minAmount"]];
    [self.confirmButton setTitle:[NSString stringWithFormat:@"%@元起送",[minAmount isEqualToString:@"<null>"] ? @"0" : minAmount] forState:UIControlStateNormal];//起送价格
    [self.confirmButton setBackgroundColor:[UIColor grayColor]];
    self.confirmButton.userInteractionEnabled = NO;

    NSString *busFee = [NSString stringWithFormat:@"配送费%@元",[dict objectForKey:@"busFee"]];
    self.sendMoneyLabel.text = [busFee isEqualToString:@"<null>"] ? @"0" : busFee;//配送费
    //商家详情数据
    [self.headView initMHVUI:dict withJsonStr:jsonString];
}
//获取商家产品信息
- (void) getMerchantsGoodsRequest
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/shopProductList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[NSString stringWithFormat:@"%@",self.MerchantsId] forKey:@"id"];
    NSLog(@"parames = %@",parames);
    [self requestMerWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取商家产品信息请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [self initMerchantsModel:[NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]]];
            //
            self.navigationMView.backgroundColor = [UIColor clearColor];
            self.backView.userInteractionEnabled = YES;
        }
        else
        {
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.navigationController.view];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
}

//产品数据
- (void) initMerchantsModel:(NSArray *)array
{
    if (!array.count)
    {
        [MBProgressHUD showError:@"商家未发布商品" ToView:self.navigationController.view];
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSArray *arrayT = [MercahntsPageDataDealW initMerchantsModel:array];
    //初始化数据
    self.GoodsTypeArray = [NSMutableArray arrayWithArray:arrayT[0]];
    self.GoodsPlistModelArray = [NSMutableArray arrayWithArray:arrayT[1]];
    //刷新
    [self.GoodsPlistTableView reloadData];
    [self.GoodsTypeTableView reloadData];
    //默认选中第一行
    [self.GoodsTypeTableView selectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

//获取商家评论列表
- (void) getMerchantsCommentRequest
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/shopEvaluateList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:self.MerchantsId forKey:@"shopId"];
    NSLog(@"parames = %@",parames);
    
    [self requestMerWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取商家评论列表请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            [self initCommentModel:[NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]]];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}

//评论数据
- (void) initCommentModel:(NSArray *)array
{
    NSArray *commentArrayAll = [MercahntsPageDataDealW initCommentModel:array];
    if (commentArrayAll.count) {
        self.commentArray = [NSMutableArray arrayWithArray:commentArrayAll[0]];
        self.commentHighArray = [NSMutableArray arrayWithArray:commentArrayAll[1]];
    }
    [self.GoodsCommentTableView reloadData];
}
- (void)requestMerWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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

// - - - -- - - - - -- - - - - -- - - -- - - - -- - - - -- - - -- -- - - - - -- - - -代理 - - - -- - - -- - - - -- - - - -- - - -- - - -- - - - -- - - - --- -
//购物车列表
#pragma mark - DetailListCellDelegate
- (void)valueChangedCallbackButtonClicked:(ShopListTableViewCell *)cell
{
    [self calculateSelectGoodsMoney];
    //每次都要赋值
    self.goodsSing.RemoveArray = [NSMutableArray arrayWithArray:self.goodsSing.SelectIdGArray];
//    NSLog(@"self.goodsSing.RemoveArray = %@,self.goodsSing.SelectIdGArray = %@",self.goodsSing.RemoveArray,self.goodsSing.SelectIdGArray);
    [self.GoodsPlistTableView reloadData];
}
- (void)uploadLoadButtonClicked:(ShopListTableViewCell *)cell
{
    [self setPlistModel];
    [self.shopListTableView reloadData];
}
//商品列表：商品数据改变
- (void) MerchantsTableViewCellButton:(MerchantsTableViewCell *)cell
{
    [self calculateSelectGoodsMoney];
}
//购物车列表
- (void) setPlistModel
{
    self.shopListArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.goodsSing.SelectMerchantsGArray)
    {
        MerchantsModel *model = [dict objectForKey:@"goods"];
        [self.shopListArray addObject:model];
    }
    NSLog(@"self.shopListArray = %@,self.goodsSing.SelectMerchantsGArray = %@",self.shopListArray,self.goodsSing.SelectMerchantsGArray);
    
    [self.shopListTableView reloadData];
}
//计算选择商品价格
- (void) calculateSelectGoodsMoney
{
    float goodsMoney = 0.0;//价格
    NSInteger selectNumber = 0;//数量
    //将本地数量清空
    for (NSInteger i = 0; i < self.GoodsTypeArray.count; i ++)
    {
        GoodsTypeModel *modelG = self.GoodsTypeArray[i];
        modelG.selectGoodsNumber = @"0";
        [self.GoodsTypeArray replaceObjectAtIndex:i withObject:modelG];
    }
    //遍历所有商品
    for (NSInteger i = 0; i < self.goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *parames = [NSDictionary dictionaryWithDictionary:self.goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [parames objectForKey:@"goods"];
        NSString *price = [NSString stringWithFormat:@"%@",model.moneyString];//单价
        NSString *number = [NSString stringWithFormat:@"%@",[parames objectForKey:@"number"]];//销售量
        selectNumber += [number integerValue];
        goodsMoney += [price floatValue] * [number floatValue];
        
        
//        //种类列显示选择的商品
        GoodsTypeModel *modelG = self.GoodsTypeArray[[model.currentSection integerValue]];
        NSLog(@"modelG.selectGoodsNumber = %@",modelG.selectGoodsNumber);
        modelG.selectGoodsNumber = [NSString stringWithFormat:@"%d",[modelG.selectGoodsNumber integerValue] + [number integerValue]];
        NSLog(@"gjhghjgjgjh  modelG.selectGoodsNumber = %@",modelG.selectGoodsNumber);
        
        
        [self.GoodsTypeArray replaceObjectAtIndex:[model.currentSection integerValue] withObject:modelG];
    }
    [self.GoodsTypeTableView reloadData];
    //商品总价
    self.SGoodsMoney = [NSString stringWithFormat:@"%.2f",goodsMoney];
    //控制价格显示和图标颜色
    if (goodsMoney > 0.0)
    {
        self.selectNumberLabel.text = [NSString stringWithFormat:@"%ld",selectNumber];
        self.selectImage.hidden = NO;
        self.selectPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",goodsMoney];
        self.shopCartImage.image = [UIImage imageNamed:@"icon_shopping_trolley_selected"];
    }
    else
    {
        self.selectImage.hidden = YES;
        self.selectPriceLabel.text = @"";
        self.selectNumberLabel.text = @"";
        self.shopCartImage.image = [UIImage imageNamed:@"icon_shopping_trolley_def"];//
    }
    //控制结算显示
    if (goodsMoney >= [[self.MerchantsDetailsDict objectForKey:@"minAmount"] floatValue])
    {
        [self.confirmButton setTitle:@"去结算" forState:UIControlStateNormal];
        self.confirmButton.userInteractionEnabled = YES;
        self.confirmButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    }
    else
    {
        [self.confirmButton setTitle:[NSString stringWithFormat:@"%@起送",[self.MerchantsDetailsDict objectForKey:@"minAmount"]] forState:UIControlStateNormal];//起送价格
        self.confirmButton.userInteractionEnabled = NO;
        self.confirmButton.backgroundColor = [UIColor grayColor];
    }
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];// NSMutableDictionary转NSData
    // NSData转NSString
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//结算按钮
- (void) settlementButton
{
    //显示进度条
    [MBProgressHUD showLoadToView:self.view];
    //获取商品数据
    NSString *string;
    for (NSInteger i = 0; i < self.goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *parames = [NSDictionary dictionaryWithDictionary:self.goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [parames objectForKey:@"goods"];
        NSString *str = [NSString stringWithFormat:@"{\"productId\":%@,\"productnum\":%@}",model.goodsId,[parames objectForKey:@"number"]];
        NSLog(@"str = %@",str);
        string = string.length > 0 ? [NSString stringWithFormat:@"%@,%@",string,str] : [NSString stringWithFormat:@"%@",str];
    }
    //URL
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/seller/createOrder",POSTREQUESTURL];
    NSString *busFee = [NSString stringWithFormat:@"%@",[self.MerchantsDetailsDict objectForKey:@"busFee"]];
    //数据
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    parames[@"shopId"]  = [NSString stringWithFormat:@"%@",self.MerchantsId];
    parames[@"busFee"]  = [busFee isEqualToString:@"<null>"] ? @"0" : busFee;
    parames[@"details"] = [NSString stringWithFormat:@"[%@]",string];
    NSLog(@"parames = %@",parames);
    [self requestMerWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        //隐藏进度条
        [MBProgressHUD hideHUDForView:self.view];
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"生成订单请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            [self.navigationItem setBackBarButtonItem:backItem];
            SubmitMOrderViewController *SMOController = [[SubmitMOrderViewController alloc] init];
            SMOController.OrderDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
            SMOController.MerchantsDict = [NSDictionary dictionaryWithDictionary:self.MerchantsDetailsDict];
            SMOController.SelectGoodsMoney = [NSString stringWithFormat:@"%@",[SMOController.OrderDict objectForKey:@"nowMoney"]];
            [self.navigationController pushViewController:SMOController animated:YES];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//购物车动画
#pragma mark - animated
//加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect{
    
    //紫色小方块结束点
    _endPoint_x = 35;
    _endPoint_y = self.view.frame.size.height - 35;
    //紫色小方块开始点
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    //绘制贝塞尔曲线
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线--既让紫色小方块的下滑线路
    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y) controlPoint1:CGPointMake(startX, startY) controlPoint2:CGPointMake(startX - 180, startY - 200)];
    //下滑时的紫色小方块
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor purpleColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 20, 20);
    _dotLayer.cornerRadius = 5;
    
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
}

#pragma mark - 组合动画
-(void)groupAnimation{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        // 这里是下方的自定义View上面 放的btn.
        [self.shopCartImage.layer addAnimation:shakeAnimation forKey:nil];
        
    }
}
//移除layer动画
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}


@end
