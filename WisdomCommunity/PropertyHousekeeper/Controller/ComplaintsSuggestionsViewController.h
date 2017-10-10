//
//  ComplaintsSuggestionsViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  投诉建议页面

#import <UIKit/UIKit.h>

@interface ComplaintsSuggestionsViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSMutableArray *picUrlArr;
@property(nonatomic,retain)NSMutableArray *picIdArr;
@property(nonatomic,retain)NSMutableArray *picArr;
@property (nonatomic, copy)NSString *imageAddress;//图片地址

@property (nonatomic,strong) UITableView *typeComplaintsTableView;//房屋列表

@property (nonatomic,strong) UITextField *complaintsTextField;
@property (nonatomic,strong) UITextField *phoneSTextField;
@property (nonatomic,strong) UITextView *problemDescriptionTextView;
@property (nonatomic,strong) UIButton *typeButton;//投诉类型
@property (nonatomic,strong) UIImageView *showPictureImmage;//展示
@property (nonatomic,strong) UIImageView *fullScreenImmage;


//数据请求
@property (nonatomic,strong) NSArray *typeConplabtsArray;//投诉类型
@property (nonatomic,strong) NSString *imgageUrl;//图片URL
@property (nonatomic,strong) NSString *typeId;//类型
@property (nonatomic,strong) NSMutableArray *uploadImageVArray;//上传图片数组

@end
