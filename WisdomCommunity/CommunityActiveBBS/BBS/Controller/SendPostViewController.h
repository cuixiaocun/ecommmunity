//
//  SendPostViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  发布帖子

#import <UIKit/UIKit.h>

@interface SendPostViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,retain)NSMutableArray *picUrlArr;
@property(nonatomic,retain)NSMutableArray *picIdArr;
@property(nonatomic,retain)NSMutableArray *picArr;

@property (nonatomic,strong) UITextField *postTitleTextField;//标题
@property (nonatomic,strong) UITextView *postContentTextView;//帖子内容

////显示选择的照片
//@property (nonatomic,strong) UIImageView *showPictureImage1;
//@property (nonatomic,strong) UIImageView *showPictureImage2;
//@property (nonatomic,strong) UIImageView *showPictureImage3;
//@property (nonatomic,strong) UIImageView *showPictureImage4;
//@property (nonatomic,strong) UIImageView *showPictureImage5;
//@property (nonatomic,strong) UIImageView *showPictureImage6;
@property (nonatomic,strong) NSMutableArray *uploadImageVArray;//上传图片数组
//标签
@property (nonatomic,strong) UIButton *bazaarButton;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) UIButton *hotButton;
@property (nonatomic,strong) NSString *PostLabelStr;//帖子标签 1:热点 2:分享 3:集市

@property (nonatomic,assign) NSInteger ClickPictureInt;

@end
