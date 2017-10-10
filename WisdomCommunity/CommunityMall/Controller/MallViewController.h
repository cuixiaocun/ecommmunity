//
//  MallViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区商城首页

#import <UIKit/UIKit.h>
#import "ComMallView.h"
#import "ComMallTableViewCell.h"
#import "TakeOutViewController.h"//外卖首页
#import "SearchViewController.h"//搜索框
#import "GoodsDetailsViewController.h"//商品详情
@interface MallViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,OnClickCMallDelegate>


@property (nonatomic,strong) UITableView *comMallTableView;//商城tableview

@property (nonatomic,strong) NSArray *iconComMallArray;//按钮图标
@property (nonatomic,strong) NSArray *promptComMallArray;//按钮内容

@property (nonatomic,strong) NSMutableArray *recommendedMArray;//推荐商家
@property (nonatomic,strong) NSMutableArray *recommendModelArray;//数据模型

@property (nonatomic,strong) NSMutableArray *hotSellMArray;//热销商家
@property (nonatomic,strong) NSMutableArray *hotSellModelArray;//数据模型

@property (nonatomic,strong) UIButton *recommendedButton;//推荐
@property (nonatomic,strong) UIButton *SellLikeButton;//热销

@property (nonatomic,strong) ComMallView *comMallView;//按钮视图
@property (nonatomic,strong) ComMallTableViewCell *comMallTCell;//
@end
