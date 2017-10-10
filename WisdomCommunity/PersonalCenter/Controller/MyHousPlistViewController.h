//
//  MyHousPlistViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的房屋列表

#import <UIKit/UIKit.h>
#import "MyHouseTableViewCell.h"
#import "HousingChoiceViewController.h"
@interface MyHousPlistViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyHouseTableView;//房屋列表tableview


@property (nonatomic,strong) NSMutableArray *MyHouseAllArray;//总数据

@property (nonatomic,weak) UILabel *promptLabel;//提示没有房屋


@property (nonatomic,strong) MyHouseTableViewCell *MyHouseCell;



@end
