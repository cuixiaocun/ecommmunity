//
//  MessagePModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  消息列表

#import <Foundation/Foundation.h>

@interface MessagePModel : NSObject

@property (nonatomic,strong) NSString *messageImageString;//头像
@property (nonatomic,strong) NSString *messageString;//内容
@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *type;//类型
@property (nonatomic,strong) NSString *messageId;//id


+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
