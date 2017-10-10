//
//  MerchantsTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  商家详情页cell

#import <UIKit/UIKit.h>
#import "MerchantsModel.h"

@class MerchantsTableViewCell;
@protocol MenuItemCellDelegate <NSObject>

@optional
- (void)MerchantsTableViewCellButton:(MerchantsTableViewCell *)itemCell;
//加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect;
@end


@interface MerchantsTableViewCell : UITableViewCell

//加减按钮
@property (nonatomic,strong) PKYStepper *hideButtonStepper;
@property (nonatomic,weak) UILabel *numberLabel;//
@property (nonatomic,weak) UIImageView *goodsImage;//
@property (nonatomic,weak) UILabel *nameLabel;//
@property (nonatomic,weak) UILabel *contentLabel;//
@property (nonatomic,weak) UILabel *moneyLabel;//


@property (nonatomic,strong) MerchantsModel *model;


/** 代理对象 */
@property (nonatomic, weak) id<MenuItemCellDelegate> delegate;

@end
