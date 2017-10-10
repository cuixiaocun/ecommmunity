//
//  OrderMModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单主页模型

#import <Foundation/Foundation.h>

@interface OrderMModel : NSObject

@property (nonatomic,strong) NSString *orderIdString;//订单号
@property (nonatomic,strong) NSString *headImageString;//头像
@property (nonatomic,strong) NSString *nameString;//商家名
@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *moneyString;//价格
@property (nonatomic,strong) NSString *satateString;//订单状态 1.支付成功 2.商家接单 3.商家拒单 4.已送达 5.用户取消

+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
