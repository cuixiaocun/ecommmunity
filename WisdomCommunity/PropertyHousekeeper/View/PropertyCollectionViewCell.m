//
//  PropertyCollectionViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PropertyCollectionViewCell.h"

@implementation PropertyCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.topPImage = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW * 0.12, CYScreanW * 0.12)];
        self.topPImage.backgroundColor = [UIColor whiteColor];
        self.topPImage.userInteractionEnabled = YES;
        [self.contentView addSubview:self.topPImage];
        self.promtpPLabel = [[UILabel alloc] initWithFrame:CGRectMake( -CYScreanW * 0.05, CYScreanW * 0.12, CYScreanW * 0.22, (CYScreanH - 64) * 0.06)];
        self.promtpPLabel.textColor = [UIColor blackColor];
        self.promtpPLabel.textAlignment = NSTextAlignmentCenter;
        self.promtpPLabel.font = [UIFont fontWithName:@"Arial" size:13];
        self.promtpPLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.promtpPLabel];
    }
    return self;
}
@end
