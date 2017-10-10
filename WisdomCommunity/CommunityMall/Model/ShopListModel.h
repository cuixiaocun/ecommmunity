//
//  ShopListModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  购物车订单列表

#import <Foundation/Foundation.h>

@interface ShopListModel : NSObject


@property (nonatomic,strong) NSString *goodsNameString;//
@property (nonatomic,strong) NSString *goodsMoneyString;
@property (nonatomic,strong) NSString *goodsNumberString;

+ (instancetype) bodyWithDict:(NSDictionary *)dict;



@end
