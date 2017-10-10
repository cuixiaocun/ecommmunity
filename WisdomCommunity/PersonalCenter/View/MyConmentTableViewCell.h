//
//  MyConmentTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的评论

#import <UIKit/UIKit.h>
#import "MyCommentModel.h"
@interface MyConmentTableViewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *headImageView;//
@property (nonatomic,weak) UILabel *nameLabel;//
@property (nonatomic,weak) UILabel *timeLabel;//
@property (nonatomic,weak) UIImageView *showImageView;//
@property (nonatomic,weak) UILabel *commentPostLabel;//内容
@property (nonatomic,weak) UILabel *comNameLabel;//评论对象
@property (nonatomic,weak) UILabel *titleLabel;//标题

@property (nonatomic,strong) MyCommentModel *model;

@end
