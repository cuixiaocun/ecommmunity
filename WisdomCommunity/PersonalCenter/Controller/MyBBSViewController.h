//
//  MyBBSViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的帖子

#import <UIKit/UIKit.h>
#import "comBBSTableViewCell.h"
#import "PostDetailsViewController.h"
#import "NNSRootModelData.h"
@interface MyBBSViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyBBSTableView;//我的帖子tableview

@property (nonatomic,strong) NSMutableArray *myBBSAllarray;//总数据
@property (nonatomic,strong) NSMutableArray *modelBBSMyArray;//数据模型
@property (nonatomic,strong) NSMutableArray *MyBBSHeightArray;//高度数组

@property (nonatomic,assign) NSInteger currentMBBSPage;//当前页数


@property (nonatomic,strong) NSArray *ClickMyCellData;//点击cell数据

@property (nonatomic,strong) comBBSTableViewCell *cell;

@property (nonatomic, strong) UIImageView *MyBBSImage;//提示

@end
