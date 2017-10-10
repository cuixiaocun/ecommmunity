//
//  SeeSignInRecordViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  查看签到记录

#import <UIKit/UIKit.h>
#import "CYSignInRecord.h"
@interface SeeSignInRecordViewController : UIViewController

@property (nonatomic,strong) CYSignInRecord *dataView;

@property (nonatomic,strong) NSMutableArray *SignInArray;//总的签到数组

@property (nonatomic,strong) NSDate *UserDate;//使用的时间

@end
