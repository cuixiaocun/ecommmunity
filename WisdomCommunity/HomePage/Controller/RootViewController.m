//
//  RootViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RootViewController.h"
@interface RootViewController ()<RootMiddleViewDelegate>
{

}
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setRootCStyle];
    [self initRootControls];
    //获取首页数据
    [self getRootBBSRequest];
    [self getRootActivity];
   
}

//进度条
- (void) loadViewT
{
    CYFromProgressView  *_progressLoginView = [[CYFromProgressView alloc] init];
    [_progressLoginView showMBprogrossHUD:@"登录成功,即将跳转到主页面!"];
    [self.view addSubview:_progressLoginView];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];

    //查看是否已签到
    [self ownerSignInRequest:@"checkTodaySign"];

    //切换数据
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    [self.communityButton setTitle:[NSString stringWithFormat:@"%@ %@",[getDict objectForKey:@"city"],[getDict objectForKey:@"comName"]] forState:UIControlStateNormal];
    //
//    //签到
//    if ([[CYSmallTools getDataStringKey:WHETHERSIGNIN] integerValue] == 1)//未签到
//    {
//        self.signInBtn.selected = NO;
//    }
//    else
//    {
//        self.whetherSignIn = YES;//说明已签到
//        if (self.signInBtn.selected == NO)
//        {
//            self.signInBtn.selected = YES;
//        }
//    }
    //查看帖子更改
    if (self.ClickRootCellData.count == 2)
    {
        //刷新位置和帖子数据
        [self getClickRootCellNewData:self.ClickRootCellData[0] withDict:self.ClickRootCellData[1]];
    }
}

