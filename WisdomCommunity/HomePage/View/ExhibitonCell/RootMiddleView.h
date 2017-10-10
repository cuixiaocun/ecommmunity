//
//  RootMiddleView.h
//  WisdomCommunity
//
//  Created by Admin on 2017/3/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RootMiddleViewDelegate <NSObject>
- (void) propertyHousekeeper;//物业管家
- (void) communityMall;//社区商城
- (void) propertyService;//物业报修
- (void) communityPAnnouncement;//社区公告
- (void) complaintsSuggestions;//投诉建议
- (void) CommunityActiveBBS;//社区大小事
@end
@interface RootMiddleView : UIView
@property (nonatomic,weak) id<RootMiddleViewDelegate> delegate;//协议

//图片数组
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *promptArray;
-(instancetype)initWithFrame:(CGRect)frame;
@end
