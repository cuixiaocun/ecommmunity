//
//  PeripheralSModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PeripheralSModel.h"

@implementation PeripheralSModel
+ (instancetype) bodyWithDict:(NSDictionary*)dict
{
    PeripheralSModel *model = [[PeripheralSModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
