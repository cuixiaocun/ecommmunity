//
//  SingletonTeacher.m
//  cy8.1am
//
//  Created by 504－29 on 15/8/3.
//  Copyright (c) 2015年 504－29. All rights reserved.
//

#import "Singleton.h"

//1 全局实例，初始化为nil
static Singleton *sharedSingleton;

@implementation Singleton

//2 实现方法,返回单一一个对象
+(Singleton *)getSingleton
{
    if (sharedSingleton == nil) {
        //不存在就创建一个
        sharedSingleton = [[Singleton alloc] init];
    }
    //存在则返回
    return sharedSingleton;
}

//3 为了防止通过alloc或者new创建新的实例，需要重写allocWithZone方法
+(id)allocWithZone:(struct _NSZone *)zone
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[super allocWithZone:zone] init];
    }
    
    return sharedSingleton;
}

//4 为了防止copy创建新的实例，重写
-(id)copyWithZone:(struct _NSZone *)zone
{
    return self;
}

//5 重写，防止被dealloc，此方法中返回NSInteger的最大值,不重写的话，则retainCount的值始终为 1
-(NSUInteger)retainCount
{
    return NSIntegerMax;
}

//6 重写retain，release，autorelease方法，因为单例不释放，所以引用计数变化没有意义。
-(id)retain
{
    return self;
}

-(oneway void)release
{
    
}

-(id)autorelease
{
    return self;
}











@end
