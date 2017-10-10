//
//  SendActivityViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//  发布活动

#import <UIKit/UIKit.h>
#import "CYDataView.h"
#import "ZHPickView.h"

@interface SendActivityViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZHPickViewDelegate>
@property(nonatomic,retain)NSMutableArray *picUrlArr;
@property(nonatomic,retain)NSMutableArray *picIdArr;
@property(nonatomic,retain)NSMutableArray *picArr;

@property(nonatomic,strong)ZHPickView *pickview;

@property (nonatomic,strong) UITextField *activityTitleTextField;//标题
@property (nonatomic,strong) UITextField *addressTextField;//活动地点
@property (nonatomic,strong) UITextView *activityTextView;//活动内容


//显示选择的照片
@property (nonatomic,strong) UIImageView *showSPictureImage1;
@property (nonatomic,strong) UIImageView *showSPictureImage2;
@property (nonatomic,strong) UIImageView *showSPictureImage3;
@property (nonatomic,strong) UIImageView *showSPictureImage4;
@property (nonatomic,strong) UIImageView *showSPictureImage5;
@property (nonatomic,strong) UIImageView *showSPictureImage6;
@property (nonatomic,assign) NSInteger sendAClickPictureInt;
@property (nonatomic,strong) NSMutableArray *uploadImageVArray;//上传图片数组


//@property (nonatomic,strong) UIView *shadowView;//背景
@property (nonatomic,strong) CYDataView *dataSendView;

@property (nonatomic,strong) NSString *begindata;//开始日期

@end
