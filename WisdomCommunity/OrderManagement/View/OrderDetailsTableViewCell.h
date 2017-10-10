//
//  OrderDetailsTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"
@interface OrderDetailsTableViewCell : UITableViewCell

@property (nonatomic,weak) UILabel *moneyLabel;//
@property (nonatomic,weak) UILabel *nameLabel;//
@property (nonatomic,weak) UILabel *numberLabel;//

@property (nonatomic,strong) OrderDetailsModel *model;

@end
