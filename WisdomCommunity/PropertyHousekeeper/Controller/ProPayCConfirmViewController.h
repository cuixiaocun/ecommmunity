//
//  ProPayCConfirmViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/10.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业缴费确认页面

#import <UIKit/UIKit.h>
#import "ProPayResultViewController.h"
@interface ProPayCConfirmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *ProPayConfirmTableView;//物业缴费确认页面
@property (nonatomic,strong) UITableView *selectPayTypeTableView;//支付方式

@property (nonatomic,strong) NSArray *proPayConArray;//物业缴费确认页面
@property (nonatomic,strong) NSDictionary *orderDetailsDict;//生成订单数据
@property (nonatomic,strong) UIButton *agreementPPCButton;

@property (nonatomic,strong) UIButton *ImmediatePaymentButton;//立即缴费
@property (nonatomic,strong) UIButton *detelBtn;//x按钮
@property (nonatomic,strong) UIImageView *shadowImage;//阴影效果

@property (nonatomic,strong) UIButton *selectPayTreasureButton;//支付宝
@property (nonatomic,strong) UIButton *selectWeChatButton;//微信

@property (nonatomic,strong) NSDictionary *chargeDict;//获取支付信息

@property (nonatomic,strong) UILabel *priceLabel;//价格label
@property (nonatomic,strong) UIButton *useIntegralButton;//使用积分

@property (nonatomic,strong) NSString *orderId;//支付id
@property (nonatomic,strong) NSString *orderType;//支付类型
@property (nonatomic,strong) ProPayResultViewController *ProPayController;

@end
