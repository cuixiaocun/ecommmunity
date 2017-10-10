//
//  MyThumbUpViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的点赞

#import <UIKit/UIKit.h>
#import "MyThumbUpTableViewCell.h"
@interface MyThumbUpViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyThumbUpTableView;//我的评论tableview

@property (nonatomic,strong) NSMutableArray *myThumbUpModelArray;//模型
@property (nonatomic,strong) NSMutableArray *myThumbUpAllArray;


@property (nonatomic,strong) MyThumbUpTableViewCell *myTUCell;

@end
