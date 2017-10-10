//
// DemoTableFooterView.m
//
// @author Shiki
//

#import "DemoTableFooterView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoTableFooterView

@synthesize activityIndicator;
@synthesize infoLabel;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) awakeFromNib
{
  self.backgroundColor = [UIColor clearColor];
    
   self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.infoLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.infoLabel setText:@""];
    self.infoLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    self.infoLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.infoLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.infoLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:self.infoLabel];
    
    
  [super awakeFromNib];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [activityIndicator release];
  [infoLabel release];
  [super dealloc];
}

@end
