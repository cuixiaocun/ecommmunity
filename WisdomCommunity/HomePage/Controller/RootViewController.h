//
//  RootViewController.h
//  WisdomCommunity
//   在别的设备登陆。 未登录
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  主页

#import <UIKit/UIKit.h>
#import "JXBAdPageView.h"
#import "RootCTView.h"
#import "ActivityRootModel.h"
#import "comBBSTableViewCell.h"
#import "comBBSModel.h"
#import "PropertyViewController.h"//物业管家
#import "MessagePlistViewController.h"//消息列表
#import "ComAnnouncementViewController.h"//社区公告
#import "RootBBSTableViewCell.h"

#import "PostDetailsViewController.h"//帖子详情
#import "ActivityDetailsViewController.h"
#import "CYFromProgressView.h"
#import "MyCommunityListViewController.h"//小区
#import "CZExhibitionViewController.h"//油画,装潢展览
#import "UITapGestureRecognizer+UserInfo.h"//
#import "CYLoginViewController.h"
#import "RootMiddleView.h"


#import "NNSRootModelData.h"
@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,OnClickCollectionDelegate,CAAnimationDelegate>


@property (nonatomic,strong) UITableView *RootSTableView;//首页展示tableview
@property (nonatomic,strong) UIImageView *showActivityImmage;
//@property (nonatomic,weak)   UIImageView *leftImmage;//广告
//@property (nonatomic,weak)   UIImageView *PolkaDotsImageView;//广告
@property (nonatomic,weak)   UIImageView *OilImageView;//油画

@property (nonatomic,strong) CYEmitterButton *signInBtn;//签到按钮
@property (nonatomic,assign) BOOL whetherSignIn;//是否已签到

//论坛数据
@property (nonatomic,strong) NSMutableArray *dataAllBBSArray;//总数据
@property (nonatomic,strong) NSMutableArray *dataModelBBSArray;
@property (nonatomic,strong) NSMutableArray *dataAllHeght;//高度
@property (nonatomic,strong) NSArray *ClickRootCellData;//点击cell数据


@property (nonatomic,strong) RootBBSTableViewCell *cell;
@property (nonatomic,strong) JXBAdPageView *ShufflingFigureView;//轮播图
@property (nonatomic,strong) RootMiddleView *ctView;//按钮
@property (nonatomic,strong) ActivityRootModel *activityModel;//活动model
@property (nonatomic,strong) UIButton *communityButton;//定位小区

//两种不同的CAEmitterLayer
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end
