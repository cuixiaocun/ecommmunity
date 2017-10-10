//
//  MerchantsModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  商家详情页模型

#import <Foundation/Foundation.h>

@interface MerchantsModel : NSObject

@property (nonatomic,strong) NSString *currentSection;//所在组
@property (nonatomic,strong) NSString *numberString;//成功销售
@property (nonatomic,strong) NSString *goodsImage;//商品图片
@property (nonatomic,strong) NSString *nameString;//商品名
@property (nonatomic,strong) NSString *contentString;//商品描述
@property (nonatomic,strong) NSString *moneyString;//商品单价
@property (nonatomic,strong) NSString *goodsId;//商品id

+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
