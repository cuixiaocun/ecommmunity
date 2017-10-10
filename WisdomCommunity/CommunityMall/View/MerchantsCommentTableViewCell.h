//
//  MerchantsCommentTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  商家评论

#import <UIKit/UIKit.h>
#import "MerchantsCommentModel.h"
@interface MerchantsCommentTableViewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *headImage;
@property (nonatomic,weak) UIView *blackImage;
@property (nonatomic,weak) UIView *lightImage;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *contentLabel;


@property (nonatomic,strong) MerchantsCommentModel *model;

@end
