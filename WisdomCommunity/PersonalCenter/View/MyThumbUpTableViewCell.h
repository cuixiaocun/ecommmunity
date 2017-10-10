//
//  MyThumbUpTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的点赞

#import <UIKit/UIKit.h>
#import "MyThumbUpModel.h"
@interface MyThumbUpTableViewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *headImageView;//
@property (nonatomic,weak) UILabel *nameLabel;//
@property (nonatomic,weak) UILabel *timeLabel;//
@property (nonatomic,weak) UIImageView *showImageView;//
@property (nonatomic,weak) UILabel *comNameLabel;//评论对象
@property (nonatomic,weak) UILabel *titleLabel;//标题

@property (nonatomic,strong) MyThumbUpModel *model;
@end
