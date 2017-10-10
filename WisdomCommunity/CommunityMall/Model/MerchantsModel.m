//
//  MerchantsModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MerchantsModel.h"

@implementation MerchantsModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    MerchantsModel *model = [[MerchantsModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
