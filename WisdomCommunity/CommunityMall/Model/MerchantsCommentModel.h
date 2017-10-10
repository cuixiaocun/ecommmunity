//
//  MerchantsCommentModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  商家评论

#import <Foundation/Foundation.h>

@interface MerchantsCommentModel : NSObject


@property (nonatomic,strong) NSString *headString;//
@property (nonatomic,strong) NSString *nameString;//
@property (nonatomic,strong) NSString *startString;//
@property (nonatomic,strong) NSString *timeString;//
@property (nonatomic,strong) NSString *contentString;//


+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
