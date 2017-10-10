//
//  MerchantsCommentTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MerchantsCommentTableViewCell.h"

@implementation MerchantsCommentTableViewCell

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
        UIFont *font = [UIFont fontWithName:@"Arial" size:11];
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, CYScreanH * 0.01, CYScreanH * 0.06, CYScreanH * 0.06)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.headImage = headImage;
        //商家名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(self.mas_top).offset(CYScreanH * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.45);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.nameLabel = nameLabel;
        
        //黑色星星
        UIView *blackStart = [[UIView alloc] init];
        blackStart.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:blackStart];
        [blackStart mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.15);
             make.height.mas_equalTo((CYScreanH - 64) * 0.02);
         }];
        self.blackImage = blackStart;
        for (NSInteger i = 0; i < 5; i ++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
            image.image = [UIImage imageNamed:@"star_blank"];
            [blackStart addSubview:image];
        }
        //金色星星
        UIView *_redStart = [[UIView alloc] init];
        _redStart.backgroundColor = [UIColor clearColor];
        _redStart.clipsToBounds = YES;//超出部分不显示
        [self.contentView addSubview:_redStart];
        [_redStart mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.height.and.left.and.top.equalTo(blackStart);
//             make.width.equalTo(blackStart.mas_width).multipliedBy(.75f);
             make.width.mas_equalTo(CYScreanW * 0.15);
         }];
        self.lightImage = _redStart;
        for (NSInteger i = 0; i < 5; i ++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
            image.image = [UIImage imageNamed:@"star"];
            [_redStart addSubview:image];
        }
        //评论
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.numberOfLines = 0;
        [commentLabel sizeToFit];
    
        commentLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        commentLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:commentLabel];
        
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel);
             make.width.mas_equalTo (CYScreanW * 0.7);
             make.top.equalTo(headImage.mas_bottom).offset(0);
         }];
        self.contentLabel =  commentLabel;
        
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        timeLabel.font = font;
        timeLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
            make.width.mas_equalTo (CYScreanW * 0.4);
            make.top.equalTo(self.mas_top).offset(CYScreanH * 0.02);
            make.height.mas_equalTo(CYScreanH * 0.03);
        }];
        self.timeLabel = timeLabel;
    }
    return self;
}


- (void) setModel:(MerchantsCommentModel *)model
{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_model.headString.length ? _model.headString : DefaultHeadImage]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_model.nameString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.timeString];
//    if (_model.contentString.length > 55)
//    {
//        self.contentLabel.text = [NSString stringWithFormat:@"%@...",[_model.contentString substringToIndex:55]];
//    }
//    else
        self.contentLabel.text = [NSString stringWithFormat:@"%@",_model.contentString];

    NSLog(@"_model.startString = %@,[_model.startString floatValue] / 5 = %.2f",_model.startString,[_model.startString floatValue] / 5);
    [self.lightImage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.height.and.left.and.top.equalTo(self.blackImage);
         make.width.mas_equalTo(CYScreanW * 0.15 * [_model.startString floatValue] / 5);
     }];
    CGSize sizeP = CGSizeMake(CYScreanW * 0.7, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:sizeP text:[CYSmallTools textEditing:_model.contentString.length > 0 ? _model.contentString : @"未获取"]];
    _contentLabel.height = layout.textBoundingSize.height;
    

}

@end
