//
//  PeripheralSModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  周边服务

#import <Foundation/Foundation.h>

@interface PeripheralSModel : NSObject

@property (nonatomic,strong) NSString *perSerHeadString;//头像
@property (nonatomic,strong) NSString *perNameString;//名字
@property (nonatomic,strong) NSString *perStartString;//评价
@property (nonatomic,strong) NSString *perNumberString;//销售量
@property (nonatomic,strong) NSString *perAddressString;//地址
@property (nonatomic,strong) NSString *perPhooneString;//电话
@property (nonatomic,strong) NSString *perIdString;//id

+ (instancetype) bodyWithDict:(NSDictionary*)dict;
@end
