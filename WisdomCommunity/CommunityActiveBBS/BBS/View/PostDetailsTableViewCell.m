//
//  PostDetailsTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PostDetailsTableViewCell.h"

@implementation PostDetailsTableViewCell

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
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.03, (CYScreanH - 64) * 0.02, CYScreanW * 0.12, (CYScreanH - 64) * 0.08)];
        headImage.image = [UIImage imageNamed:@"头像"];
        [self.contentView addSubview:headImage];
        self.headImageView = headImage;
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"DKJFSDKJFLDS";
        nameLabel.textColor = [UIColor colorWithRed:0.282 green:0.282 blue:0.282 alpha:1.00];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.02);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
             make.width.mas_equalTo(CYScreanW * 0.5);
         }];
        self.nameLabel = nameLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"03-18 12.32.08";
        timeLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:11];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
             make.width.mas_equalTo(CYScreanW * 0.5);
         }];
        self.timeLabel = timeLabel;
        //内容
        UILabel *postLabel = [[UILabel alloc] init];
        postLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        postLabel.font = font;
        postLabel.numberOfLines = 0;
        [postLabel sizeToFit];
        [self.contentView addSubview:postLabel];
        [postLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.02);
             make.top.equalTo(headImage.mas_bottom).offset((CYScreanH - 64) * 0.02);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
         }];
        self.postLabel = postLabel;
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
}

- (void) setModel:(PostDetailsModel *)model
{
    _model = model;
    
    if (_model.headImageString.length > 6)
    {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.headImageString] placeholderImage:nil];
    }
    else
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:DefaultHeadImage] placeholderImage:nil];
    
    NSLog(@"self.model.nameString = %@",self.model.nameString);
    if ([self.model.nameString isEqualToString:@"<null>"] || [self.model.nameString isEqual:[NSNull null]] || !self.model.nameString.length)
    {
        self.nameLabel.text = @"访客";
    }
    else
        self.nameLabel.text = [NSString stringWithFormat:@"%@",_model.nameString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.timeString];
    
//    CGSize size = CGSizeMake(CYScreanW * 0.94, CGFLOAT_MAX);
//    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:[CYSmallTools textEditing:_model.postString.length > 0 ? _model.postString : @""]];
//    if (layout.textBoundingSize.height <= (CYScreanH - 64) * 0.12)
//    {
    self.postLabel.text = [NSString stringWithFormat:@"%@",_model.postString];
//    }
//    else
//    {
//        self.postLabel.text = [NSString stringWithFormat:@"%@...",[_model.postString substringToIndex:70]];
//    }
}

@end
