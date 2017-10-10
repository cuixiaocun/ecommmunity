//
//  CommunityABBSViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CommunityABBSViewController.h"

@interface CommunityABBSViewController ()

@end

@implementation CommunityABBSViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setBBSStyle];
    [self initBBSController];
    
    [self getCBListRequest];
}

//初始化数据
- (void) initDataBBSModel:(NSArray *)array
{
    NSArray *arrayModel = [NNSRootModelData initBBSRootModel:array];

    if ([self.BBSRootLabelString isEqual:@"left"])
    {
        if (self.recordRequesPage==1) {
            [self.comAllBBSarray removeAllObjects];
            [self.comTBHeightarray removeAllObjects];
            [self.comModelBBSarray removeAllObjects];

        }
        [self.comAllBBSarray addObjectsFromArray:arrayModel[0]];
        [self.comTBHeightarray addObjectsFromArray:arrayModel[1]];
        [self.comModelBBSarray addObjectsFromArray:arrayModel[2]];
        //刷新
        [self.comBBSTableView reloadData];
       
     //   [self.comBBSTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if ([self.BBSRootLabelString isEqual:@"middle"])
    {
        if (self.recordSRequesPage==1) {
            [self.comAllSBBSarray removeAllObjects];
            [self.comSTBHeightarray removeAllObjects];
            [self.comSModelBBSarray removeAllObjects];
            
        }

        [self.comAllSBBSarray addObjectsFromArray:arrayModel[0]];
        [self.comSTBHeightarray addObjectsFromArray:arrayModel[1]];
        [self.comSModelBBSarray addObjectsFromArray:arrayModel[2]];
        //刷新
        [self.comBBSTableView reloadData];
       
       // [self.comBBSTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if ([self.BBSRootLabelString isEqual:@"right"])
    {
        if (self.recordBRequesPage==1) {
            [self.comAllBBBSarray removeAllObjects];
            [self.comBTBHeightarray removeAllObjects];
            [self.comBModelBBSarray removeAllObjects];
            
        }

        [self.comAllBBBSarray addObjectsFromArray:arrayModel[0]];
        [self.comBTBHeightarray addObjectsFromArray:arrayModel[1]];
        [self.comBModelBBSarray addObjectsFromArray:arrayModel[2]];
        //刷新
        [self.comBBSTableView reloadData];
              //[self.comBBSTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)appendTableWithObject:(NSMutableArray *)data
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0;i < [data count];i ++)
    {
        [dataArray addObject:[data objectAtIndex:i]];
    }
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    for (int ind = 0; ind < [data count]; ind++)
    {
        NSIndexPath *newPath =  [NSIndexPath indexPathForRow:[dataArray indexOfObject:[data objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    [self.comBBSTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
}
//设置样式
- (void) setBBSStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"社区大小事";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //数据源
    self.comModelBBSarray = [[NSMutableArray alloc] init];
    self.comTBHeightarray = [[NSMutableArray alloc] init];
    self.comSModelBBSarray = [[NSMutableArray alloc] init];
    self.comSTBHeightarray = [[NSMutableArray alloc] init];
    self.comBModelBBSarray = [[NSMutableArray alloc] init];
    self.comBTBHeightarray = [[NSMutableArray alloc] init];
    self.comAllBBSarray = [[NSMutableArray alloc] init];
    self.comAllBBBSarray = [[NSMutableArray alloc] init];
    self.comAllSBBSarray = [[NSMutableArray alloc] init];
    self.BBSRootLabelString = @"left";
    self.recordRequesPage = 1;//初始为1
    self.recordSRequesPage = 1;
    self.recordBRequesPage = 1;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
    if (self.ClickPRootCellData.count == 2)
    {
        //刷新位置和帖子数据
        [self getClickRootCellNewData:self.ClickPRootCellData[0] withDict:self.ClickPRootCellData[1]];
    }
    //每次都请求查看最多的帖子数据
    [self RequestSeeNumber];
}
//结束刷新
- (void) endCBBSHeadRefresh
{
    //结束下拉刷新
    [self.comBBSTableView.mj_header endRefreshing];
}
- (void) endCBBSFooterRefresh
{
    if ([self.BBSRootLabelString isEqual:@"left"])
    {
        if (self.comModelBBSarray.count)
        {
            self.recordRequesPage += 1;
        }
    }
    else if ([self.BBSRootLabelString isEqual:@"middle"])
    {
        if (self.comSModelBBSarray.count)
        {
            self.recordSRequesPage += 1;
        }
    }
    else
    {
        if (self.comBModelBBSarray.count)
        {
            self.recordBRequesPage += 1;
        }
    }
    
    [self getCBListRequest];
}
//初始化控件
- (void) initBBSController
{
    //显示
    self.comBBSTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCScreanH -64-49)];
    self.comBBSTableView.delegate = self;
    self.comBBSTableView.dataSource = self;
    self.comBBSTableView.showsVerticalScrollIndicator = NO;
    self.comBBSTableView.backgroundColor = [UIColor whiteColor];
    self.comBBSTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.comBBSTableView];
    
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    
    //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(endCBBSHeadRefresh)];
    //设置正在刷新状态的动画图片
    [header setImages:array forState:MJRefreshStateRefreshing];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    self.comBBSTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(endCBBSFooterRefresh)];
    // 设置正在刷新状态的动画图片
    [footer setImages:array forState:MJRefreshStateRefreshing];
    footer.stateLabel.hidden = YES;
    // 设置尾部
    self.comBBSTableView.mj_footer = footer;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //顶部导航栏
    self.selectLabelAtTop = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCWidth*80)];
    self.selectLabelAtTop.backgroundColor = [UIColor whiteColor];
    self.selectLabelAtTop.hidden = YES;
    [self.view addSubview:self.selectLabelAtTop];
    
    //竖线 vertical
    UIImageView *verticalImmage = [[UIImageView alloc] init];
    verticalImmage.backgroundColor = BGColor;
    [self.selectLabelAtTop addSubview:verticalImmage];
    [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.selectLabelAtTop.mas_left).offset(CYScreanW / 3);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.selectLabelAtTop.mas_top).offset(20*CXCWidth);
         make.bottom.equalTo(self.selectLabelAtTop.mas_bottom).offset(-20*CXCWidth);
     }];
    UIImageView *verticalImmage2 = [[UIImageView alloc] init];
    verticalImmage2.backgroundColor = BGColor;
    [self.selectLabelAtTop addSubview:verticalImmage2];
    [verticalImmage2 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.selectLabelAtTop.mas_left).offset(CYScreanW / 3 * 2);
         make.width.mas_equalTo(1);
         make.top.equalTo(self.selectLabelAtTop.mas_top).offset(20*CXCWidth);
         make.bottom.equalTo(self.selectLabelAtTop.mas_bottom).offset(-20*CXCWidth);
     }];
    UIImageView *verticalImmage3 = [[UIImageView alloc] init];
    verticalImmage3.backgroundColor = BGColor;
    [self.selectLabelAtTop addSubview:verticalImmage3];
    [verticalImmage3 mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.selectLabelAtTop.mas_left).offset(0);
         make.width.mas_equalTo(CYScreanW);
         make.top.equalTo(self.selectLabelAtTop.mas_bottom).offset(-1);
         make.height.mas_equalTo(1);
         make.bottom.equalTo(self.selectLabelAtTop.mas_bottom).offset(0);

     }];
    
    self.leftTopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CYScreanW / 3, (CYScreanH - 64) * 0.06)];
    self.leftTopButton.backgroundColor = [UIColor clearColor];
    [self.leftTopButton setTitle:@"最新" forState:UIControlStateNormal];
    [self.leftTopButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.leftTopButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
    [self.leftTopButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
    _leftTopButton.selected =YES;
    self.leftTopButton.titleLabel.font =[UIFont systemFontOfSize:15];
    
    [self.selectLabelAtTop addSubview:self.leftTopButton];
    
    self.middleTopButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3, 0, CYScreanW / 3, (CYScreanH - 64) * 0.06)];
    self.middleTopButton.backgroundColor = [UIColor clearColor];
    [self.middleTopButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.middleTopButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
    [self.middleTopButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.middleTopButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectLabelAtTop addSubview:self.middleTopButton];
    _middleTopButton.titleLabel.font =[UIFont systemFontOfSize:15];

    
    self.rightTopButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3 * 2, 0, CYScreanW / 3, (CYScreanH - 64) * 0.06)];
    self.rightTopButton.backgroundColor = [UIColor clearColor];
    [self.rightTopButton setTitle:@"集市" forState:UIControlStateNormal];
    [self.rightTopButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
    [self.rightTopButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
    [self.rightTopButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectLabelAtTop addSubview:self.rightTopButton];
    _rightTopButton.titleLabel.font =[UIFont systemFontOfSize:15];

}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - tableview代理 - - -- - - - - - - - - - - - - - - - - - - - -- - - - - -  -   -
//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 300*CXCWidth;
    }
    else if (indexPath.section == 1)
    {
        return 70*CXCWidth;
    }
    else if(indexPath.section == 2)
    {
        return 80*CXCWidth;
    }
    else
    {
        if ([self.BBSRootLabelString isEqual:@"left"])
        {
            return [self.comTBHeightarray[indexPath.row] floatValue];
//            NSLog(@"sdsfdgfsaf%f",[self.comTBHeightarray[indexPath.row] floatValue]);
        }
        else if ([self.BBSRootLabelString isEqual:@"middle"])
        {
            return [self.comSTBHeightarray[indexPath.row] floatValue];
        }
        else
        {
            return [self.comBTBHeightarray[indexPath.row] floatValue];
        }
    }
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3)
    {
        if ([self.BBSRootLabelString isEqual:@"left"])
        {
            return self.comModelBBSarray.count;
        }
        else if ([self.BBSRootLabelString isEqual:@"middle"])
        {
            NSLog(@"self.comSModelBBSarray.count = %ld",self.comSModelBBSarray.count);
            return self.comSModelBBSarray.count;
        }
        else
        {
            NSLog(@"self.comBModelBBSarray.count = %ld",self.comBModelBBSarray.count);
            return self.comBModelBBSarray.count;
        }
    }
    else
    {
        return 1;
    }
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        static NSString *ID = @"bbsCellId";
       comBBSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[comBBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        if ([self.BBSRootLabelString isEqual:@"left"])
        {
            if (indexPath.row <= self.comModelBBSarray.count - 1)
            {
                cell.model = self.comModelBBSarray[indexPath.row];
            }
        }
        else if ([self.BBSRootLabelString isEqual:@"middle"])
        {
            if (indexPath.row <= self.comSModelBBSarray.count - 1)
            {
                NSLog(@"self.comSModelBBSarray[indexPath.row] = %@",self.comSModelBBSarray[indexPath.row]);
                cell.model = self.comSModelBBSarray[indexPath.row];
            }
        }
        else
        {
            if (indexPath.row <= self.comBModelBBSarray.count - 1)
            {
                NSLog(@"indexPath.row = %ld",indexPath.row);
            cell.model = self.comBModelBBSarray[indexPath.row];
            }
        }
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        static NSString *ID = @"cellCBBSId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];//强制装换为UIView类型 ，移除所有子视图
            }
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0)
        {
            
            for (int i=0; i<2; i++) {
                UIImageView *showImmage = [[UIImageView alloc] init];
                               showImmage.userInteractionEnabled = YES;
                [cell.contentView addSubview:showImmage];
                showImmage.frame =CGRectMake(26*CXCWidth+352*i*CXCWidth, 20*CXCWidth, 340*CXCWidth, 240*CXCWidth);
                UILabel *zlabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,340*CXCWidth,240*CXCWidth )];
                [showImmage addSubview:zlabel];
                zlabel.textColor =[UIColor whiteColor];
                zlabel.textAlignment =NSTextAlignmentCenter;
                zlabel.font =[UIFont systemFontOfSize:16];
                UILabel *xlabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 150*CXCWidth,340*CXCWidth,40*CXCWidth )];
                [showImmage addSubview:xlabel];
                xlabel.textAlignment =NSTextAlignmentCenter;

                xlabel.textColor =[UIColor colorWithRed:254/255.0 green:172/255.0 blue:42/255.0 alpha:1];
                xlabel.font =[UIFont systemFontOfSize:12];
                showImmage.userInteractionEnabled = YES;
                
                

                if (i==0) {
                    showImmage.image = [UIImage imageNamed:@"icon_topic-1"];
                    zlabel.text =@"热点话题";
                    xlabel.text =@"左右邻居都在这";
                    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActiveTap:)];
                    leftTap.numberOfTapsRequired = 1;
                     [showImmage addGestureRecognizer:leftTap];


                }else
                {
                    showImmage.image = [UIImage imageNamed:@"icon_huodong"];
                    zlabel.text =@"邻里活动";
                    xlabel.text =@"邻里交友不孤单";
                    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BBSTap:)];
                    rightTap.numberOfTapsRequired = 1;
                    [showImmage addGestureRecognizer:rightTap];



                }

                
                
                
                
                
                
            }
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, 280*CXCWidth,CYScreanW ,20*CXCWidth)];
            [img setBackgroundColor:BGColor];
            [cell.contentView addSubview:img];
            
            
            
            
            
            
            
            
            
            
            
