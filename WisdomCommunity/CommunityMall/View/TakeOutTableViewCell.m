//
//  TakeOutTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "TakeOutTableViewCell.h"

@implementation TakeOutTableViewCell

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
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.01, CYScreanW * 0.15, (CYScreanH - 64) * 0.1)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.headImageView = headImage;
        //商家名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.5);
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
             make.top.equalTo(nameLabel.mas_bottom).offset((CYScreanH - 64) * 0.005);
             make.width.mas_equalTo(CYScreanW * 0.15);
             make.height.mas_equalTo((CYScreanH - 64) * 0.02);
         }];
        self.BlackView = blackStart;
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
        self.LightView = _redStart;
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
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.2);
             make.width.mas_equalTo (CYScreanW * 0.7);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.startLabel = perStartNumLabel;
        //起送和配送费
        UILabel *sendPriceLabel = [[UILabel alloc] init];
        sendPriceLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        sendPriceLabel.font = font;
        [self.contentView addSubview:sendPriceLabel];
        [sendPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel);
             make.width.mas_equalTo (CYScreanW * 0.7);
             make.top.equalTo(blackStart.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.sendPriceLabel = sendPriceLabel;
//        //分割线
//        UIImageView *segmentationImmaget = [[UIImageView alloc] init];
//        segmentationImmaget.backgroundColor = BGColor;
//        [self.contentView addSubview:segmentationImmaget];
//        [segmentationImmaget mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.left.equalTo(nameLabel);
//             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
//             make.bottom.equalTo(headImage.mas_bottom).offset(0);
//             make.height.mas_equalTo(1);
//         }];
//        self.segmentationImmaget = segmentationImmaget;
        //满减
        UIImageView *onlineImageView = [[UIImageView alloc] init];
        onlineImageView.image = [UIImage imageNamed:@"icon_blue_de"];
        [self.contentView addSubview:onlineImageView];
        [onlineImageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(nameLabel);
            make.width.mas_equalTo (CYScreanW * 0.045);
            make.top.equalTo(headImage.mas_bottom).offset((CYScreanH - 64) * 0.01);
            make.height.mas_equalTo((CYScreanH - 64) * 0.03);
        }];
        self.fullReductionImage = onlineImageView;
        //新用户
        UIImageView *sendImageView = [[UIImageView alloc] init];
        sendImageView.image = [UIImage imageNamed:@"icon_new"];
        [self.contentView addSubview:sendImageView];
        [sendImageView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel);
             make.width.mas_equalTo (CYScreanW * 0.045);
             make.top.equalTo(headImage.mas_bottom).offset((CYScreanH - 64) * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.UserImageString = sendImageView;
        //活动
        UILabel *onlineLabel = [[UILabel alloc] init];
        onlineLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        onlineLabel.font = font;
        [self.contentView addSubview:onlineLabel];
        [onlineLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(onlineImageView.mas_right).offset(CYScreanW * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.6);
             make.top.equalTo(headImage.mas_bottom).offset((CYScreanH - 64) * 0.01);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.onlineLabel = onlineLabel;
        
//        self.sendGiftsImage = sendImageView;
//        UILabel *sendLabel = [[UILabel alloc] init];
//        sendLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
//        sendLabel.font = font;
//        [self.contentView addSubview:sendLabel];
//        [sendLabel mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.left.equalTo(sendImageView.mas_right).offset(CYScreanW * 0.01);
//             make.width.mas_equalTo (CYScreanW * 0.6);
//             make.top.equalTo(onlineImageView.mas_bottom).offset((CYScreanH - 64) * 0.01);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
//         }];
//        self.sendGiftsLabel = sendLabel;
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
- (void) setModel:(TakeOutModel *)model
{
    _model = model;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.headString.length > 6 ? _model.headString : DefaultHeadImage]];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_model.nameString];
    self.sendPriceLabel.text = [NSString stringWithFormat:@"￥%@起送/配送费%@元",_model.sendPriceString,_model.shippingFeeString];
    self.startLabel.text = [NSString stringWithFormat:@"%.2f分 月售%@单",([_model.startTOString floatValue] / 10.0),_model.numberString];
    self.onlineLabel.text = [NSString stringWithFormat:@"%@",_model.onlineString];
    //立减
    if ([_model.isManJian integerValue] == 1)
    {
        self.segmentationImmaget.hidden = NO;
        
        self.fullReductionImage.hidden = NO;
        self.UserImageString.hidden = YES;
    }
    else if([_model.isNUJianMian integerValue] == 1)
    {
        self.segmentationImmaget.hidden = NO;
        
        self.fullReductionImage.hidden = YES;
        self.UserImageString.hidden = NO;
    }
    else
    {
        self.onlineLabel.text = @"";
        self.segmentationImmaget.hidden = YES;
        self.fullReductionImage.hidden = YES;
        self.UserImageString.hidden = YES;
    }
    
    
    [self.LightView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.height.and.left.and.top.equalTo(self.BlackView);
         make.width.mas_equalTo(CYScreanW * 0.15 * ([_model.startTOString floatValue] / 100));
     }];
    
}
@end
