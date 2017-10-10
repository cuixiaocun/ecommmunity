//
//  SmallShopViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  我要开微店

#import <UIKit/UIKit.h>

@interface SmallShopViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>



@property (nonatomic,strong) UITextField *nameSSTextField;
@property (nonatomic,strong) UITextField *phoneSSTextField;
@property (nonatomic,strong) UITextField *storeNameTextField;
@property (nonatomic,strong) UITextView *storePromptTextView;

@property (nonatomic,strong) UIImageView *storeImage;
@property (nonatomic,strong) NSString *uploadImageUrl;//图片url

@end
