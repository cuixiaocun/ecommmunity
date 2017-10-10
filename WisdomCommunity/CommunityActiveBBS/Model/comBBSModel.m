//
//  comBBSModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "comBBSModel.h"

@implementation comBBSModel
+ (instancetype) bodyWithDict:(NSMutableDictionary *)dict
{
    comBBSModel *model = [[comBBSModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
