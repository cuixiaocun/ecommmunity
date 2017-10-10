//
//  ShopListModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ShopListModel.h"

@implementation ShopListModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    ShopListModel *model = [[ShopListModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
