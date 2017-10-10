//
//  ActivityDetailsModel.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/29.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailsModel : NSObject

@property (nonatomic, strong) NSString     *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString     *praiseCount;
@property (nonatomic, strong) NSDictionary *accountDO;
@property (nonatomic, strong) NSString     *content;
@property (nonatomic, strong) NSString     *playCount;
@property (nonatomic, strong) NSString     *gmtCreate;
@property (nonatomic, strong) NSString     *imgAddress;
@property (nonatomic, strong) NSString     *title;
@property (nonatomic, strong) NSString     *gmtModify;
@property (nonatomic, strong) NSString     *address;
@property (nonatomic, strong) NSString     *viewCount;
@property (nonatomic, strong) NSString     *acTime;
@property (nonatomic, strong) NSString     *comNo;
@property (nonatomic, strong) NSString     *account;
@property (nonatomic, strong) NSString     *replyCount;
@property (nonatomic, strong) NSString     *communityName;
@property (nonatomic, strong) NSString     *flag;
@property (nonatomic, strong) NSString     *viewAccountJoinStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;


@end
