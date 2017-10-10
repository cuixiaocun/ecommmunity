//
//  OrderMViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单首页

#import <UIKit/UIKit.h>
#import "OrderMTableViewCell.h"
#import "OrderDetailsViewController.h"
@interface OrderMViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *OrderMTableView;//订单首页tableview

@property (nonatomic,strong) OrderMTableViewCell *OrderCell;//订单


@property (nonatomic,strong) NSMutableArray *MyOrderModelArray;//订单模型
@property (nonatomic,strong) NSArray *MyOrderAllDataArray;//订单总数据

@end
