//
//  ComMallTModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区商城首页展示tableviewcell模型

#import <Foundation/Foundation.h>

@interface ComMallTModel : NSObject

@property (nonatomic,strong) NSString *goodsPictureString;//商品图片
@property (nonatomic,strong) NSString *goodsNameString;//商品名字
@property (nonatomic,strong) NSString *goodsPromptString;//商品介绍
@property (nonatomic,strong) NSString *goodsPriceString;//商品价格
@property (nonatomic,strong) NSString *goodsSellNumberString;//商品销售数量
+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
