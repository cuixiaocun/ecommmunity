//
//  ComAnnoModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区公告

#import <Foundation/Foundation.h>

@interface ComAnnoModel : NSObject

@property (nonatomic,strong) NSString *comAnnImageString;//头像
@property (nonatomic,strong) NSString *comAnnString;//内容
@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *comAnnStringDetail;//具体内容

+ (instancetype) bodyWithDict:(NSDictionary *)dict;


@end
