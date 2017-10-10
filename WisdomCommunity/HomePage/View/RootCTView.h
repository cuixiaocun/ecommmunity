//
//  RootCTView.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootCollectionViewCell.h"
//协议
@protocol OnClickCollectionDelegate <NSObject>
- (void) propertyHousekeeper;//物业管家
- (void) communityMall;//社区商城
- (void) propertyService;//物业报修
- (void) communityPAnnouncement;//社区公告
- (void) complaintsSuggestions;//投诉建议
- (void) CommunityActiveBBS;//社区大小事
@end

@interface RootCTView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mainCollectionView;
}
@property (nonatomic,weak) id<OnClickCollectionDelegate> delegate;//协议
//cell初始化
@property (nonatomic,strong) RootCollectionViewCell  *cell;//collectionCell
//图片数组
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *promptArray;
@end
