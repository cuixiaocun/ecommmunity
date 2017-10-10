//
//  ActivityRootModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityRootModel.h"
NSString *const kReturnValueId = @"id";
NSString *const kReturnValuePraiseCount = @"praiseCount";
NSString *const kReturnValueAccountDO = @"accountDO";
NSString *const kReturnValueCommunityName = @"communityName";
NSString *const kReturnValuePlayCount = @"playCount";
NSString *const kReturnValueGmtCreate = @"gmtCreate";
NSString *const kReturnValueImgAddress = @"imgAddress";
NSString *const kReturnValueGmtModify = @"gmtModify";
NSString *const kReturnValueAddress = @"address";
NSString *const kReturnValueViewCount = @"viewCount";
NSString *const kReturnValueAcTime = @"acTime";
NSString *const kReturnValueComNo = @"comNo";
NSString *const kReturnValueAccount = @"account";
NSString *const kReturnValueReplyCount = @"replyCount";
NSString *const kReturnValueContent = @"content";
NSString *const kReturnValueTitle = @"title";
NSString *const kReturnValueFlag = @"flag";


@implementation ActivityRootModel


- (NSString *)returnStateString:(NSString *)acTime
{
    if (acTime == nil) {
        return nil;
    }
    NSArray *actimeArray = [acTime componentsSeparatedByString:@"~"];
    NSString *starTimer = [actimeArray firstObject];
    NSString *endTimer = [actimeArray lastObject];
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    NSLog(@"当前时间%@,",dateStr);
//    if ([[self compareOneDay:dateStr withAnotherDay:starTimer] isEqualToString:@"1"]) {
        if ([[self compareOneDay:dateStr withAnotherDay:endTimer] isEqualToString:@"1"]) {
            //活动已经结束
            return @"end";
        }else{
            //活动正在进行
            return @"start";
        }
//    }else{
//        //活动尚未开始
//        return @"Not";
//    }
}

- (NSString *)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    if (IsNilString(anotherDayStr)) {
        return @"1";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-dd-MM"];
    
    NSComparisonResult result = [oneDayStr compare:anotherDayStr];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        //日期one比今天小
        return @"1";
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        //日期one小比今天大
        return @"-1";
    }else
    {
        return @"-1";

    
    }
    //NSLog(@"Both dates are the same");
    return @"0";
    
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.activityID    = [self objectOrNilForKey:kReturnValueId            fromDictionary:dict];
        self.praiseCount   = [self objectOrNilForKey:kReturnValuePraiseCount   fromDictionary:dict];
        self.accountDO     = [self objectOrNilForKey:kReturnValueAccountDO     fromDictionary:dict];
        self.communityName = [self objectOrNilForKey:kReturnValueCommunityName fromDictionary:dict];
        self.playCount     = [self objectOrNilForKey:kReturnValuePlayCount     fromDictionary:dict];
        self.gmtCreate     = [self objectOrNilForKey:kReturnValueGmtCreate     fromDictionary:dict];
        self.imgAddress    = [self objectOrNilForKey:kReturnValueImgAddress    fromDictionary:dict];
        self.gmtModify     = [self objectOrNilForKey:kReturnValueGmtModify     fromDictionary:dict];
        self.address       = [self objectOrNilForKey:kReturnValueAddress       fromDictionary:dict];
        self.viewCount     = [self objectOrNilForKey:kReturnValueViewCount     fromDictionary:dict];
        self.acTime        = [self objectOrNilForKey:kReturnValueAcTime        fromDictionary:dict];
        self.comNo         = [self objectOrNilForKey:kReturnValueComNo         fromDictionary:dict];
        self.account       = [self objectOrNilForKey:kReturnValueAccount       fromDictionary:dict];
        self.replyCount    = [self objectOrNilForKey:kReturnValueReplyCount    fromDictionary:dict];
        self.content       = [self objectOrNilForKey:kReturnValueContent       fromDictionary:dict];
        self.title         = [self objectOrNilForKey:kReturnValueTitle         fromDictionary:dict];
        self.flag          = [self objectOrNilForKey:kReturnValueFlag         fromDictionary:dict];
        self.stateString   = [self returnStateString:self.acTime];
    }
    return self;
}


+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
