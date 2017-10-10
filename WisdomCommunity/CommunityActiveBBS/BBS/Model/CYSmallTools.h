//
//  CYStrTurnDynamic.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  字符串编辑，获取时间戳

#import <Foundation/Foundation.h>

@interface CYSmallTools : NSObject

#define IsNilString(__String)   (__String==nil || [__String isEqualToString:@"null"] || [__String isEqualToString:@"<null>"]||[__String isEqual:[NSNull null]]||[__String isEqualToString:@"(null)"]||[__String isEqualToString:@"null~null"])

+ (NSMutableAttributedString*) textEditing:(id)editing;

//获取时间戳
+ (NSString *) getTimeStamp;
//时间戳转标准时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//时间戳转标准时间:低精度
+ (NSString *)timeWithTimeIntervalTwoString:(NSString *)timeString;

//存取字典
+ (void) saveData:(NSDictionary *)dict withKey:(NSString *)key;
+ (NSDictionary *) getDataKey:(NSString *)key;

//字符串
+ (void) saveDataString:(NSString *)string withKey:(NSString *)key;
+ (NSString *) getDataStringKey:(NSString *)key;

//存数组
+ (void) saveArrData:(NSArray *)array withKey:(NSString *)key;

//去数组
+ (NSArray *) getArrData:(NSString *)key;

//是否登录出错
+ (BOOL) whetherLoginFails:(NSString *)error withResult:(NSString *)success;

//比较时间
+ (NSString *)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr;

//字典转JSON
+(NSString *)JsonModel:(NSDictionary *)dictModel;

//是否为纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string;

//是否为中文
+ (BOOL)isChineseFirst:(NSString *)firstStr;

//URL还是字符串
+ (BOOL)isValidUrl:(NSString *)string;

/**
 *  验证身份证号码是否正确的方法
 */
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;


@end
