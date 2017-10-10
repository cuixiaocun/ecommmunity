//
//  ComAnnouncementViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区公告主页

#import <UIKit/UIKit.h>
#import "ComAnnoTableViewCell.h"
#import "AnnounDetailsViewController.h"
@interface ComAnnouncementViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *announcementTableView;//社区公告tableview

@property (nonatomic,strong) NSMutableArray *AnnouncementHeigthArray;//总高度
@property (nonatomic,strong) NSMutableArray *dataModelCAArray;//模型数据
@property (nonatomic,strong) NSMutableArray *dataAnnouncementArray;//社区公告数据


@property (nonatomic,assign) NSInteger currentComAnnPage;//当前请求页数
@property (nonatomic,assign) NSInteger recordComAnnPage;//记录请求过页数

@property (nonatomic,strong) ComAnnoTableViewCell *cellMessage;

@end
