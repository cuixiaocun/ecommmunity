//
//  OrderDetailsModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OrderDetailsModel.h"

@implementation OrderDetailsModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    OrderDetailsModel *model = [[OrderDetailsModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
