//
//  AnnounDetailsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/23.
//  Copyright © 2016年 bridge. All rights reserved.
//  公告详情页

#import <UIKit/UIKit.h>

@interface AnnounDetailsViewController : UIViewController

@property (nonatomic,strong) NSDictionary *detailsDict;//详情数据
@property (nonatomic,strong) NSString *detailsId;//详情id

@property (nonatomic,strong) NSString *whetherJPushInput;//推送列表进入

@end
