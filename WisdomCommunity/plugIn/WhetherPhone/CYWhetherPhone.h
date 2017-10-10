//
//  WhetherPhone.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYWhetherPhone : NSObject

+ (BOOL)isValidPhone:(NSString *)phone;
+ (BOOL) judgePassword:(NSString *)pwdStr;
@end
