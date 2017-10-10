//
//  MyRepairViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的报修

#import <UIKit/UIKit.h>
#import "MyComplantsTableViewCell.h"
@interface MyRepairViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *MyRepairTableView;//报修列表

@property (nonatomic,strong) NSMutableArray *dataAllMRArray;//报修总数据
@property (nonatomic,strong) NSMutableArray *dataModelMRArray;//报修模型
@property (nonatomic,strong) NSMutableArray *dataHeightMCArray;//报修高度

@property (nonatomic,strong) MyComplantsTableViewCell *myCell;

@property (nonatomic,assign) NSInteger currentRePage;//当前页数

@property (nonatomic, strong) UIImageView *MyRepairImage;//提示

@end
