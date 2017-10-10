//
//  LoginCell.m
//  WisdomCommunity
//
//  Created by Admin on 2017/5/15.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "LoginCell.h"

@implementation LoginCell

{

    UILabel *labe;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labe = [[UILabel alloc]initWithFrame:CGRectMake(20*CXCWidth, 0,CYScreanW*290.0/375.0-20*CXCWidth , 80*CXCWidth)];
        labe.tag = 10101010;
        labe.font = [UIFont boldSystemFontOfSize:14];
        labe.textColor = [UIColor grayColor];
        [self addSubview:labe];
    }
    
    return self;
    
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameStr =nameStr;
    labe.text =_nameStr;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
