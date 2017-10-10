//
//  TakeOutTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  外卖-超市等

#import <UIKit/UIKit.h>
#import "TakeOutModel.h"
@interface TakeOutTableViewCell : UITableViewCell


@property (nonatomic,weak) UIImageView *headImageView;//头像
@property (nonatomic,weak) UILabel *nameLabel;//商家名
@property (nonatomic,weak) UILabel *startLabel;//评价
@property (nonatomic,weak) UIView *BlackView;//黑星星
@property (nonatomic,weak) UIView *LightView;//亮星星
@property (nonatomic,weak) UILabel *numberLabel;//销量
@property (nonatomic,weak) UILabel *sendPriceLabel;//起送价
@property (nonatomic,weak) UILabel *shippingFeeLabel;//配送费
@property (nonatomic,weak) UIImageView *segmentationImmaget;
@property (nonatomic,weak) UILabel *onlineLabel;//活动
@property (nonatomic,weak) UIImageView *UserImageString;//新用户
@property (nonatomic,weak) UIImageView *fullReductionImage;//满减




@property (nonatomic,strong) TakeOutModel *model;

@end
