//
//  MercahntsPageDataDealW.h
//  WisdomCommunity
//
//  Created by bridge on 17/1/14.
//  Copyright © 2017年 bridge. All rights reserved.
//  商家页面数据处理文件

#import <Foundation/Foundation.h>
#import "MerchantsCommentModel.h"
#import "GoodsTypeModel.h"
#import "MerchantsModel.h"
@interface MercahntsPageDataDealW : NSObject

//评论数据
+ (NSArray *) initCommentModel:(NSArray *)array;

//产品数据
+ (NSArray *) initMerchantsModel:(NSArray *)array;

@end
