//
//  LifeServiceViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  生活服务

#import <UIKit/UIKit.h>
#import "LifeServiceTableViewCell.h"
@interface LifeServiceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *LifeSTableView;//首页展示tableview

@property (nonatomic,strong) NSMutableArray *dataAllLifeSArray;//论坛数据
@property (nonatomic,strong) NSMutableArray *dataModelLifeSArray;//论坛数据

@property (nonatomic,strong) LifeServiceTableViewCell *lifeCell;

@end
