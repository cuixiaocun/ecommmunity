//
//  GoodsTypeModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  商品分类

#import <Foundation/Foundation.h>

@interface GoodsTypeModel : NSObject

@property (nonatomic,strong) NSString *promptString;//
@property (nonatomic,strong) NSString *currentSectionNumber;//所在组
@property (nonatomic,strong) NSString *selectGoodsNumber;//选择商品数量


+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
