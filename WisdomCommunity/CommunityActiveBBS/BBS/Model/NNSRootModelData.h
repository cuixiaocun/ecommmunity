//
//  NNSRootModelData.h
//  WisdomCommunity
//
//  Created by bridge on 17/1/14.
//  Copyright © 2017年 bridge. All rights reserved.
//  帖子cell数据处理

#import <Foundation/Foundation.h>
#import "comBBSModel.h"
@interface NNSRootModelData : NSObject

+ (NSDictionary *) delaWithPostData:(NSDictionary *)postDict;
//初始化数据
+ (NSArray *) initBBSRootModel:(NSArray *)array;
@end
