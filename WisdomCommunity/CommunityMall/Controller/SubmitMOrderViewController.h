//
//  SubmitMOrderViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  确认商品订单

#import <UIKit/UIKit.h>
#import "SubmitMOrderTableViewCell.h"
#import "PayCenterViewController.h"
#import "MerchantsModel.h"
#import "AddressManagementViewController.h"//选择收货地址
#import "AddressEditViewController.h"//添加收货地址
@interface SubmitMOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,strong) UITableView *confirmOTableView;//

@property (nonatomic,strong) UIButton *receiveButton;
@property (nonatomic,strong) UILabel *phoneLabel;//手机号
@property (nonatomic,strong) UIButton *locationButton;//地址

@property (nonatomic,strong) UIButton *SelectButton;//是否使用积分
@property (nonatomic,weak)   UILabel *selectPriceLabel;//选择商品总价格

@property (nonatomic,strong) NSMutableArray *submitModelArray;//商品数据


@property (nonatomic,strong) NSDictionary *receiveDict;//收货地址
@property (nonatomic,strong) NSDictionary *OrderDict;//生成订单数据
@property (nonatomic,strong) NSDictionary *MerchantsDict;//商家订单数据
@property (nonatomic,strong) NSString *SelectGoodsMoney;//选择商品总价


@property (nonatomic,strong) NSArray *receiveGoodsAddress;//收货地址数组

@property (nonatomic,strong) SubmitMOrderTableViewCell *cell;
@property (nonatomic,strong) AddressManagementViewController *AddressManController;//收货地址选择
@property (nonatomic,strong) PayCenterViewController *PayCController;//支付页面

@end
