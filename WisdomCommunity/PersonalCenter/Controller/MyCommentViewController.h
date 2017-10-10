//
//  MyCommentViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的评论

#import <UIKit/UIKit.h>
#import "MyConmentTableViewCell.h"
#import "ActivityRootModel.h"
#import "ActivityDetailsViewController.h"
@interface MyCommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyCommentTableView;//我的评论tableview

@property (nonatomic,strong) NSMutableArray *myCommentModelArray;//模型
@property (nonatomic,strong) NSMutableArray *myCommentAllArray;


@property (nonatomic,strong) MyConmentTableViewCell *myCCell;
@property (nonatomic,assign) NSInteger currentMCPage;//当前页

@property (nonatomic,strong) NSMutableArray *IDArray;//为详情页准备

@property (nonatomic, strong) UIImageView *MyCommentImage;//提示

@end
