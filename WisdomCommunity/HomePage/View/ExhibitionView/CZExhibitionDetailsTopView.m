//
//  CZExhibitionDetailsTopView.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/28.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CZExhibitionDetailsTopView.h"

@interface CZExhibitionDetailsTopView()

@property ( nonatomic, strong) UIImageView *topImageView;
@property ( nonatomic, strong) UILabel *nameLabel;
@property ( nonatomic, strong) UILabel *accountLabel;
@property ( nonatomic, strong) UILabel *dateLabel;
@property ( nonatomic, strong) UIImageView *stateImageView;
@property ( nonatomic, strong) UILabel *stateLabel;

@end


@implementation CZExhibitionDetailsTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initEXhibitionDetailsTopView];
    }
    return self;
}

- (void)initEXhibitionDetailsTopView
{
    self.topImageView             = [[UIImageView alloc] init];
    self.nameLabel                = [[UILabel alloc] init];
    self.accountLabel             = [[UILabel alloc] init];
    self.dateLabel                = [[UILabel alloc] init];
    self.stateImageView           = [[UIImageView alloc] init];
    self.stateLabel               = [[UILabel alloc] init];
    UIView *view                  = [[UIView alloc] init];
    
    view.alpha                    = 0.5;
    
    self.topImageView.backgroundColor = [UIColor lightGrayColor];
    view.backgroundColor          = [UIColor lightGrayColor];
    self.nameLabel.textColor      = [UIColor whiteColor];
    self.accountLabel.textColor   = [UIColor lightGrayColor];
    self.dateLabel.textColor      = [UIColor lightGrayColor];
    self.stateLabel.textColor     = [UIColor whiteColor];
    
    self.nameLabel.font           = [UIFont systemFontOfSize:18.0f];
    self.accountLabel.font        = [UIFont systemFontOfSize:13.0f];
    self.dateLabel.font           = [UIFont systemFontOfSize:13.0f];
    self.stateLabel.font          = [UIFont systemFontOfSize:15.0f];
    
    self.nameLabel.textAlignment  = NSTextAlignmentCenter;
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self addSubview:self.topImageView];
    [self.topImageView addSubview:self.nameLabel];
    [self addSubview:self.accountLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.stateImageView];
    [self.stateImageView addSubview:self.stateLabel];
    [self addSubview:view];
    
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(150);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.topImageView);
        make.left.equalTo(self.topImageView).offset(20);
        make.height.mas_offset(25);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.stateImageView.mas_left).offset(-10);
        make.height.mas_offset(15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLabel.mas_bottom).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.stateImageView.mas_left).offset(-10);
        make.height.mas_offset(15);
    }];
    
    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(5);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.stateImageView);
        make.left.equalTo(self.stateImageView).offset(5);
        make.height.mas_offset(25);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.mas_offset(0.5);
    }];
    
    
    
}

- (void)setExhibitionDetailsTopView:(NSString *)imageUrl
                            andName:(NSString *)name
                         andAccount:(NSString *)account
                            andDate:(NSString *)date
                           andState:(NSString *)state
                            andType:(NSString *)type
{
    
    if (imageUrl.length > 6)
    {
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    else
    {
        if ([type integerValue] == 0)
        {
            [self.topImageView sd_setImageWithURL:[NSURL URLWithString:@"http://7xwtb9.com2.z0.glb.qiniucdn.com/%E4%B8%AD%E9%97%B4%E5%9B%BE_%E6%B2%B9%E7%94%BB.jpg"]];
        }
        else
        {
            [self.topImageView sd_setImageWithURL:[NSURL URLWithString:@"http://7xwtb9.com2.z0.glb.qiniucdn.com/%E4%B8%AD%E9%97%B4%E5%9B%BE_%E8%A3%85%E9%A5%B0.jpg"]];
        }
    }
    self.nameLabel.text = name;
    self.accountLabel.text = account;
    self.dateLabel.text = date;
    self.stateImageView.image = [state isEqualToString:@"1"]?[UIImage imageNamed:@"icon_status_bg"]:[UIImage imageNamed:@"icon_status_end_bg"];
    
    self.stateLabel.text = [state isEqualToString:@"1"]?@"进行中":@"已结束";
}


@end
