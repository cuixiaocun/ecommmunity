//
//  MerchantsCommentModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MerchantsCommentModel.h"

@implementation MerchantsCommentModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    MerchantsCommentModel *model = [[MerchantsCommentModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
