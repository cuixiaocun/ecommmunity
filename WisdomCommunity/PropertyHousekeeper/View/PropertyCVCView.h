//
//  PropertyCVCView.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业管家UIView

#import <UIKit/UIKit.h>
#import "PropertyCollectionViewCell.h"
//协议
@protocol OnClickPCVDelegate <NSObject>
- (void) propertyPayment;//物业缴费
- (void) propertyManagementService;//物业报修
- (void) surrounding;//周边
- (void) complaintsPCVSuggestions;//投诉建议
- (void) lifeService;//生活服务
- (void) billPayment;//缴费服务
@end
@interface PropertyCVCView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mainPCVCollectionView;
}



@property (nonatomic,strong) PropertyCollectionViewCell  *cell;
@property (nonatomic,weak) id<OnClickPCVDelegate> PCVDelegate;//协议

//图片数组
@property (nonatomic,strong) NSArray *iconPCVArray;
@property (nonatomic,strong) NSArray *promptPCVArray;


@end
