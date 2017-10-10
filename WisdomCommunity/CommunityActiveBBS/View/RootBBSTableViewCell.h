//
//  RootBBSTableViewCell.h
//  WisdomCommunity
//
//  Created by Admin on 2017/4/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comBBSModel.h"

@interface RootBBSTableViewCell : UITableViewCell


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

//评论
@property (nonatomic,weak) UIButton *commentButton;
//点赞
@property (nonatomic,weak) UIButton *thumbUpButton;

@property (nonatomic,strong) comBBSModel *model;


@end
