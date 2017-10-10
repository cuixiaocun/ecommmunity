//
//  MyHouseTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyHouseTableViewCell.h"

@implementation MyHouseTableViewCell

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
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        //
        UIImageView *location = [[UIImageView alloc] init];
        location.image = [UIImage imageNamed:@"icon_receive_addr"];
        [self.contentView addSubview:location];
        
        
        location.frame =CGRectMake((CYScreanW * 0.04), (CYScreanW * 0.07), ((CYScreanW ) * 0.04), ((CYScreanW ) * 0.04));
        
//        [location mas_makeConstraints:^(MASConstraintMaker *make)
//        {
//            make.left.equalTo(self.mas_left).offset(CYScreanW * 0.04);
//            make.width.mas_equalTo((CYScreanW ) * 0.04);
//            make.height.mas_equalTo((CYScreanW ) * 0.04);
//            make.top.equalTo(self.mas_top).offset(CYScreanW * 0.08);
//        }];
        //地址
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        addressLabel.font = font;
        addressLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:addressLabel];
        addressLabel.frame =CGRectMake(location.right+CYScreanW*0.01, location.top, CYScreanW*0.5, CYScreanW*0.05);
//        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(location.mas_right).offset(CYScreanW * 0.01);
//            make.width.mas_equalTo(CYScreanW * 0.7);
//            make.height.mas_equalTo((CYScreanW ) * 0.04);
//            make.top.equalTo(location.mas_top).offset(CYScreanW * 0.08);
//        }];
        self.addressLabel = addressLabel;
        
        
        //当前小区
        UILabel *nowLabel = [[UILabel alloc] init];
        nowLabel.textColor = [UIColor whiteColor];
        nowLabel.text = @"当前小区";
        nowLabel.textAlignment = NSTextAlignmentCenter;
        nowLabel.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        nowLabel.font = font;
        [self.contentView addSubview:nowLabel];
        nowLabel.frame =CGRectMake(CYScreanW*0.75, addressLabel.top,CYScreanW*0.2 , CYScreanW*0.05);
        
//        [nowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
//            make.width.mas_equalTo(CYScreanW * 0.2);
//            make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//            make.top.equalTo(addressLabel.mas_bottom).offset(0);
//        }];
        self.promptLabel = nowLabel;
        //切换//箭头
        CGSize size = [@"切换" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
        CGSize sizeImage = [UIImage imageNamed:@"myhouse_arrow_right"].size;
        UIButton *switchButton = [[UIButton alloc] init];
        switchButton.backgroundColor = [UIColor clearColor];
        [switchButton setTitleColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00] forState:UIControlStateNormal];
        switchButton.titleLabel.font = font;
        [switchButton setTitle:@"切换" forState:UIControlStateNormal];
        [switchButton setImage:[UIImage imageNamed:@"myhouse_arrow_right"] forState:UIControlStateNormal];
        switchButton.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + 2, 0, - size.width - 2);
        switchButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizeImage.width, 0, sizeImage.width);
        switchButton.userInteractionEnabled = NO;
        switchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:switchButton];
        
        switchButton.frame =CGRectMake(CYScreanW*0.75, nowLabel.top-CYScreanW*0.015, CYScreanW*0.2, CYScreanH*0.05);
//        [switchButton mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.05);
//             make.width.mas_equalTo(CYScreanW * 0.2);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//             make.top.equalTo(addressLabel.mas_bottom).offset(0);
//         }];
        self.switchButton = switchButton;
        
        
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW*10/320);
             make.right.equalTo(self.mas_right).offset(CYScreanW*10/320);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(CYScreanW*1/320);
         }];
    }
    return self;
}

- (void) setModel:(MyHouseModel *)model
{
    _model = model;
//    NSLog(@"_model.address = %@",_model.address);
    //地址
    self.addressLabel.text = [NSString stringWithFormat:@"%@",_model.address];
    
    //
    //区别显示
    if ([_model.prompt isEqual:@"当前小区"])
    {
        self.promptLabel.hidden = NO;
        self.switchButton.hidden = YES;
    }
    else
    {
        self.promptLabel.hidden = YES;
        self.switchButton.hidden = NO;
    }
    
}

@end
