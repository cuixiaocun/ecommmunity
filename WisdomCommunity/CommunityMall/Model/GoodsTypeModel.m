
//
//  GoodsTypeModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "GoodsTypeModel.h"

@implementation GoodsTypeModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    GoodsTypeModel *model = [[GoodsTypeModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
