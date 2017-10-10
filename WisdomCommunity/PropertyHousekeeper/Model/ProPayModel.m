//
//  ProPayModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ProPayModel.h"

@implementation ProPayModel
+ (instancetype) bodyWithDict:(NSDictionary*)dict
{
    ProPayModel *model = [[ProPayModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
