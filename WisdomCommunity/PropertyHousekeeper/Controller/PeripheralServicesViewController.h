//
//  PeripheralServicesViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  周边服务页面

#import <UIKit/UIKit.h>
#import "PeripheralSTableViewCell.h"
@interface PeripheralServicesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *PeripheralSTableView;//首页展示tableview

@property (nonatomic,strong) NSMutableArray *dataAllPerSArray;//论坛数据
@property (nonatomic,strong) NSMutableArray *dataModelPerSArray;//论坛数据

@property (nonatomic,strong) PeripheralSTableViewCell *perCell;

@end