//            
//            UIImageView *showImmage = [[UIImageView alloc] init];
//            showImmage.image = [UIImage imageNamed:@"1left"];
//            showImmage.userInteractionEnabled = YES;
//            [cell.contentView addSubview:showImmage];
//            [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
//             {
//                 make.left.equalTo(cell.mas_left).offset(CYScreanW * 0.02);
//                 make.width.mas_equalTo(CYScreanW * 0.47);
//                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
//                 make.height.mas_equalTo((CYScreanH - 64) * 0.2);
//             }];
//            //添加单击手势防范
   //            leftTap.numberOfTapsRequired = 1;
//            self.showImmage = showImmage;
//            
//            UIImageView *showImmage2 = [[UIImageView alloc] init];
//            showImmage2.image = [UIImage imageNamed:@"2right"];
//            showImmage2.userInteractionEnabled = YES;
//            [cell.contentView addSubview:showImmage2];
//            [showImmage2 mas_makeConstraints:^(MASConstraintMaker *make)
//             {
//                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.02);
//                 make.width.mas_equalTo(CYScreanW * 0.47);
//                 make.top.equalTo(cell.mas_top).offset((CYScreanH - 64) * 0.02);
//                 make.height.mas_equalTo((CYScreanH - 64) * 0.2);
//             }];
//            //添加单击手势防范
        }
        else if (indexPath.section == 1)
        {
            
        
            
            
            
            
            UILabel *btnLeft = [[UILabel alloc] initWithFrame:CGRectMake(70*CXCWidth, 0, 163*CXCWidth, 70*CXCWidth)];
            btnLeft.backgroundColor = [UIColor clearColor];
            btnLeft.text =@"话题";
            btnLeft.font =[UIFont systemFontOfSize:15];
            btnLeft.textColor =[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00];
            [cell.contentView addSubview:btnLeft];
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 10*CXCWidth,32*CXCWidth,50*CXCWidth )];
            [cell.contentView addSubview:img];
            [img setImage:[UIImage imageNamed:@"icon_huati"]];
            

            UILabel *prompt = [[UILabel alloc] init];
            prompt.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.00];
            prompt.font = [UIFont fontWithName:@"Arial" size:12];
            prompt.textAlignment = NSTextAlignmentRight;
            if (self.HotPostContentDict) {
                prompt.text = [NSString stringWithFormat:@"#%@#",[self.HotPostContentDict objectForKey:@"title"]];
            }
            [cell.contentView addSubview:prompt];
            [prompt mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.right.equalTo(cell.mas_right).offset(-CYScreanW * 0.04);
                 make.width.mas_equalTo(CYScreanW * 0.7);
                 make.top.equalTo(cell.mas_top).offset(0);
                 make.bottom.equalTo(cell.mas_bottom).offset(0);
             }];
            self.HotLabelPost = prompt;
        }
        else if (indexPath.section == 2)
        {
            self.selectLabelInTView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CXCWidth*80)];
            self.selectLabelInTView.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:self.selectLabelInTView];
            
            //竖线 vertical
            UIImageView *verticalImmage = [[UIImageView alloc] init];
            verticalImmage.backgroundColor = BGColor;
            [self.selectLabelInTView addSubview:verticalImmage];
            [verticalImmage mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(self.selectLabelInTView.mas_left).offset(CYScreanW / 3);
                 make.width.mas_equalTo(1);
                 make.top.equalTo(self.selectLabelInTView.mas_top).offset(20*CXCWidth);
                 make.bottom.equalTo(self.selectLabelInTView.mas_bottom).offset(-20*CXCWidth);
             }];
            UIImageView *verticalImmage2 = [[UIImageView alloc] init];
            verticalImmage2.backgroundColor = BGColor;
            [self.selectLabelInTView addSubview:verticalImmage2];
            [verticalImmage2 mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.equalTo(self.selectLabelInTView.mas_left).offset(CYScreanW / 3 * 2);
                 make.width.mas_equalTo(1);
                 make.top.equalTo(self.selectLabelInTView.mas_top).offset(20*CXCWidth);
                 make.bottom.equalTo(self.selectLabelInTView.mas_bottom).offset(-20*CXCWidth);
             }];
            
            
            self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CYScreanW / 3,79*CXCWidth )];
            self.leftButton.backgroundColor = [UIColor clearColor];
            [self.leftButton setTitle:@"最新" forState:UIControlStateNormal];
            [self.leftButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
            [self.leftButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
            [self.leftButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.selectLabelInTView addSubview:self.leftButton];
            _leftButton.titleLabel.font =[UIFont systemFontOfSize:15];

            
            self.middleButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3, 0, CYScreanW / 3, 79*CXCWidth)];
            self.middleButton.backgroundColor = [UIColor clearColor];
            [self.middleButton setTitle:@"分享" forState:UIControlStateNormal];
            [self.middleButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
            [self.middleButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
            [self.middleButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.selectLabelInTView addSubview:self.middleButton];
            _middleButton.titleLabel.font =[UIFont systemFontOfSize:15];

            self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3 * 2, 0, CYScreanW / 3, 79*CXCWidth)];
            self.rightButton.backgroundColor = [UIColor clearColor];
            [self.rightButton setTitle:@"集市" forState:UIControlStateNormal];
            [self.rightButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
            [self.rightButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
            [self.rightButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
            _rightButton.titleLabel.font =[UIFont systemFontOfSize:15];

            [self.selectLabelInTView addSubview:self.rightButton];
            if ([self.BBSRootLabelString isEqual:@"left"])
            {
                self.leftButton.selected = YES;
                self.middleButton.selected = NO;
                self.rightButton.selected = NO;
            }
            else if ([self.BBSRootLabelString isEqual:@"middle"])
            {
                self.middleButton.selected = YES;
                self.leftButton.selected = NO;
                self.rightButton.selected = NO;
            }
            else
            {
                self.rightButton.selected = YES;
                self.leftButton.selected = NO;
                self.middleButton.selected = NO;
            }
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
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [cell.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(cell.mas_left).offset(0);
             make.right.equalTo(cell.mas_right).offset(0);
             make.top.equalTo(cell.mas_top).offset(0);
             make.height.mas_equalTo(1);
         }];
        return cell;
    }
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    if (indexPath.section == 1)
    {
        if (self.HotPostContentDict)
        {
            PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
            PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.HotPostContentDict];
            [self.navigationController pushViewController:PDController animated:YES];
        }
    }
    else if (indexPath.section == 3)
    {
        if ([self.BBSRootLabelString isEqual:@"left"])
        {
            //记录点击的cell
            self.ClickPRootCellData = @[[NSString stringWithFormat:@"%ld",indexPath.row],self.comAllBBSarray[indexPath.row]];
            
            PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
            PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.comAllBBSarray[indexPath.row]];
            [self.navigationController pushViewController:PDController animated:YES];
        }
        else if ([self.BBSRootLabelString isEqual:@"middle"])
        {
            //记录点击的cell
            self.ClickPRootCellData = @[[NSString stringWithFormat:@"%ld",indexPath.row],self.comAllSBBSarray[indexPath.row]];
            
            PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
            PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.comAllSBBSarray[indexPath.row]];
            [self.navigationController pushViewController:PDController animated:YES];
        }
        else
        {
            //记录点击的cell
            self.ClickPRootCellData = @[[NSString stringWithFormat:@"%ld",indexPath.row],self.comAllBBBSarray[indexPath.row]];
            
            PostDetailsViewController *PDController = [[PostDetailsViewController alloc] init];
            PDController.BBSDetailsDict = [NSDictionary dictionaryWithDictionary:self.comAllBBBSarray[indexPath.row]];
            [self.navigationController pushViewController:PDController animated:YES];
        }
        
    }
}
//监测tableview滚动事件，滚动的时候触发
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= (CYScreanH - 64) * 0.32)
    {
        _selectLabelAtTop.hidden = NO;
        _selectLabelInTView.hidden = YES;
    }
    else
    {
        _selectLabelAtTop.hidden = YES;
        _selectLabelInTView.hidden = NO;
    }
}