//首页样式
- (void) setRootCStyle
{
    
//    self.navigationItem.titleView = _bar;
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    self.communityButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.2, 20, CYScreanW * 0.6, 44)];
    [self.communityButton setImage:[UIImage imageNamed:@"icon_location_white"] forState:UIControlStateNormal];
    [self.communityButton setTitle:[NSString stringWithFormat:@"%@ %@",[getDict objectForKey:@"city"],[getDict objectForKey:@"comName"]] forState:UIControlStateNormal];
    [self.communityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.communityButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.communityButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    self.communityButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.communityButton addTarget:self action:@selector(SelectCommunity:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.communityButton;
    //右
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 30)];
    [messageBtn addTarget:self action:@selector(MessageList:) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setImage:[UIImage imageNamed:@"icon_msg"] forState:UIControlStateNormal];
    
    self.signInBtn = [[CYEmitterButton alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    [self.signInBtn addTarget:self action:@selector(SignIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.signInBtn setImage:[UIImage imageNamed:@"icon_qiandao_wei"] forState:UIControlStateNormal];
    [self.signInBtn setImage:[UIImage imageNamed:@"icon_qiandao"] forState:UIControlStateSelected];
    self.signInBtn.selected = NO;
    UIBarButtonItem *buttonRight1 = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    UIBarButtonItem *buttonRight2 = [[UIBarButtonItem alloc] initWithCustomView:self.signInBtn];
    self.navigationItem.leftBarButtonItems=@[buttonRight2];
    self.navigationItem.rightBarButtonItems = @[buttonRight1];
    
    //取数组，未存则存
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    if (!array.count)
    {
        NSArray *array2 = [NSArray arrayWithObjects:[UIImage imageNamed:@"an_001"],[UIImage imageNamed:@"an_002"],[UIImage imageNamed:@"an_003"],[UIImage imageNamed:@"an_004"],[UIImage imageNamed:@"an_005"],[UIImage imageNamed:@"an_006"],[UIImage imageNamed:@"an_007"],nil];
        [CYSmallTools saveArrData:array2 withKey:LOADANIMATION];
    }
    //数据源
    self.dataAllBBSArray = [[NSMutableArray alloc] init];
    self.dataModelBBSArray = [[NSMutableArray alloc] init];
    self.dataAllHeght = [[NSMutableArray alloc] init];
}
//选择小区
- (void) SelectCommunity:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyCommunityListViewController *MCLontroller = [[MyCommunityListViewController alloc] init];
    [self.navigationController pushViewController:MCLontroller animated:YES];
}
//消息列表
- (void) MessageList:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MessagePlistViewController *messageController = [[MessagePlistViewController alloc] init];
    [self.navigationController pushViewController:messageController animated:YES];
}
//签到
- (void) SignIn:(UIButton *)sender
{
    if (sender.selected == NO)
    {
//        self.signInBtn.userInteractionEnabled = NO;
        [self ownerSignInRequest:@"doSign"];
    }else
    {
    
        [MBProgressHUD showError:@"您今天已经签到过了。" ToView:self.view];
    
    }
}
//初始化首页控件
- (void) initRootControls
{
    //背景
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( 0,0, CYScreanW, CYScreanW*120/750)];
    image.image = [UIImage imageNamed:@"pic_pull_down"];
    [self.view addSubview:image];
    //显示
    self.RootSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW,CXCScreanH- 113)];
    self.RootSTableView.delegate = self;
    self.RootSTableView.dataSource = self;
    self.RootSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.RootSTableView.showsVerticalScrollIndicator = NO;
    self.RootSTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.RootSTableView];
    //self.RootSTableView.backgroundColor =BGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==4||section==0) {
        return 0;

    }else if(section==3)
    {
        return 1;
    }
    return 10;
}
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CXCWidth*310;
    }
    else if (indexPath.section == 1)
    {
        return CXCWidth*230;
    }
    else if (indexPath.section == 2)
    {
        return CXCWidth*230;
    }
    else if (indexPath.section == 3)
    {
        return (CYScreanH - 64) * 0.33;
    }
    else
        return [self.dataAllHeght[indexPath.row] floatValue];
        //        return (CYScreanH - 64) * 0.34;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4)
    {
        return self.dataModelBBSArray.count;
    }
    else
        return 1;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4)
    {
        static NSString *ID = @"RootTableViewCellId";
        self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (self.cell == nil)
        {
            self.cell = [[RootBBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        NSLog(@"self.dataModelBBSArray[indexPath.row] = %@",self.dataModelBBSArray[indexPath.row]);
        self.cell.model = self.dataModelBBSArray[indexPath.row];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.cell;
    }
    else if (indexPath.section == 3)
    {
        static NSString *ID = @"cellSectionThreeId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.showActivityImmage == nil && self.activityModel)
        {
            //提示
            UIImageView *Immage = [[UIImageView alloc] init];
            Immage.image = [UIImage imageNamed:@"icon_community_pre"];
            [cell.contentView addSubview:Immage];
            [Immage mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.02);
                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.015);
                 make.width.mas_equalTo(CYScreanW * 0.05);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             }];
            UILabel *timeLabel = [[UILabel alloc] init];
            timeLabel.text = @"社区大小事";
            timeLabel.font = [UIFont fontWithName:@"Arial" size:15];
            timeLabel.textAlignment = NSTextAlignmentLeft;
            timeLabel.textColor = [UIColor colorWithRed:0.298 green:0.569 blue:0.929 alpha:1.00];
            [cell.contentView addSubview:timeLabel];
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(Immage.mas_right).offset(2);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                 make.width.mas_equalTo(CYScreanW * 0.3);
             }];
            
            //
            NSString *signUpNumber = [NSString stringWithFormat:@"%@",self.activityModel.playCount];
            NSString *title = [NSString stringWithFormat:@"%@",self.activityModel.title];
            NSString *content = [NSString stringWithFormat:@"%@",self.activityModel.content];
            //底层图片s
            self.showActivityImmage = [[UIImageView alloc] init];
            [self.showActivityImmage sd_setImageWithURL:[NSURL URLWithString:BackGroundImage]];
            [cell.contentView addSubview:self.showActivityImmage];
            [self.showActivityImmage mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.02);
                 make.right.equalTo(cell.mas_right).offset(- CYScreanW * 0.02);
                 make.top.equalTo(timeLabel.mas_bottom).offset(0);
                 make.bottom.equalTo(cell.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
             }];
            //蒙版
            UIView *showView = [[UIView alloc] init];
            showView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [cell.contentView addSubview:showView];
            [showView mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.and.right.and.top.and.bottom.equalTo(self.showActivityImmage);
             }];
            //活动标题
            UILabel *activeLabel = [[UILabel alloc] init];
            activeLabel.text = [NSString stringWithFormat:@"#%@#",([[NSString stringWithFormat:@"%@",title ]isEqualToString:@"<null>"] ? @"": title) ];
            activeLabel.font = [UIFont fontWithName:@"Arial" size:20];
            activeLabel.textAlignment = NSTextAlignmentCenter;
            activeLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:activeLabel];
            [activeLabel mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.06);
                 make.top.equalTo(timeLabel.mas_bottom).offset((CYScreanH - 64) * 0.01);
             }];
            //分割线
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:segmentationImmage];
            [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.4);
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.4);
                 make.height.mas_equalTo(1);
                 make.top.equalTo(activeLabel.mas_bottom).offset(0);
             }];
            //活动内容
            UILabel *activeLabelT = [[UILabel alloc] init];
            if ([self.activityModel.flag integerValue] == 1) {
                activeLabelT.text = [NSString stringWithFormat:@"%@",([[NSString stringWithFormat:@"%@",content ]isEqualToString:@"(null)"]?  @"赶快来参加啊！！！":content) ];
            }
            else
                activeLabelT.text = @"官方活动";
            activeLabelT.font = [UIFont fontWithName:@"Arial" size:15];
            activeLabelT.textAlignment = NSTextAlignmentCenter;
            activeLabelT.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:activeLabelT];
            [activeLabelT mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.05);
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.05);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                 make.top.equalTo(segmentationImmage.mas_bottom).offset(0);
             }];
            //显示报名
            UIButton *numberButton = [[UIButton alloc] init];
            [numberButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
            if ([signUpNumber integerValue] == 0)
            {
                [numberButton setTitle:@"报名参加" forState:UIControlStateNormal];
            }
            else
                [numberButton setTitle:[NSString stringWithFormat:@"已报名人数：%@",signUpNumber] forState:UIControlStateNormal];
            numberButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
            [cell.contentView addSubview:numberButton];
            [numberButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.3);
                 make.right.equalTo(cell.mas_right).offset(- CYScreanW * 0.3);
                 make.height.mas_equalTo((CYScreanH - 64) * 0.05);
                 make.bottom.equalTo(cell.mas_bottom).offset(-(CYScreanH - 64) * 0.05);
             }];
        }
        
        return cell;
    }
    else
    {
        static NSString *ID = @"cellSectionOtjerId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0)
        {
            //    广告展示
            if (self.ShufflingFigureView == nil)
            {
                self.ShufflingFigureView =[[JXBAdPageView alloc] init];
                self.ShufflingFigureView.frame = CGRectMake( 0, 0, CYScreanW, 310*CXCWidth);
                self.ShufflingFigureView.bWebImage = NO;//非网络图片
                self.ShufflingFigureView.iDisplayTime = 4;//停留时间
                self.ShufflingFigureView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:self.ShufflingFigureView];
                NSArray *imageArray = [NSArray arrayWithObjects:@"001.png",@"002.png",@"003.png",@"005.png", nil];
                [self.ShufflingFigureView startAdsWithBlock:imageArray block:^(NSInteger clickIndex)
                 {
                     NSLog(@"第%ld张",clickIndex);
                 }];
            }
        }
        else if (indexPath.section == 1)
        {
            if (self.ctView == nil)
            {
                self.ctView = [[RootMiddleView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, 230*CXCWidth)];
                self.ctView.delegate = self;
                self.ctView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:self.ctView];
            }
        }
        else if (indexPath.section == 2)
        {
            if (self.OilImageView == nil)
            {
                cell.contentView.backgroundColor =BGColor;
                UITapGestureRecognizer *LefttapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushExhibition:)];
                LefttapGesture.userinfo = [NSMutableDictionary dictionaryWithObject:@"left" forKey:@"type"];
                UIImageView *leftImmage = [[UIImageView alloc] init];
                leftImmage.image = [UIImage imageNamed:@"中间图_油画"];
                leftImmage.userInteractionEnabled = YES;
                [cell.contentView addSubview:leftImmage];
                [leftImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.left.equalTo(cell.mas_left).offset(24*CXCWidth);
                     make.top.equalTo(cell.mas_top).offset(0);
                     make.width.mas_equalTo(344*CXCWidth);
                     make.height.mas_equalTo(230*CXCWidth);
                 }];
                UILabel *bgLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 182*CXCWidth, 344*CXCWidth, 48*CXCWidth)];
                [leftImmage addSubview:bgLabel];
                bgLabel.backgroundColor =[UIColor blackColor];
                bgLabel.alpha =0.5;
                UILabel *wzLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 182*CXCWidth, 344*CXCWidth, 48*CXCWidth)];
                wzLabel.textColor =[UIColor whiteColor];
                wzLabel.font =[UIFont systemFontOfSize:14];
                wzLabel.text =@"装潢展览";
                wzLabel.textAlignment = NSTextAlignmentCenter;
                [leftImmage addSubview:wzLabel];
                
                
                
                [leftImmage addGestureRecognizer:LefttapGesture];
                self.OilImageView = leftImmage;
                UITapGestureRecognizer *righttapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushExhibition:)];
                righttapGesture.userinfo = [NSMutableDictionary dictionaryWithObject:@"right" forKey:@"type"];;
                UIImageView *rightImmage = [[UIImageView alloc] init];
                rightImmage.image = [UIImage imageNamed:@"中间图_装饰"];
                rightImmage.userInteractionEnabled = YES;
                [cell.contentView addSubview:rightImmage];
                [rightImmage mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     make.right.equalTo(cell.mas_right).offset(- 24*CXCWidth);
                     make.top.and.width.and.height.equalTo(leftImmage);
                 }];
                [rightImmage addGestureRecognizer:righttapGesture];
                UILabel *bgLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(0, 182*CXCWidth, 344*CXCWidth, 48*CXCWidth)];
                [rightImmage addSubview:bgLabel2];
                bgLabel2.backgroundColor =[UIColor blackColor];
                bgLabel2.alpha =0.5;
                UILabel *wzLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(0, 182*CXCWidth, 344*CXCWidth, 48*CXCWidth)];
                wzLabel2.textColor =[UIColor whiteColor];
                wzLabel2.font =[UIFont systemFontOfSize:14];
                wzLabel2.text =@"装潢展览";
                wzLabel2.textAlignment = NSTextAlignmentCenter;
                [rightImmage addSubview:wzLabel2];

            }
            
            
            
            
        }
        return cell;
    }
    
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        NSLog(@"self.activityModel = %@",self.activityModel);
        if (self.activityModel)
        {
            ActivityDetailsViewController *ADController = [[ActivityDetailsViewController alloc] init];
            ADController.ActivityIDmodel = self.activityModel.activityID;
            [self.navigationController pushViewController:ADController animated:YES];
        }
        else
            [MBProgressHUD showError:@"没有数据" ToView:self.view];
    }
    else if (indexPath.section == 4)
    {
        //记录点击的cell
        self.ClickRootCellData = @[[NSString stringWithFormat:@"%ld",indexPath.row],self.dataAllBBSArray[indexPath.row]];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
        PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.dataAllBBSArray[indexPath.row]];
        [self.navigationController pushViewController:PDController animated:YES];
    }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 按钮代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -

