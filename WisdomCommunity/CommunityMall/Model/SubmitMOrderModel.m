//
//  SubmitMOrderModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SubmitMOrderModel.h"

@implementation SubmitMOrderModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    SubmitMOrderModel *model = [[SubmitMOrderModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
