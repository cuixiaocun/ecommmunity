//
//  MerchantsHeadView.h
//  WisdomCommunity
//
//  Created by bridge on 17/1/7.
//  Copyright © 2017年 bridge. All rights reserved.
//  商家顶部view

#import <UIKit/UIKit.h>

@interface MerchantsHeadView : UIView

@property (nonatomic,strong) NSDictionary *headDict;
- (void) initMHVUI:(NSDictionary *)dict withJsonStr:(NSString *)JsonString;
@end
