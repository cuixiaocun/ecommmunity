//
//  BBSRootViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  论坛主页

#import <UIKit/UIKit.h>
#import "comBBSTableViewCell.h"
#import "PostDetailsViewController.h"
#import "SendPostViewController.h"
#import "NNSRootModelData.h"
@interface BBSRootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *BBSRootTableView;//帖子首页tableview

@property (nonatomic,strong) NSMutableArray *BBSRootAllarray;//总数据
@property (nonatomic,strong) NSMutableArray *modelBBSRootarray;//数据模型
@property (nonatomic,strong) NSMutableArray *BBSHeightArray;//高度集合
@property (nonatomic,strong) UIImageView *postingImmage;

@property (nonatomic,strong) comBBSTableViewCell *cell;

@property (nonatomic,assign) NSInteger BBSRecordInt;//请求页数记录
@property (nonatomic,strong) NSArray *ClickCellData;//点击cell数据

@property (nonatomic, strong) UIImageView *BBSRootPromptImage;//提示


@end
