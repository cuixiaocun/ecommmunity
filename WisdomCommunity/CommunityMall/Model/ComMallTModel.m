//
//  ComMallTModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ComMallTModel.h"

@implementation ComMallTModel
+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    ComMallTModel *model = [[ComMallTModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
