//
//  SetHeadViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  设置头像

#import <UIKit/UIKit.h>

@interface SetHeadViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView *imageViewR;//圆

@property (nonatomic,strong) NSString *headString;//头像

//点击事件
-(void) setHeadOnClickButton:(id)sender;

@end
