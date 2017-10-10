//
//  ComAnnoTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区公告

#import <UIKit/UIKit.h>
#import "ComAnnoModel.h"
@interface ComAnnoTableViewCell : UITableViewCell


//头像
@property (nonatomic,weak) UIImageView *messageImage;
//内容，时间
@property (nonatomic,weak) UILabel *MessageLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *detailLabel;


@property (nonatomic,strong) ComAnnoModel *model;

@end
