//
//  ShopListTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  购物车列表

#import <UIKit/UIKit.h>
#import "MerchantsModel.h"

@class MerchantsModel, ShopListTableViewCell;
@protocol DetailListCellDelegate <NSObject>
@optional
- (void)valueChangedCallbackButtonClicked:(ShopListTableViewCell *)cell;
- (void)uploadLoadButtonClicked:(ShopListTableViewCell *)cell;
@end


@interface ShopListTableViewCell : UITableViewCell

//加减按钮
@property (nonatomic,strong) PKYStepper *hideButtonStepper;
@property (nonatomic,weak) UILabel *moneyLabel;//
@property (nonatomic,weak) UILabel *nameLabel;//


@property (nonatomic,strong) MerchantsModel *model;

/** 代理对象 */
@property (nonatomic, weak) id<DetailListCellDelegate> delegate;

@end
