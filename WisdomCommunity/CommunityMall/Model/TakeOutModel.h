//
//  TakeOutModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  外卖-超市等

#import <Foundation/Foundation.h>

@interface TakeOutModel : NSObject


@property (nonatomic,strong) NSString *headString;//头像
@property (nonatomic,strong) NSString *nameString;//商家名
@property (nonatomic,strong) NSString *startTOString;//评价
@property (nonatomic,strong) NSString *numberString;//销量
@property (nonatomic,strong) NSString *sendPriceString;//起送价
@property (nonatomic,strong) NSString *shippingFeeString;//配送费
@property (nonatomic,strong) NSString *onlineString;//活动
@property (nonatomic,strong) NSString *isManJian;//满减 0:没有  1:处理
@property (nonatomic,strong) NSString *isNUJianMian;//新用户 0:没有  1:处理
@property (nonatomic,strong) NSString *merchantsId;//商家id


+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
