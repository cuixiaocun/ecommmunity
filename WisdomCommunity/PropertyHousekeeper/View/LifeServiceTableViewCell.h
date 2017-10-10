//
//  LifeServiceTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  生活服务

#import <UIKit/UIKit.h>
#import "LifeServiceModel.h"
@interface LifeServiceTableViewCell : UITableViewCell


@property (nonatomic,weak) UIImageView *lifeHeadImage;//头像
@property (nonatomic,weak) UILabel *lifeNameLabel;//名字
@property (nonatomic,weak) UILabel *lifeStartNumLabel;//评价
@property (nonatomic,weak) UILabel *lifeNumberLabel;//销售量
@property (nonatomic,weak) UILabel *lifeAddressLabel;//地址
@property (nonatomic,weak) UIImageView *lifePhoneImage;//电话标志


@property (nonatomic,strong) LifeServiceModel *model;

@end
