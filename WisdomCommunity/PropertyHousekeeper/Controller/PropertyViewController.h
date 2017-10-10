//
//  PropertyViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业管家首页

#import <UIKit/UIKit.h>
#import "PropertyCVCView.h"
#import "ComplaintsSuggestionsViewController.h"//投诉建议
#import "PropertyRepairViewController.h"//物业报修
#import "PeripheralServicesViewController.h"//周边服务
#import "LifeServiceViewController.h"//生活服务
#import "ProPaycostViewController.h"
#import "MyHousPlistViewController.h"//我的房屋列表

@interface PropertyViewController : UIViewController<OnClickPCVDelegate>

@property (nonatomic,strong) PropertyCVCView *propertyView;

@end
