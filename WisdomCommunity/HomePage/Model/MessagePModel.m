//
//  MessagePModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MessagePModel.h"

@implementation MessagePModel

+ (instancetype) bodyWithDict:(NSDictionary*)dict
{
    MessagePModel *model = [[MessagePModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
