//
//  MyCommunityListViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/29.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的小区列表

#import <UIKit/UIKit.h>
#import "MyHouseTableViewCell.h"
@interface MyCommunityListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyHouseTableView;//房屋列表tableview

@property (nonatomic,strong) NSMutableArray *AllDataArray;
@property (nonatomic,strong) NSMutableArray *MyHouseAllArray;//总数据
@property (nonatomic,strong) NSMutableArray *MyHouseModelArray;//数据模型

@property (nonatomic,assign) NSInteger recoredShowNowIndex;//记录上一个显示当前小区的下标


@property (nonatomic,strong) MyHouseTableViewCell *MyHouseCell;
@end
