//
//  CYStrTurnDynamic.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CYSmallTools.h"

@implementation CYSmallTools

//文本编辑
+ (NSMutableAttributedString*) textEditing:(NSString *)editing
{
    NSLog(@"editing = %@",editing);
    //内容文本框
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;//对齐
    style.lineSpacing = 1;//行距
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:editing attributes:@{ NSParagraphStyleAttributeName : style}];
    return text;
}
//时间戳转标准时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    //创建NSDateFormatter对象
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //设置时区
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
    [dateformatter setTimeZone:timezone];

    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue] / 1000.0];
    NSString* dateString = [dateformatter stringFromDate:date];
    return dateString;
}
//时间戳转标准时间:低精度
+ (NSString *)timeWithTimeIntervalTwoString:(NSString *)timeString
{
    //创建NSDateFormatter对象
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    //设置时区
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
    [dateformatter setTimeZone:timezone];
    
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue] / 1000.0];
    NSString* dateString = [dateformatter stringFromDate:date];
    return dateString;
}
//获取时间戳
+ (NSString *) getTimeStamp
{
    //获取时间戳
    NSDate *nowDate = [NSDate date];
    //创建NSDateFormatter对象
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [dateformatter setDateFormat:@"MM-dd HH:mm:ss"];
    //设置时区
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
    [dateformatter setTimeZone:timezone];
    //stringFromDate:将日期对象格式化为字符串
    NSString *datestring = [dateformatter stringFromDate:nowDate];
    NSLog(@"datestring = %@",datestring);
    return datestring;
}
//存数组
+ (void) saveArrData:(NSArray *)array withKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    [saveDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:array] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//去数组
+ (NSArray *) getArrData:(NSString *)key
{
    NSUserDefaults *getDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [getDefaults objectForKey:key];
    NSArray *retrievedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return retrievedArray;
}
//存取字典数据
+ (void) saveData:(NSDictionary *)dict withKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    [saveDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:dict] forKey:key];
    [saveDefaults synchronize];
}
+ (NSDictionary *) getDataKey:(NSString *)key
{
    NSUserDefaults *getDefaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:[getDefaults objectForKey:_captureView.videoPathKey]];
    NSData *data = [getDefaults objectForKey:key];
    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return retrievedDictionary;
}
//
+ (void) saveDataString:(NSString *)string withKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    [saveDefaults setObject:string forKey:key];
}
+ (NSString *) getDataStringKey:(NSString *)key
{
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    return [saveDefaults objectForKey:key];
}

//是否登录出错
+ (BOOL) whetherLoginFails:(NSString *)error withResult:(NSString *)success
{
    if ([success integerValue] == 0 && ([error isEqualToString:@"未登录"] || [error isEqualToString:@"在别的设备登录"]))
    {
        return NO;
    }
    else
        return YES;
}
//比较时间
+ (NSString *)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-dd-MM"];
    NSComparisonResult result = [oneDayStr compare:anotherDayStr];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        //日期one大
        return @"1";
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        //日期one小
        return @"-1";
    }
    //NSLog(@"Both dates are the same");
    return @"0";
    
}
//字典转JSON
+(NSString *)JsonModel:(NSDictionary *)dictModel
{
    if ([NSJSONSerialization isValidJSONObject:dictModel])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictModel options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}
//是否为中文
+ (BOOL)isChineseFirst:(NSString *)firstStr
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}
//是否为纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
//URL还是字符串
+ (BOOL)isValidUrl:(NSString *)string
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isVALID = [urlTest evaluateWithObject:string];
    return isVALID;//[urlTest evaluateWithObject:self];
}

/**
 *  验证身份证号码是否正确的方法
 *
 *  @param identityString 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
@end
