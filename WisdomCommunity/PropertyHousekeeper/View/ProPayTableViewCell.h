//
//  ProPayTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业缴费

#import <UIKit/UIKit.h>
#import "ProPayModel.h"
//协议
@protocol OnClickProPayDelegate <NSObject>
- (void) addComputingMoney:(ProPayModel *)model;//计算缴费金额 +
- (void) remComputingMoney:(ProPayModel *)model;//计算缴费金额 -
@end
@interface ProPayTableViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;

@property (nonatomic,strong) UIButton *AgreementButton;
@property (nonatomic,weak) UILabel *alreadyPay;//已支付
@property (nonatomic,strong) UIButton *promptBtn;
@property (nonatomic,weak) UILabel *labelOne;
@property (nonatomic,weak) UILabel *labelTwo;
@property (nonatomic,weak) UILabel *labelThree;
@property (nonatomic,weak) UILabel *labelFour;

@property (nonatomic,assign) BOOL whetherSelectBool;//是否选中的标志
@property (nonatomic,weak) id<OnClickProPayDelegate> delegate;//协议

@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong) ProPayModel *model;


@end
