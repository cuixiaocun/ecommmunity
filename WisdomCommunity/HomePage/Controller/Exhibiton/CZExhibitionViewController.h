//
//  CZExhibitionViewController.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/27.
//  Copyright © 2016年 bridge. All rights reserved.
//  油画列表

#import <UIKit/UIKit.h>
#import "CZExhibitionDetailsController.h"
typedef NS_ENUM(NSInteger, ExhibitionType){
    TypeOilPainting,//油画
    TypeDecoration//装饰
};


@interface CZExhibitionViewController : UIViewController

@property (nonatomic, assign) ExhibitionType type;
@property (nonatomic, strong) UITableView    *tableview;
@property (nonatomic, strong) NSMutableArray *listOilPainArray;//油画
@property (nonatomic, strong) NSMutableArray *listDecorationArray;//装饰

@property (nonatomic, strong) UIImageView *CZExhibitionPromptImage;



- (instancetype)initWithType:(ExhibitionType)type;


@end
