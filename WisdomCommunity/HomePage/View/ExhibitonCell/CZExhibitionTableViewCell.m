//
//  CZExhibitionTableViewCell.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CZExhibitionTableViewCell.h"

@interface CZExhibitionTableViewCell()

@property ( nonatomic, strong) UIImageView  *headImageView;
@property ( nonatomic, strong) UIImageView  *stateImageView;
@property ( nonatomic, strong) UILabel      *nameLabel;
@property ( nonatomic, strong) UILabel      *accountLabel;
@property ( nonatomic, strong) UILabel      *dateLabel;

@end

@implementation CZExhibitionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initExhibitionCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}


- (void)initExhibitionCell
{
    self.headImageView  = [[UIImageView alloc] init];
    self.stateImageView = [[UIImageView alloc] init];
    self.nameLabel      = [[UILabel alloc] init];
    self.accountLabel   = [[UILabel alloc] init];
    self.dateLabel      = [[UILabel alloc] init];
    UIView *view        = [[UIView alloc] init];
    
    view.alpha                  = 0.5;
    view.backgroundColor        = [UIColor lightGrayColor];
    self.nameLabel.textColor    = [UIColor blackColor];
    self.accountLabel.textColor = [UIColor lightGrayColor];
    self.dateLabel.textColor    = [UIColor lightGrayColor];
    
    self.nameLabel.font    = [UIFont systemFontOfSize:17.0f];
    self.accountLabel.font = [UIFont systemFontOfSize:13.0f];
    self.dateLabel.font    = [UIFont systemFontOfSize:13.0f];
    
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.stateImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.accountLabel];
    [self.contentView addSubview:view];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_offset(150);
    }];
    
    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.stateImageView.mas_left).offset(-10);
        make.height.mas_offset(25);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(1);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.stateImageView.mas_left).offset(-10);
        make.height.mas_offset(17);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLabel.mas_bottom).offset(1);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.stateImageView.mas_left).offset(-10);
        make.height.mas_offset(17);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(0.5);
    }];
    
}

- (void)setExhibitionCell:(CZExhibitionModel *)model
{
    if (model.imageUrl.length > 6) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    }
    else
    {
        if ([model.type integerValue] == 0)
        {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://7xwtb9.com2.z0.glb.qiniucdn.com/%E4%B8%AD%E9%97%B4%E5%9B%BE_%E6%B2%B9%E7%94%BB.jpg"] placeholderImage:[UIImage imageNamed:@""]];
        }
        else
        {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://7xwtb9.com2.z0.glb.qiniucdn.com/%E4%B8%AD%E9%97%B4%E5%9B%BE_%E8%A3%85%E9%A5%B0.jpg"] placeholderImage:[UIImage imageNamed:@""]];
        }
    }
    
    
    self.stateImageView.image = [model.state isEqualToString:@"1"]?[UIImage imageNamed:@"icon_zhanlan_ongoing"]:[UIImage imageNamed:@"icon_zhanlan_ending"];
    self.nameLabel.text = model.name;
    self.accountLabel.text = model.account;
    self.dateLabel.text = model.date;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
