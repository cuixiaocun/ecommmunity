//
//  LifeServiceModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  生活服务

#import <Foundation/Foundation.h>

@interface LifeServiceModel : NSObject

@property (nonatomic,strong) NSString *lifeHeadString;//头像
@property (nonatomic,strong) NSString *lifeNameString;//名字
@property (nonatomic,strong) NSString *lifeStartString;//评价
@property (nonatomic,strong) NSString *lifeNumberString;//销售量
@property (nonatomic,strong) NSString *lifeAddressString;//地址
@property (nonatomic,strong) NSString *lifePhooneString;//电话
@property (nonatomic,strong) NSString *lifeIdString;//id

+ (instancetype) bodyWithDict:(NSDictionary*)dict;
@end
