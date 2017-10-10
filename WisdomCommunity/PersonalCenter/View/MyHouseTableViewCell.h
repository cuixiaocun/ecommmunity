//
//  MyHouseTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHouseModel.h"
@interface MyHouseTableViewCell : UITableViewCell


@property (nonatomic,weak) UILabel *addressLabel;//
//@property (nonatomic,weak) UILabel *certificationLable;//
@property (nonatomic,weak) UILabel *promptLabel;//
@property (nonatomic,weak) UIButton *switchButton;

@property (nonatomic,strong) MyHouseModel *model;

@end
