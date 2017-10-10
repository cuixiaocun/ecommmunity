//
//  MyThumbUpTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyThumbUpTableViewCell.h"

@implementation MyThumbUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.01, CYScreanW * 0.12, (CYScreanH - 64) * 0.08)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.headImageView = headImage;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.16);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.4);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.nameLabel = nameLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.width.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.timeLabel = timeLabel;
        //展示内容图片
        UIImageView *contentImageOne = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageOne];
        [contentImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
            make.top.equalTo(headImage.mas_bottom).offset((CYScreanH - 64) * 0.02);
            make.height.mas_equalTo((CYScreanH - 64) * 0.13);
            make.width.mas_equalTo((CYScreanH - 64) * 0.13);
        }];
        self.showImageView = contentImageOne;
        //评论对象
        UILabel *comNameLabel = [[UILabel alloc] init];
        comNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:comNameLabel];
        [comNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentImageOne.mas_top).offset((CYScreanH - 64) * 0.01);
            make.left.equalTo(contentImageOne.mas_right).offset(CYScreanW * 0.03);
            make.height.mas_equalTo((CYScreanH - 64) * 0.05);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
        }];
        self.comNameLabel = comNameLabel;
        //帖子标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = font;
        titleLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(comNameLabel.mas_bottom).offset(0);
            make.left.equalTo(contentImageOne.mas_right).offset(CYScreanW * 0.03);
            make.height.mas_equalTo((CYScreanH - 64) * 0.05);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
        }];
        self.titleLabel = titleLabel;
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.top.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
}


- (void) setModel:(MyThumbUpModel *)model
{
    _model = model;
    self.headImageView.image   = [UIImage imageNamed:_model.headString];
    self.nameLabel.text        = [NSString stringWithFormat:@"%@",_model.nameString];
    self.timeLabel.text        = [NSString stringWithFormat:@"%@",_model.timeString];
    self.showImageView.image   = [UIImage imageNamed:_model.showImageString];
    self.comNameLabel.text     = [NSString stringWithFormat:@"@%@",_model.comNameString];
    self.titleLabel.text       = [NSString stringWithFormat:@"%@",_model.titleString];
    
    
}

@end
