//
//  RootTBmodel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RootTBmodel.h"

@implementation RootTBmodel


+ (instancetype) bodyWithDict:(NSMutableDictionary *)dict
{
    RootTBmodel *model = [[RootTBmodel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