#pragma mark 跳转到油画装潢展览界面
- (void)pushExhibition:(UITapGestureRecognizer *)sender
{
    NSString *type = sender.userinfo[@"type"];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    CZExhibitionViewController *exhibitionViewController = [[CZExhibitionViewController alloc] initWithType:[type isEqualToString:@"left"]?TypeOilPainting:TypeDecoration];
    
    [self.navigationController pushViewController:exhibitionViewController animated:YES];
    
    
}
//点击collection代理方法
//物业管家
- (void) propertyHousekeeper
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyViewController *PController = [[PropertyViewController alloc] init];
    [self.navigationController pushViewController:PController animated:YES];
}
//社区商城
- (void) communityMall
{
    //切换标签页
    UIView *fromView = [self.tabBarController.selectedViewController view];
    UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:1] view];
    [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
        if (finished)
        {
            [self.tabBarController setSelectedIndex:1];
        }
    }];

    
}
//物业报修
- (void) propertyService
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyRepairViewController *PRController = [[PropertyRepairViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
//社区公告
- (void) communityPAnnouncement
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ComAnnouncementViewController *CAController = [[ComAnnouncementViewController alloc] init];
    [self.navigationController pushViewController:CAController animated:YES];
    
}
//投诉建议
- (void) complaintsSuggestions
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ComplaintsSuggestionsViewController *suggesController = [[ComplaintsSuggestionsViewController alloc] init];
    [self.navigationController pushViewController:suggesController animated:YES];
}
//社区大小事
- (void) CommunityActiveBBS
{
//    //显示分享面板
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//        NSLog(@"userInfo = %@",userInfo);
//        // 根据获取的platformType确定所选平台进行下一步操作
//        [self shareTextToPlatformType:platformType];
//    }];
//    
    //切换标签页
    UIView *fromView = [self.tabBarController.selectedViewController view];
    UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:2] view];
    [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
        if (finished)
        {
            [self.tabBarController setSelectedIndex:2];
        }
    }];
}


