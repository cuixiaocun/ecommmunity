//
//  ComMallTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区商城首页展示tableviewcell

#import <UIKit/UIKit.h>
#import "ComMallTModel.h"

@interface ComMallTableViewCell : UITableViewCell

@property (nonatomic,strong) ComMallTModel *mallModel;

@property (nonatomic,weak) UIImageView *goodsImage;
@property (nonatomic,weak) UILabel *goodsNameLable;
@property (nonatomic,weak) UILabel *goodsPromptLable;
@property (nonatomic,weak) UILabel *goodsPriceLable;
@property (nonatomic,weak) UILabel *goodsNumberLable;

@end
