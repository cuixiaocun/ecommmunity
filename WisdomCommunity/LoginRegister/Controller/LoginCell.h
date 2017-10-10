//
//  LoginCell.h
//  WisdomCommunity
//
//  Created by Admin on 2017/5/15.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type;
@property(nonatomic,copy)NSString *nameStr;

@end
