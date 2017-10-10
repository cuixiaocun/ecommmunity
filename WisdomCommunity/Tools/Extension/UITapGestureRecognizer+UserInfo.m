//
//  UITapGestureRecognizer+UserInfo.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "UITapGestureRecognizer+UserInfo.h"
#import <objc/runtime.h>
static void *userinfoKey = &userinfoKey;
@implementation UITapGestureRecognizer (UserInfo)

- (void)setUserinfo:(NSMutableDictionary *)userinfo
{
    objc_setAssociatedObject(self, &userinfoKey, userinfo, OBJC_ASSOCIATION_COPY);
}

- (NSMutableDictionary *)userinfo
{
    return objc_getAssociatedObject(self, &userinfoKey);
}

@end
