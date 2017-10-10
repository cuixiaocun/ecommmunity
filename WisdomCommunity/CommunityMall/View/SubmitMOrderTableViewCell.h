//
//  SubmitMOrderTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单结算

#import <UIKit/UIKit.h>
#import "SubmitMOrderModel.h"
@interface SubmitMOrderTableViewCell : UITableViewCell

@property (nonatomic,weak) UILabel *moneyLabel;//
@property (nonatomic,weak) UILabel *nameLabel;//
@property (nonatomic,weak) UILabel *numberLabel;//

@property (nonatomic,strong) SubmitMOrderModel *model;

@end
