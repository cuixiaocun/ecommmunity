//
//  LifeServiceTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "LifeServiceTableViewCell.h"

@implementation LifeServiceTableViewCell

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
        UIFont *font = [UIFont fontWithName:@"Arial" size:10];
        
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.01, CYScreanW * 0.1725, (CYScreanH - 64) * 0.115)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.lifeHeadImage = headImage;
        //商家名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.lifeNameLabel = nameLabel;
        
        //黑色星星
        UIView *blackStart = [[UIView alloc] init];
        blackStart.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:blackStart];
        [blackStart mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo(CYScreanW * 0.15);
             make.height.mas_equalTo((CYScreanH - 64) * 0.02);
         }];
        for (NSInteger i = 0; i < 5; i ++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
            image.image = [UIImage imageNamed:@"star_blank"];
            image.userInteractionEnabled = YES;
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
             make.width.equalTo(blackStart.mas_width).multipliedBy(.75f);
         }];
        for (NSInteger i = 0; i < 5; i ++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(  CYScreanW * 0.03 * i, 0, CYScreanW * 0.03, CYScreanH * 0.02)];
            image.image = [UIImage imageNamed:@"star"];
            [_redStart addSubview:image];
        }
        
        
        //评分
        UILabel *perStartNumLabel = [[UILabel alloc] init];
        perStartNumLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        perStartNumLabel.font = font;
        [self.contentView addSubview:perStartNumLabel];
        [perStartNumLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(blackStart.mas_right).offset(CYScreanW * 0.02);
             make.width.mas_equalTo (CYScreanW * 0.7);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.lifeStartNumLabel = perStartNumLabel;
        
        //地址
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        addressLabel.font = font;
        [self.contentView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.width.mas_equalTo (CYScreanW * 0.7);
            make.top.equalTo(perStartNumLabel.mas_bottom).offset(0);
            make.height.mas_equalTo((CYScreanH - 64) * 0.035);
        }];
        self.lifeAddressLabel = addressLabel;
        //电话
        UIImageView *phoneImage = [[UIImageView alloc] init];
        phoneImage.image = [UIImage imageNamed:@"23icon_telephone"];
        phoneImage.userInteractionEnabled = YES;
        [self.contentView addSubview:phoneImage];
        [phoneImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.04);
             make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.045);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        //添加单击手势防范
        UITapGestureRecognizer *phoneImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLifeTap:)];
        phoneImageTap.numberOfTapsRequired = 1;
        [phoneImage addGestureRecognizer:phoneImageTap];
        self.lifePhoneImage = phoneImage;
        
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
- (void) setModel:(LifeServiceModel *)model
{
    _model = model;
    
    self.lifeHeadImage.image = [UIImage imageNamed:_model.lifeHeadString];
    self.lifeNameLabel.text = [NSString stringWithFormat:@"%@",_model.lifeNameString];
    self.lifeStartNumLabel.text = [NSString stringWithFormat:@"%@分 月售%@单",_model.lifeStartString,_model.lifeNumberString];
    self.lifeAddressLabel.text = [NSString stringWithFormat:@"地址:%@",_model.lifeAddressString];
    
    //改变字体颜色
    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:self.lifeStartNumLabel.text];
    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.906 green:0.573 blue:0.000 alpha:1.00] range:NSMakeRange(0,4)];
    self.lifeStartNumLabel.attributedText = sendMessageString;
    
}




//商品点击手势
-(void)handleLifeTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"_model.perPhooneString = %@",_model.lifePhooneString);
    [self callPhone:@"18769278095"];
}
//拨打电话
- (void)callPhone:(NSString *)phoneNumber
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.contentView addSubview:callWebview];
}


@end
