//
//  ActivityRootModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//  活动首页model

#import <Foundation/Foundation.h>

@interface ActivityRootModel : NSObject

@property (nonatomic, strong) NSString     *imgAddress;
@property (nonatomic, strong) NSString     *stateString;
@property (nonatomic, strong) NSDictionary *accountDO;
@property (nonatomic, strong) NSString     *communityName;
@property (nonatomic, strong) NSString     *playCount;
@property (nonatomic, strong) NSString     *acTime;//活动日期
@property (nonatomic, strong) NSString     *account;//发起人手机号
@property (nonatomic, strong) NSString     *activityID;//活动id
@property (nonatomic, strong) NSString     *address;//活动地址
@property (nonatomic, strong) NSString     *gmtCreate;//活动发起时间
@property (nonatomic, strong) NSString     *praiseCount;
@property (nonatomic, strong) NSString     *gmtModify;
@property (nonatomic, strong) NSString     *viewCount;
@property (nonatomic, strong) NSString     *comNo;
@property (nonatomic, strong) NSString     *replyCount;
@property (nonatomic, strong) NSString     *content;
@property (nonatomic, strong) NSString     *title;
@property (nonatomic, strong) NSString     *flag;

+ (instancetype) bodyWithDict:(NSDictionary *)dict;



@end
