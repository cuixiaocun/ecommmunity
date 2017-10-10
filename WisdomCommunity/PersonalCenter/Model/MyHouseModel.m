//
//  MyHouseModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyHouseModel.h"

@implementation MyHouseModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    MyHouseModel *model = [[MyHouseModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
