//
//  PersonalCenterViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  个人中心主页


#import <UIKit/UIKit.h>
#import "AccountSettingViewController.h"//账户信息
#import "MyComplaintsViewController.h"//我的投诉
#import "MyRepairViewController.h"//我的报修
#import "IntegralCommunityViewController.h"//社区积分
#import "AboutUsViewController.h"//关于我们
#import "OpinionsSuggestionsViewController.h"//意见与投诉
#import "MyHousPlistViewController.h"//房屋列表
#import "NeighborhoodActivitiesViewController.h"//我的活动
#import "MyBBSViewController.h"//我的帖子
#import "MyCommentViewController.h"//我的评论
#import "MyThumbUpViewController.h"//我的点赞
#import "SmallShopViewController.h"//我要开微店
#import "OrderMViewController.h"//订单首页
@interface PersonalCenterViewController : UIViewController
@property (nonatomic,weak) UIButton *MyCommunityButton;//我的社区
@property (nonatomic,weak) UIButton *MyPropertyButton;//我的物业
@property (nonatomic,weak) UILabel *integralLabel;//积分label
@property(nonatomic,retain)NSArray *arry;


@end
