//
//  AddressMangeTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//  收货地址

#import <UIKit/UIKit.h>
#import "AddressMangeModel.h"
//协议
@protocol OnClickEditDelegate <NSObject>
- (void) ClickEditImage:(NSString *)addressid;//
@end
@interface AddressMangeTableViewCell : UITableViewCell

@property (nonatomic,weak) UILabel *nameLabel;//
@property (nonatomic,weak) UILabel *addressLabel;//
@property (nonatomic,weak) UIImageView *eidtImageView;//编辑按钮

@property (nonatomic,strong) AddressMangeModel *model;


@property (nonatomic,weak) id<OnClickEditDelegate> delegate;//协议

@end
