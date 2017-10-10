//
//  OrderMTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单主页cell

#import <UIKit/UIKit.h>
#import "OrderMModel.h"
@interface OrderMTableViewCell : UITableViewCell


@property (nonatomic,weak) UILabel *orderIdLabel;//订单id
@property (nonatomic,weak) UIImageView *orderHeadImage;//头像
@property (nonatomic,weak) UILabel *orderNameLabel;//名字
@property (nonatomic,weak) UILabel *timeLabel;//
@property (nonatomic,weak) UILabel *moneyLabel;//销售量

@property (nonatomic,weak) UILabel *statusPromptLabel;//状态提示

@property (nonatomic,weak) UIButton *OrderDetailsButton;//订单详情
@property (nonatomic,weak) UIButton *OrderPayButton;//订单状态


@property (nonatomic,strong) OrderMModel *model;
@end
