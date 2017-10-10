//
//  MyComplantsTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的投诉

#import <UIKit/UIKit.h>
#import "MyComplaintsModel.h"
#import "EGOImageButton.h"
static CGRect oldframe;
@protocol MyComplantsTableViewCellDelegate <NSObject>

@optional
- (void)showBigPhoto:(NSURL *)str;

@end

@interface MyComplantsTableViewCell : UITableViewCell
{
    NSString *strType;
}

@property (nonatomic,weak) UIImageView *promptImage;
@property (nonatomic,weak) UILabel *promptLabel;
@property (nonatomic,weak) UILabel *resultLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak)  EGOImageButton*imgV;
@property(nonatomic,weak) id<MyComplantsTableViewCellDelegate> delegate;

@property (nonatomic,strong) MyComplaintsModel *model;
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString*)typeStr;


@end
