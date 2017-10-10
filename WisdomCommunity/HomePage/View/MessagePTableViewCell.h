//
//  MessagePTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  消息列表

#import <UIKit/UIKit.h>
#import "MessagePModel.h"
@interface MessagePTableViewCell : UITableViewCell

//头像
@property (nonatomic,weak) UIImageView *messageImage;
//内容，时间
@property (nonatomic,weak) UILabel *MessageLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *detailLabel;


@property (nonatomic,strong) MessagePModel *model;

@end
