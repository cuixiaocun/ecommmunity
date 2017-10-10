//
//  MallPayReViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//  商城支付结果

#import <UIKit/UIKit.h>
#import "OrderDetailsViewController.h"
@interface MallPayReViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *MallPayResultTableView;//物业缴费结果页面

@property (nonatomic,strong) NSArray *promptMallArray;
@property (nonatomic,strong) NSArray *dataMallArray;//支付结果

@property (nonatomic,strong) NSString *orderId;//订单id

@property (nonatomic,strong) UIButton *receivePButton;//收货人

@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UILabel *resultLabel;

@end
