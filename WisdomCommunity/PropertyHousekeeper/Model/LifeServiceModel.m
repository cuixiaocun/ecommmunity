//
//  LifeServiceModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "LifeServiceModel.h"

@implementation LifeServiceModel
+ (instancetype) bodyWithDict:(NSDictionary*)dict
{
    LifeServiceModel *model = [[LifeServiceModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
