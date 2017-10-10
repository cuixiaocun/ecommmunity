//
//  OrderMModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderMModel.h"

@implementation OrderMModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    OrderMModel *model = [[OrderMModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
