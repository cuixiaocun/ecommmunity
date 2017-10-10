//
//  RootTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  首页论坛

#import <UIKit/UIKit.h>
#import "RootTBmodel.h"
@interface RootTableViewCell : UITableViewCell


//头像
@property (nonatomic,weak) UIImageView *headImage;
//用户名
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *timeLabel;
//来自
@property (nonatomic,weak) UILabel *comeLabel;
//论坛内容
@property (nonatomic,weak) UILabel *contentLabel;
//展示内容图片
@property (nonatomic,weak) UIImageView *contentImageOne;
@property (nonatomic,weak) UIImageView *contentImageTwo;
@property (nonatomic,weak) UIImageView *contentImageThree;
//提示图片总数
@property (nonatomic,weak) UIImageView *promptImage;
@property (nonatomic,weak) UILabel *promptLabel;
//查看次数
@property (nonatomic,weak) UIButton *toViewButton;
//分享
//@property (nonatomic,weak) UIButton *shareButton;
//评论
@property (nonatomic,weak) UIButton *commentButton;
//点赞
@property (nonatomic,weak) UIButton *thumbUpButton;

@property (nonatomic,strong) RootTBmodel *model;


@end
