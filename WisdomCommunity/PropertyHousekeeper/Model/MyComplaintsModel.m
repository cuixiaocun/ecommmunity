//
//  MyComplaintsModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyComplaintsModel.h"

@implementation MyComplaintsModel
+ (instancetype) bodyWithDict:(NSDictionary*)dict
{
    MyComplaintsModel *model = [[MyComplaintsModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
