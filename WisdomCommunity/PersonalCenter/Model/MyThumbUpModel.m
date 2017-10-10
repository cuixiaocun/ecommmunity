//
//  MyThumbUpModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MyThumbUpModel.h"

@implementation MyThumbUpModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    MyThumbUpModel *model = [[MyThumbUpModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