//标签页选择
- (void) labelClickBBSRButton:(UIButton *)sender
{
   
    self.recordRequesPage = 1;
    self.recordSRequesPage = 1;
    self.recordBRequesPage = 1;

    if (sender == self.leftTopButton || sender == self.leftButton)
    {
        self.BBSRootLabelString = @"left";//最新
       
        //设置选中颜色
        self.leftButton.selected = YES;
        self.leftTopButton.selected = YES;
        self.middleButton.selected = NO;
        self.middleTopButton.selected = NO;
        self.rightButton.selected = NO;
        self.rightTopButton.selected = NO;
    }
    else if (sender == self.middleTopButton || sender == self.middleButton)
    {
        self.BBSRootLabelString = @"middle";//分享
        NSLog(@"self.recordBRequesPage = %ld",self.recordSRequesPage);
        
        //设置选中颜色
        self.leftButton.selected = NO;
        self.leftTopButton.selected = NO;
        self.middleButton.selected = YES;
        self.middleTopButton.selected = YES;
        self.rightButton.selected = NO;
        self.rightTopButton.selected = NO;
    }
    else if (sender == self.rightTopButton || sender == self.rightButton)
    {
        self.BBSRootLabelString = @"right";//集市
        NSLog(@"self.recordBRequesPage = %ld",self.recordBRequesPage);
       
        //设置选中颜色
        self.leftButton.selected = NO;
        self.leftTopButton.selected = NO;
        self.middleButton.selected = NO;
        self.middleTopButton.selected = NO;
        self.rightButton.selected = YES;
        self.rightTopButton.selected = YES;
    }
    //表示点击标签进行数据请求
    self.whetherClickLabelRequest = YES;
    //数据请求
    [self getCBListRequest];
    
//    //滚动到显示帖子的第一行
//    [self.comBBSTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//手势
-(void) ActiveTap:(UITapGestureRecognizer *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    BBSRootViewController *BBSRController = [[BBSRootViewController alloc] init];
    [self.navigationController pushViewController:BBSRController animated:YES];

    
}
-(void) BBSTap:(UITapGestureRecognizer *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ActicityRootViewController *ARController = [[ActicityRootViewController alloc] init];
    [self.navigationController pushViewController:ARController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取帖子列表
- (void) getCBListRequest
{
    [ProgressHUD show:@"请稍等"];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    if ([self.BBSRootLabelString isEqual:@"left"])
    {
        parames[@"category"]     =  @"1";//
        parames[@"currentPage"]  =  [NSString stringWithFormat:@"%ld",self.recordRequesPage];
    }
    else if ([self.BBSRootLabelString isEqual:@"middle"])
    {
        parames[@"category"]     =  @"2";//
        parames[@"currentPage"]  =  [NSString stringWithFormat:@"%ld",self.recordSRequesPage];
    }
    else if ([self.BBSRootLabelString isEqual:@"right"])
    {
        parames[@"category"]     =  @"3";//
        parames[@"currentPage"]  =  [NSString stringWithFormat:@"%ld",self.recordBRequesPage];
    }
    parames[@"pageSize"]     =  @"10";
    
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/noteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取帖子列表请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         // 结束上拉刷新
         [self.comBBSTableView.mj_footer endRefreshing];
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = [JSON objectForKey:@"returnValue"];
                         //更新数据
             [self initDataBBSModel:array];//若等于1 arr置零  pagecount=1
             if ([[NSString stringWithFormat:@"%@",[parames objectForKey:@"currentPage"]]isEqualToString:@"1"]) {
                 _selectLabelAtTop.hidden = YES;
                 _selectLabelInTView.hidden = NO;

                 NSUInteger section = 0;
                 NSUInteger row = 0;
                 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
//                 [_comBBSTableView reloadData];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                 [self.comBBSTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                 });
                 
             }
             //如果没请求到数据
             if (array.count <=0||[array isEqual:[NSNull null]])
             {
                 if ( self.whetherClickLabelRequest == NO)
                 {
                     [ProgressHUD dismiss];

                     [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                 }
                 [self ReductionInt];//没有的话就减数
             }else
             {
                 [ProgressHUD showSuccess:@"加载成功"];

             }
           

         }
         else
        {
            //更新数据
            [self initDataBBSModel:nil];
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
            [self ReductionInt];
        }
        self.whetherClickLabelRequest = NO;//每次请求完之后重置
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
         [ProgressHUD showError:@"网络连接失败"];

         // 结束上拉刷新
         [self.comBBSTableView.mj_footer endRefreshing];
         [self ReductionInt];
         self.whetherClickLabelRequest = NO;//每次请求完之后重置
     }];
}
//减计数
- (void) ReductionInt
{
    if ([self.BBSRootLabelString isEqual:@"left"])
    {
        if (self.comModelBBSarray.count)
        {
            self.recordRequesPage -= 1;
        }
    }
    else if ([self.BBSRootLabelString isEqual:@"middle"])
    {
        if (self.comSModelBBSarray.count)
        {
            self.recordSRequesPage -= 1;
        }
    }
    else
    {
        if (self.comBModelBBSarray.count)
        {
            self.recordBRequesPage -= 1;
        }
    }
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
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"点击帖子请求成功JSON = %@",JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSArray *array = @[[JSON objectForKey:@"returnValue"]];
             [self uploadClickCell:[NSArray arrayWithArray:[NNSRootModelData initBBSRootModel:array]] withPostDict:[JSON objectForKey:@"returnValue"] withRow:ClickRow];
         } 
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
     }];
    //初始化
    self.ClickPRootCellData = [[NSArray alloc] init];
}
//刷新点击的cell
- (void) uploadClickCell:(NSArray *)array withPostDict:(NSDictionary *)dict withRow:(NSString *)ClickRow
{
    if ([self.BBSRootLabelString isEqual:@"left"])
    {
        
        [self.comAllBBSarray   replaceObjectAtIndex:[ClickRow integerValue] withObject:dict];
        
        NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
        [self.comTBHeightarray    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
        
        BBSArray = [NSArray arrayWithArray:array[2]];
        [self.comModelBBSarray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
        //刷新
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:3];
        [self.comBBSTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if ([self.BBSRootLabelString isEqual:@"middle"])
    {
        [self.comAllSBBSarray   replaceObjectAtIndex:[ClickRow integerValue] withObject:dict];
        
        NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
        [self.comSTBHeightarray    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
        
        BBSArray = [NSArray arrayWithArray:array[2]];
        [self.comSModelBBSarray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
        //刷新
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:3];
        [self.comBBSTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if ([self.BBSRootLabelString isEqual:@"right"])
    {
        [self.comAllBBBSarray   replaceObjectAtIndex:[ClickRow integerValue] withObject:dict];
        
        NSArray *BBSArray = [NSArray arrayWithArray:array[1]];
        [self.comBTBHeightarray    replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
        
        BBSArray = [NSArray arrayWithArray:array[2]];
        [self.comBModelBBSarray replaceObjectAtIndex:[ClickRow integerValue] withObject:BBSArray[0]];
        
        //刷新
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ClickRow integerValue] inSection:3];
        [self.comBBSTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

//获取查看次数最多的帖子
- (void) RequestSeeNumber
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"comNo"]     =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/hotNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             
             
             if (![[JSON objectForKey:@"returnValue"]isEqual:[NSNull null]]) {
                 
             self.HotPostContentDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
             self.HotLabelPost.text = [NSString stringWithFormat:@"#%@#",[self.HotPostContentDict objectForKey:@"title"]];
             NSLog(@"获取查看次数最多的帖子请求成功title = %@",[self.HotPostContentDict objectForKey:@"title"]);
//             NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//             [self.comBBSTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
             }
         
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
     }];
    //初始化
    self.ClickPRootCellData = [[NSArray alloc] init];
}


@end
