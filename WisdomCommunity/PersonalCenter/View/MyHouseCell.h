//
//  MyHouseVC.h
//  WisdomCommunity
//
//  Created by Admin on 2017/5/5.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHouseCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type;
@property(nonatomic,retain)NSDictionary *dic;

@end
