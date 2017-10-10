//
//  PayCenterViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  支付中心 页面

#import <UIKit/UIKit.h>
#import "MallPayReViewController.h"
@interface PayCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong) UITableView *PayCenterTypeTableView;//支付方式
@property (nonatomic,strong) UIButton *PayTreasureButton;//支付宝
@property (nonatomic,strong) UIButton *WeChatButton;//微信
@property (nonatomic,strong) NSString *orderMallType;//支付类型
@property (nonatomic,strong) NSString *orderMallId;//订单id
@property (nonatomic,strong) NSString *whetherUseScore;//是否使用积分
@property (nonatomic,strong) NSDictionary *chargeMallDict;//支付产生data

@property (nonatomic,strong) NSString *payMoney;//支付金额


@property (nonatomic,strong) MallPayReViewController *TOController;

@end
