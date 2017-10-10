//
//  ScoreTableViewCell.h
//  WisdomCommunity
//
//  Created by Admin on 2017/5/3.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type;
@property(nonatomic,retain)NSDictionary *dic;

@end
