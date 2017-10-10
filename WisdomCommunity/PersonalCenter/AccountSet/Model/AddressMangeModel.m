//
//  AddressMangeModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AddressMangeModel.h"

@implementation AddressMangeModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    AddressMangeModel *model = [[AddressMangeModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
