//
//  ComMallTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallTableViewCell.h"

@implementation ComMallTableViewCell

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
        //商品图片
        UIImageView *goodsImage = [[UIImageView alloc] init];
        [self.contentView addSubview:goodsImage];
        [goodsImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(24*CXCWidth);
             make.top.equalTo(self.mas_top).offset(35* CXCWidth);
             make.width.mas_equalTo (188 * CXCWidth);
             make.height.mas_equalTo (180 * CXCWidth);

         }];
        goodsImage.contentMode =  UIViewContentModeScaleAspectFill;
        goodsImage.clipsToBounds = YES;

        self.goodsImage = goodsImage;
        //商品名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(goodsImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(goodsImage);
             make.width.mas_equalTo (CYScreanW * 0.5);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.goodsNameLable = nameLabel;
        //详情
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        promptLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:promptLabel];
        promptLabel.numberOfLines =2;
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel);
             make.width.mas_equalTo(CYScreanW * 0.7);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.07);
         }];
        self.goodsPromptLable = promptLabel;
        //价格
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor colorWithRed:0.208 green:0.522 blue:0.906 alpha:1.00];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(goodsImage.mas_right).offset(CYScreanW * 0.03);
             make.bottom.equalTo(goodsImage);
             make.width.mas_equalTo(140*CXCWidth);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.goodsPriceLable = priceLabel;
        //销售数
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
//        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = font;
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(priceLabel.mas_right).offset(10*CXCWidth);
             make.bottom.equalTo(goodsImage);
             make.width.mas_equalTo(CYScreanW * 0.5);
             make.height.equalTo(priceLabel);
         }];
        self.goodsNumberLable = numberLabel;
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

- (void) setMallModel:(ComMallTModel *)mallModel
{
    _mallModel = mallModel;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:_mallModel.goodsPictureString]];
    _goodsNameLable.text = [NSString stringWithFormat:@"%@",_mallModel.goodsNameString];
    _goodsPromptLable.text = [NSString stringWithFormat:@"%@",_mallModel.goodsPromptString];
    _goodsPriceLable.text = [NSString stringWithFormat:@"￥%@",_mallModel.goodsPriceString];
    _goodsNumberLable.text = [NSString stringWithFormat:@"已售%@份",_mallModel.goodsSellNumberString];
    
    
}
@end
