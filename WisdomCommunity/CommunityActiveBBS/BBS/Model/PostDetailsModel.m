//
//  PostDetailsModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PostDetailsModel.h"

@implementation PostDetailsModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    PostDetailsModel *model = [[PostDetailsModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
