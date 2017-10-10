//
//  SelectSexViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  选择性别

#import <UIKit/UIKit.h>

@interface SelectSexViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSString *selectSexString;
@property (nonatomic,strong) NSString *sexString;//初始性别

@end
