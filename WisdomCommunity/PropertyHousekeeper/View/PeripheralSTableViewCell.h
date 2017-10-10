//
//  PeripheralSTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  周边服务

#import <UIKit/UIKit.h>
#import "PeripheralSModel.h"
@interface PeripheralSTableViewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *perSerHeadImage;//头像
@property (nonatomic,weak) UILabel *perNameLabel;//名字
@property (nonatomic,weak) UILabel *perStartNumLabel;//评价
@property (nonatomic,weak) UILabel *perNumberLabel;//销售量
@property (nonatomic,weak) UILabel *perAddressLabel;//地址
@property (nonatomic,weak) UIImageView *phoneImage;//电话标志


@property (nonatomic,strong) PeripheralSModel *model;

@end
