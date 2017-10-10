//
//  RootTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

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
        self.headImage = headImage;
        //用户名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
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
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.width.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.timeLabel = timeLabel;
        //来自
        UILabel *comeLabel = [[UILabel alloc] init];
        comeLabel.textColor = [UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:1.00];
        comeLabel.textAlignment = NSTextAlignmentRight;
        comeLabel.font = font;
        [self.contentView addSubview:comeLabel];
        [comeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
             make.bottom.equalTo(headImage.mas_bottom);
             make.width.mas_equalTo(CYScreanW * 0.4);
        }];
        self.comeLabel = comeLabel;
        
        //论坛内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headImage);
            make.top.equalTo(headImage.mas_bottom).offset(0);
            make.right.equalTo(comeLabel);
            make.height.mas_equalTo((CYScreanH - 64) * 0.06);
        }];
        self.contentLabel = contentLabel;
        //展示内容图片
        UIImageView *contentImageOne = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageOne];
        [contentImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
            make.top.equalTo(contentLabel.mas_bottom).offset(0);
            make.height.mas_equalTo((CYScreanH - 64) * 0.13);
            make.width.mas_equalTo(CYScreanW * 0.94 / 3);
        }];
        self.contentImageOne = contentImageOne;
        self.contentImageOne.contentMode =  UIViewContentModeScaleAspectFill;
        self.contentImageOne.clipsToBounds = YES;
        
        
        UIImageView *contentImageTwo = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageTwo];
        [contentImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentImageOne.mas_right).offset(CYScreanW * 0.01);
            make.top.and.width.and.height.equalTo(contentImageOne);
        }];
        self.contentImageTwo = contentImageTwo;
        self.contentImageTwo.contentMode =  UIViewContentModeScaleAspectFill;
        self.contentImageTwo.clipsToBounds = YES;
        
        
        
        UIImageView *contentImageThree = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImageThree];
        [contentImageThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentImageTwo.mas_right).offset(CYScreanW * 0.01);
            make.top.and.width.and.height.equalTo(contentImageOne);
        }];
            self.contentImageThree = contentImageThree;
        self.contentImageThree.contentMode =  UIViewContentModeScaleAspectFill;
        self.contentImageThree.clipsToBounds = YES;

        
        //提示图片总数
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.01);
            make.bottom.equalTo(contentImageOne.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
            make.width.mas_equalTo(CYScreanW * 0.1);
        }];
       
        self.promptLabel = promptLabel;
        UIImageView *promptImage = [[UIImageView alloc] init];
        promptImage.image = [UIImage imageNamed:@"icon_pic"];
        [self.contentView addSubview:promptImage];
        [promptImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(promptLabel.mas_left).offset(-5);
            make.bottom.equalTo(contentImageOne.mas_bottom).offset(-(CYScreanH - 64) * 0.015);
            make.height.mas_equalTo((CYScreanH - 64) * 0.03);
            make.width.mas_equalTo(CYScreanW * 0.06);
        }];
        self.promptImage = promptImage;
        //查看次数
        UIButton *toViewButton = [[UIButton alloc] init];
        toViewButton.titleLabel.font = font;
        [toViewButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
        [toViewButton setImage:[UIImage imageNamed:@"view_icon"] forState:UIControlStateNormal];
        toViewButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        toViewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [self.contentView addSubview:toViewButton];
        [toViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.06);
            make.width.mas_equalTo(CYScreanW * 0.2);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.toViewButton = toViewButton;
        //点赞
        UIButton *thumbUpButton = [[UIButton alloc] init];
        thumbUpButton.titleLabel.font = font;
        [thumbUpButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
        [thumbUpButton setImage:[UIImage imageNamed:@"like_icon"] forState:UIControlStateNormal];
        thumbUpButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        thumbUpButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [self.contentView addSubview:thumbUpButton];
        [thumbUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.08);
            make.width.mas_equalTo(CYScreanW * 0.15);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.thumbUpButton = thumbUpButton;
        //评论
        UIButton *commentButton = [[UIButton alloc] init];//comments_icon
        commentButton.titleLabel.font = font;
        [commentButton setTitleColor:[UIColor colorWithRed:0.651 green:0.620 blue:0.580 alpha:1.00] forState:UIControlStateNormal];
        [commentButton setImage:[UIImage imageNamed:@"comments_icon"] forState:UIControlStateNormal];
        commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [self.contentView addSubview:commentButton];
        [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
            make.right.equalTo(thumbUpButton.mas_left).offset(-CYScreanW * 0.05);
            make.width.mas_equalTo(CYScreanW * 0.15);
            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.commentButton = commentButton;
//        //分享
//        UIButton *shareButton = [[UIButton alloc] init];
//        shareButton.titleLabel.font = font;
//        [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//        [self.contentView addSubview:shareButton];
//        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
//            make.right.equalTo(commentButton.mas_left).offset(-CYScreanW * 0.05);
//            make.width.mas_equalTo(CYScreanW * 0.1);
//            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//        }];
//        self.shareButton = shareButton;
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
- (void) setModel:(RootTBmodel *)model
{
    _model = model;
    NSLog(@"model = %@",model);
    self.headImage.image = [UIImage imageNamed:@"an_006"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",self.model.nameString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.model.timeString];
    self.comeLabel.text = [NSString stringWithFormat:@"%@",self.model.comeString];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",self.model.contentString];
    self.promptLabel.text = [NSString stringWithFormat:@"%@",self.model.pictureNumber];
    [self.toViewButton setTitle:[NSString stringWithFormat:@"%@",self.model.checkNumber] forState:01];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",self.model.commentNumber] forState:UIControlStateNormal];
    [self.thumbUpButton setTitle:[NSString stringWithFormat:@"%@",self.model.fabulousNumber] forState:UIControlStateNormal];
    self.contentImageOne.image = [UIImage imageNamed:self.model.contentImageOne];
    self.contentImageTwo.image = [UIImage imageNamed:self.model.contentImageTwo];
    self.contentImageThree.image = [UIImage imageNamed:self.model.contentImageThree];
    
    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:self.comeLabel.text];
    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,2)];
    //        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0,2)];
    self.comeLabel.attributedText = sendMessageString;
    
}
@end
