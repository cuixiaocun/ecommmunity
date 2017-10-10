//
//  SubmitMOrderModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单结算

#import <Foundation/Foundation.h>

@interface SubmitMOrderModel : NSObject

@property (nonatomic,strong) NSString *goodsNameString;//
@property (nonatomic,strong) NSString *goodsMoneyString;
@property (nonatomic,strong) NSString *goodsNumberString;

+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
