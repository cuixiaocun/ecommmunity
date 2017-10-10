//
//  RealNameViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyri  ght © 2016年 bridge. All rights reserved.
//  真实姓名等

#import <UIKit/UIKit.h>

@interface RealNameViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *nameTextField;

@property (nonatomic,assign) NSInteger typeInt;
@property (nonatomic,strong) NSString *beforeString;//之前的数据

@end
