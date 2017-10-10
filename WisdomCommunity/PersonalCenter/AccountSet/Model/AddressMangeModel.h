//
//  AddressMangeModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//  收货地址

#import <Foundation/Foundation.h>

@interface AddressMangeModel : NSObject

@property (nonatomic,strong) NSString *nameString;//
@property (nonatomic,strong) NSString *phoneString;//
@property (nonatomic,strong) NSString *addressString;//
@property (nonatomic,strong) NSString *defaultString;//是否为默认
@property (nonatomic,strong) NSString *idString;//收货地址id

+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
