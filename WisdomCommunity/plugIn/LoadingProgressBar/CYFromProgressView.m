//
//  CYFromProgressView.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CYFromProgressView.h"

@implementation CYFromProgressView

//初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
//显示提示框
- (void) showMBprogrossHUD:(NSString *)promptString
{
    self.frame = CGRectMake( 0, 0, CYScreanW, CYScreanH);
    self.labelText = promptString;
    self.labelFont = [UIFont fontWithName:@"Arial" size:17];
    self.labelColor = [UIColor blackColor];
    self.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.color = [UIColor clearColor];
    [self setMode:MBProgressHUDModeText];//显示形式
    self.taskInProgress = YES;
    [self show:YES];
    [self hide:YES afterDelay:2.0];
}


@end
