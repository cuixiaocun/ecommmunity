//
//  NeighborhoodActivitiesViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  个人中心我的活动页面

#import <UIKit/UIKit.h>
#import "ActivityRootTableViewCell.h"
#import "ActivityDetailsViewController.h"
@interface NeighborhoodActivitiesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property ( nonatomic, strong) UITableView                *AcNeighborhoodTableView;//个人中心tableview
@property ( nonatomic, strong) UIButton                   *participateNAButton;//参与
@property ( nonatomic, strong) UIButton                   *releaseNAButton;//发布

@property (nonatomic,assign) BOOL IsClickLabel;//是否点击标签进行数据请求
@property ( nonatomic, strong) NSMutableArray             *myParticipateArray;       //我参与数组
@property ( nonatomic, assign) NSInteger                  currentParticipatePage;   //我参与的当前页数
@property ( nonatomic, strong) NSMutableArray             *myReleaseArray;           //我发布的数组
@property ( nonatomic, assign) NSInteger                  currentReleasePage;       //我发布的当前页数
@property ( nonatomic, strong) ActivityRootTableViewCell  *cell;

@property (nonatomic, strong) UIImageView *NeighborhoodImage;//提示

@end
