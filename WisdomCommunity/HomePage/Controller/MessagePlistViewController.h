//
//  MessagePlistViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  消息列表

#import <UIKit/UIKit.h>
#import "MessagePTableViewCell.h"
#import "ActivityDetailsViewController.h"
#import "AnnounDetailsViewController.h"
#import "OrderDetailsViewController.h"
@interface MessagePlistViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *messagePTableView;//消息列表tableview


@property (nonatomic,strong) NSMutableArray *dataModelMPArray;//模型数据
@property (nonatomic,strong) NSMutableArray *dataMessagePArray;//消息数据
@property (nonatomic,assign) BOOL isJPushInput;//是不是推送


@property (nonatomic,strong) MessagePTableViewCell *cellMessage;

@end
