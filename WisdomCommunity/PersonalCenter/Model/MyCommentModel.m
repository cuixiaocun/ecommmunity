//
//  MyCommentModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyCommentModel.h"

@implementation MyCommentModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    MyCommentModel *model = [[MyCommentModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
