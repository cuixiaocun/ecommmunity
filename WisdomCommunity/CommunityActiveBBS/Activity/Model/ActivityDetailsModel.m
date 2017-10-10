//
//  ActivityDetailsModel.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/29.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityDetailsModel.h"

NSString *const kBaseClassId = @"id";
NSString *const kBaseClassPraiseCount   = @"praiseCount";
NSString *const kBaseClassAccountDO     = @"accountDO";
NSString *const kBaseClassContent       = @"content";
NSString *const kBaseClassPlayCount     = @"playCount";
NSString *const kBaseClassGmtCreate     = @"gmtCreate";
NSString *const kBaseClassImgAddress    = @"imgAddress";
NSString *const kBaseClassTitle         = @"title";
NSString *const kBaseClassGmtModify     = @"gmtModify";
NSString *const kBaseClassAddress       = @"address";
NSString *const kBaseClassViewCount     = @"viewCount";
NSString *const kBaseClassAcTime        = @"acTime";
NSString *const kBaseClassComNo         = @"comNo";
NSString *const kBaseClassAccount       = @"account";
NSString *const kBaseClassReplyCount    = @"replyCount";
NSString *const kBaseClassCommunityName = @"communityName";
NSString *const kBaseClassFlag          = @"flag";
NSString *const kBaseClassViewAccountJoinStatus       = @"viewAccountJoinStatus";

@implementation ActivityDetailsModel
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.internalBaseClassIdentifier = [self objectOrNilForKey:kBaseClassId            fromDictionary:dict];
        self.praiseCount                 = [self objectOrNilForKey:kBaseClassPraiseCount   fromDictionary:dict];
        self.accountDO                   = [self objectOrNilForKey:kBaseClassAccountDO     fromDictionary:dict];
        self.content                     = [self objectOrNilForKey:kBaseClassContent       fromDictionary:dict];
        self.playCount                   = [self objectOrNilForKey:kBaseClassPlayCount     fromDictionary:dict];
        self.gmtCreate                   = [self objectOrNilForKey:kBaseClassGmtCreate     fromDictionary:dict];
        self.imgAddress                  = [self objectOrNilForKey:kBaseClassImgAddress    fromDictionary:dict];
        self.title                       = [self objectOrNilForKey:kBaseClassTitle         fromDictionary:dict];
        self.gmtModify                   = [self objectOrNilForKey:kBaseClassGmtModify     fromDictionary:dict];
        self.address                     = [self objectOrNilForKey:kBaseClassAddress       fromDictionary:dict];
        self.viewCount                   = [self objectOrNilForKey:kBaseClassViewCount     fromDictionary:dict];
        self.acTime                      = [self objectOrNilForKey:kBaseClassAcTime        fromDictionary:dict];
        self.comNo                       = [self objectOrNilForKey:kBaseClassComNo         fromDictionary:dict];
        self.account                     = [self objectOrNilForKey:kBaseClassAccount       fromDictionary:dict];
        self.replyCount                  = [self objectOrNilForKey:kBaseClassReplyCount    fromDictionary:dict];
        self.communityName               = [self objectOrNilForKey:kBaseClassCommunityName fromDictionary:dict];
        self.flag                        = [self objectOrNilForKey:kBaseClassFlag          fromDictionary:dict];
         self.viewAccountJoinStatus                        = [self objectOrNilForKey:kBaseClassViewAccountJoinStatus          fromDictionary:dict];
        
        
    }
    return self;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
