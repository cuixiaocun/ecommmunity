//
//  PostDetailsTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  帖子详情

#import <UIKit/UIKit.h>
#import "PostDetailsModel.h"

@interface PostDetailsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *postLabel;//


@property (nonatomic,strong) PostDetailsModel *model;

@end
