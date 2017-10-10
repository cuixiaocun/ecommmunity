//
//  TakeOutModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "TakeOutModel.h"

@implementation TakeOutModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    TakeOutModel *model = [[TakeOutModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
