//
//  ComAnnoModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComAnnoModel.h"

@implementation ComAnnoModel
+ (instancetype) bodyWithDict:(NSDictionary*)dict
{
    ComAnnoModel *model = [[ComAnnoModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
