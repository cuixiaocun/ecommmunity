//
//  MyComplaintsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的投诉

#import <UIKit/UIKit.h>
#import "MyComplantsTableViewCell.h"
@interface MyComplaintsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyCompTableView;//投诉列表

@property (nonatomic,strong) NSMutableArray *dataAllMCArray;//投诉总数据
@property (nonatomic,strong) NSMutableArray *dataModelMCArray;//投诉模型
@property (nonatomic,strong) NSMutableArray *dataHeightMCArray;//投诉高度
@property (nonatomic,strong) MyComplantsTableViewCell *myCell;

@property (nonatomic,assign) NSInteger currentCPage;//当前页数

@property (nonatomic, strong) UIImageView *MyComplaintsImage;//提示

@end
