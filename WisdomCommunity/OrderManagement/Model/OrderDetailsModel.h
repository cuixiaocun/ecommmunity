//
//  OrderDetailsModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailsModel : NSObject
@property (nonatomic,strong) NSString *goodsNameString;//
@property (nonatomic,strong) NSString *goodsMoneyString;
@property (nonatomic,strong) NSString *goodsNumberString;

+ (instancetype) bodyWithDict:(NSDictionary *)dict;
@end
