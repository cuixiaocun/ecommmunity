//
//  ProPayModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProPayModel : NSObject

@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *costOneString;//费用
@property (nonatomic,strong) NSString *costTwoString;//费用
@property (nonatomic,strong) NSString *costThreeString;//费用
@property (nonatomic,strong) NSString *costFourString;//费用
@property (nonatomic,strong) NSString *stateString;//支付状态



+ (instancetype) bodyWithDict:(NSDictionary*)dict;
@end
