//
//  MyComplaintsModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的投诉

#import <Foundation/Foundation.h>

@interface MyComplaintsModel : NSObject

@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *promptImageString;//图片
@property (nonatomic,strong) NSString *promptString;//描述
@property (nonatomic,strong) NSString *resultString;//状态
@property (nonatomic,strong) NSString *nameString;//姓名
@property (nonatomic,strong) NSString *phoneString;//电话
@property (nonatomic,strong) NSString *addString;//地址
@property (nonatomic,strong) NSString *category;//地址

+ (instancetype) bodyWithDict:(NSDictionary*)dict;
@end
