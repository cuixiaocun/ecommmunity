//
//  OrderMTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderMTableViewCell.h"

@implementation OrderMTableViewCell

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
        
        //订单号
        UILabel *orderIdLabel = [[UILabel alloc] init];
        orderIdLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        orderIdLabel.textAlignment = NSTextAlignmentLeft;
        orderIdLabel.font = font;
        [self.contentView addSubview:orderIdLabel];
        [orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.03);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.75);
             make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         }];
        self.orderIdLabel = orderIdLabel;
        
        //头像
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, (CYScreanH - 64) * 0.07, (CYScreanH - 64) * 0.12, (CYScreanH - 64) * 0.12)];
        [self.contentView addSubview:headImage];
        //圆角
        headImage.layer.cornerRadius = headImage.frame.size.width / 2;
        headImage.clipsToBounds = YES;
        self.orderHeadImage = headImage;
        //商家名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(headImage.mas_right).offset(CYScreanW * 0.03);
             make.top.equalTo(orderIdLabel.mas_bottom).offset((CYScreanH - 64) * 0.02);
             make.width.mas_equalTo (CYScreanW * 0.55);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.orderNameLabel = nameLabel;
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1.00];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.with.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
         }];
        self.timeLabel = timeLabel;
        
        //价格
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textColor = [UIColor colorWithRed:0.925 green:0.651 blue:0.263 alpha:1.00];
        moneyLabel.font = font;
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.with.and.height.equalTo(nameLabel);
            make.top.equalTo(timeLabel.mas_bottom).offset(0);
        }];
        self.moneyLabel = moneyLabel;
        //状态提示   statusPromptLabel
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
        stateLabel.font = [UIFont fontWithName:@"Arial" size:15];
        stateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:stateLabel];
        [stateLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
             make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
             make.width.mas_equalTo (CYScreanW * 0.3);
             make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         }];
        self.statusPromptLabel = stateLabel;
//        //
//        UIButton *goPayBtn = [[UIButton alloc] init];
//        [goPayBtn setTitle:@"" forState:UIControlStateNormal];
//        [goPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        goPayBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
//        goPayBtn.backgroundColor = [UIColor colorWithRed:0.925 green:0.651 blue:0.263 alpha:1.00];
//        goPayBtn.layer.cornerRadius = 5;
//        [self.contentView addSubview:goPayBtn];
//        [goPayBtn mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
//             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
//             make.width.mas_equalTo(CYScreanW * 0.15);
//             make.bottom.equalTo(self.mas_bottom).offset(-(CYScreanH - 64) * 0.02);
//         }];
//        self.OrderPayButton = goPayBtn;
//        //
//        UIButton *orderDetails = [[UIButton alloc] init];
//        [orderDetails setTitle:@"订单详情" forState:UIControlStateNormal];
//        [orderDetails setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        orderDetails.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
//        orderDetails.backgroundColor = [UIColor colorWithRed:0.925 green:0.651 blue:0.263 alpha:1.00];
//        orderDetails.layer.cornerRadius = 5;
//        [self.contentView addSubview:orderDetails];
//        [orderDetails mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.right.equalTo(goPayBtn.mas_left).offset(-CYScreanW * 0.03);
//             make.height.and.width.and.bottom.equalTo(goPayBtn);
//         }];
//        self.OrderDetailsButton = orderDetails;
        
        
        
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
- (void) setModel:(OrderMModel *)model
{
    _model = model;
    
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单号:NO.%@",_model.orderIdString];
    [self.orderHeadImage sd_setImageWithURL:[NSURL URLWithString:_model.headImageString]];
    self.orderNameLabel.text = [NSString stringWithFormat:@"%@",_model.nameString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.timeString];
    if([_model.moneyString isEqualToString:@"<null>"])
    {
        self.moneyLabel.text = @"价格：暂无";

    }else
    {
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.moneyString floatValue]];
    }
    
    switch ([_model.satateString integerValue])
    {
        case 1:
            self.statusPromptLabel.text =  @"等待接单";
//            self.OrderPayButton.hidden = NO;
//            [self.OrderPayButton setTitle:@"取消订单" forState:UIControlStateNormal];
            break;
        case 2:
            self.statusPromptLabel.text =  @"等待送达";
//            self.OrderPayButton.hidden = YES;
            break;
        case 3:
            self.statusPromptLabel.text =  @"商家拒单";
//            self.OrderPayButton.hidden = YES;
            break;
        case 4:
            self.statusPromptLabel.text =  @"订单完成";
//            self.OrderPayButton.hidden = NO;
//            [self.OrderPayButton setTitle:@"去评价" forState:UIControlStateNormal];
            break;
        case 5:
            self.statusPromptLabel.text =  @"订单取消";
            //            self.OrderPayButton.hidden = NO;
            //            [self.OrderPayButton setTitle:@"去评价" forState:UIControlStateNormal];
            break;
        case 6:
            self.statusPromptLabel.text =  @"订单未支付";
            break;
        case 7:
            self.statusPromptLabel.text =  @"退款中";
            break;
        default:
            break;
    }
}

@end
