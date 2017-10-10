//
//  RootMiddleView.m
//  WisdomCommunity
//
//  Created by Admin on 2017/3/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "RootMiddleView.h"

@implementation RootMiddleView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self collection];
    return self;
}
-(void)collection
{
    //初始化图片数组
    _iconArray = [NSArray arrayWithObjects:@"icon_guanjia",@"icon_baoxiu",@"icon_gonggao",@"icon_tousu",@"icon_advise",@"icon_forum",nil];
    self.promptArray = @[@"物业管家",@"物业报修",@"社区公告",@"投诉建议"];
    
    for (int i=0; i<4; i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(CXCWidth*62+CXCWidth*(62+110)*i,35*CXCWidth,110*CXCWidth,CXCWidth*160)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+10;
        [self addSubview:btn];
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,110*CXCWidth,110*CXCWidth)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_iconArray[i]]];
        [btn addSubview:topImgV];
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(-15*CXCWidth,topImgV.bottom+20*CXCWidth,140*CXCWidth,30*CXCWidth)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.text =[NSString stringWithFormat:@"%@",_promptArray[i]];
        [btn addSubview:botLabel];
    }
    
   
}
- (void)myBtnAciton:(UIButton *)btn
{
    switch (btn.tag) {
        case 10:
            [self.delegate propertyHousekeeper];

            break;
        case 11:
            [self.delegate propertyService];

            break;
        case 12:
            [self.delegate communityPAnnouncement];

            break;
        case 13:
            [self.delegate complaintsSuggestions];

            break;
        case 14:

            break;
        case 15:
            [self.delegate CommunityActiveBBS];

            break;

        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