//业主签到请求
- (void) ownerSignInRequest:(NSString *)state
{
    /*
      1.每次进来都要看本地有没有记录签到过
      2.第一次进来请求检查是否签到 若已经签到则显示已经签到
      3.点击签到按钮
     */
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/%@",POSTREQUESTURL,[state isEqualToString:@"doSign"] ? @"doSign" : @"checkTodaySign"];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestRootWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"是否/签到请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            if ([state isEqualToString:@"doSign"])//如果是点击按钮进来的，则签到
            {
                self.signInBtn.selected = YES;
//                self.signInBtn.userInteractionEnabled = NO;
//                [self ownerSignInRequest:@"checkTodaySign"];
                [ProgressHUD showSuccess:@"签到成功！"];
                NSLog(@"签到");
            }
            else//若果不是点击按钮进来的，则是查看签到记录
            {
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"param"]];
                NSLog(@"是否已签到");
//                [CYSmallTools saveDataString:[dict objectForKey:@"canSign"] withKey:WHETHERSIGNIN];
                [CYSmallTools saveDataString:[dict objectForKey:@"score"] withKey:CURRENTINTEGRAL];
                if ([[dict objectForKey:@"canSign"] integerValue] == 1)//签到
                {
                    self.signInBtn.userInteractionEnabled = YES;
//                    [ProgressHUD showSuccess:@"已签到"];
                }
                else//已经签到
                {
                    self.whetherSignIn = YES;//表示已签到
////                    self.signInBtn.userInteractionEnabled = NO;
                    self.signInBtn.selected = YES;
////                    [ProgressHUD showError:@"您今天已经签到过。"];
                }
            }
        }
        else
        {
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.navigationController.view];
            CYLoginViewController *GoLoController = [[CYLoginViewController alloc] init];
            [self.navigationController pushViewController:GoLoController animated:YES];
            //是否需要重新登录
