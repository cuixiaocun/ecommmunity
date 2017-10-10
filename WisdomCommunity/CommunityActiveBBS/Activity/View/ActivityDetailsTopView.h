//
//  ActivityDetailsTopView.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailsModel.h"

typedef void(^Block)(UIButton *);
@interface ActivityDetailsTopView : UIView

@property (nonatomic, strong) UIButton    *participateButton;//参与人数
@property (nonatomic, copy)   Block       participateDidClicked;


@property (nonatomic, strong) UIImageView *headImage;//头
@property (nonatomic, strong) UIImageView *faceImage;//头像
@property (nonatomic, strong) UILabel     *titlelabel;//标题
@property (nonatomic, strong) UILabel     *participateLabel;//参与人数
@property (nonatomic, strong) UILabel     *nameLabel;//姓名
@property (nonatomic, strong) UILabel     *timeLabel;//时间
@property (nonatomic, strong) UILabel     *acTimeLabel;//时间段
@property (nonatomic, strong) UILabel     *addressLabel;//地址
@property (nonatomic, strong) UILabel     *comeLabel;//来自

- (void)setTopViewWithModel:(ActivityDetailsModel *)model;

@end
