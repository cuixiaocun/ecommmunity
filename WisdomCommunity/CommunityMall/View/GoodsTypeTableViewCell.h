//
//  GoodsTypeTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  商品分类

#import <UIKit/UIKit.h>
#import "GoodsTypeModel.h"
@interface GoodsTypeTableViewCell : UITableViewCell

@property (nonatomic,weak) UILabel *promptLabel;
@property (nonatomic,weak) UIButton *selectButton;

@property (nonatomic,strong) GoodsTypeModel *model;

@end