//            if ([CYSmallTools whetherLoginFails:[JSON objectForKey:@"error"] withResult:[JSON objectForKey:@"success"]])
//            {
//                
//            }
        }
    }];
}
//初始化数据
- (void) initDataModel:(NSArray *)array
{
    NSArray *arrayModel = [NNSRootModelData initBBSRootModel:array];
    [self.dataAllBBSArray addObjectsFromArray:arrayModel[0]];
    [self.dataAllHeght addObjectsFromArray:arrayModel[1]];
    [self.dataModelBBSArray addObjectsFromArray:arrayModel[2]];
    //刷新
    [self.RootSTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationFade];
}

//获取首页帖子数据
- (void) getRootBBSRequest
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求 设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"category"]     =  @"1";//
    parames[@"pageSize"]     =  @"2";
    parames[@"currentPage"]  =  @"1";
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/noteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestRootWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *array = [JSON objectForKey:@"returnValue"];
            [self initDataModel:array];
        }
    }];
}
//活动
- (void) getRootActivity
{
//    [MBProgressHUD showLoadToView:self.view];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/activityList",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:[CYSmallTools getDataStringKey:ACCOUNT] forKey:@"account"];
    [parames setObject:[CYSmallTools getDataStringKey:TOKEN] forKey:@"token"];
    [parames setObject:@"1" forKey:@"currentPage"];
    [parames setObject:@"1"forKey:@"pageSize"];
    NSLog(@"parames = %@",parames);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [self requestRootWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"活动请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            if ([JSON objectForKey:@"returnValue"] != [NSNull null])
            {
                NSArray *array = [NSArray arrayWithArray:[JSON objectForKey:@"returnValue"]];
                if (array.count)//是否有数据
                {
                    self.activityModel = [ActivityRootModel bodyWithDict:[NSDictionary dictionaryWithDictionary:array[0]]];
                }
                [self.RootSTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
}
//获取点击cell的下标
- (void) getClickRootCellNewData:(NSString *)ClickRow withDict:(NSDictionary *)dict
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"noteId"]  =  [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/viewNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [self requestRootWithUrl:requestUrl parames:parames Success:^(id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"点击帖子请求成功JSON = %@",JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            NSArray *array = @[[JSON objectForKey:@"returnValue"]];
            array = [NSArray arrayWithArray:[NNSRootModelData initBBSRootModel:array]];
            NSLog(@"array = %@,self.BBSRootAllarray.count = %ld",array,self.dataAllBBSArray.count);
            
            [self.dataAllBBSArray   replaceObjectAtIndex:[ClickRow integerValue] withObject:[JSON objectForKey:@"returnValue"]];
            
            NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
            [self.dataAllHeght    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
            
            BBSArray = [NSArray arrayWithArray:array[2]];
            [self.dataModelBBSArray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:0];
            //刷新
            [self.RootSTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    }];
    //初始化
    self.ClickRootCellData = [[NSArray alloc] init];
}
//数据请求
- (void)requestRootWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
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

@end
