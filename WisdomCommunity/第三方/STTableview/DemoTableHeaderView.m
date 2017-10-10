//
// DemoTableHeaderView.m
//
// @author Shiki
//

#import "DemoTableHeaderView.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoTableHeaderView

@synthesize title;
@synthesize time;
@synthesize arrowImage;
@synthesize activityIndicator;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 20)];
    self.title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.title.font = [UIFont boldSystemFontOfSize:13.0f];
    self.title.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.title.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.title.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.title.backgroundColor = [UIColor clearColor];
    self.title.textAlignment = UITextAlignmentCenter;
    [self addSubview:self.title];
    
    
    
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 20)];
    self.time.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.time.font = [UIFont boldSystemFontOfSize:10.0f];
    self.time.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.time.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.time.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.time.backgroundColor = [UIColor clearColor];
    self.time.textAlignment = UITextAlignmentCenter;
    [self addSubview:self.time];
    
    
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(95.0f, 5, 20.0f, 25.0f);
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        layer.contentsScale = [[UIScreen mainScreen] scale];
    }
#endif
    
    [[self layer] addSublayer:layer];
    self.arrowImage=layer;
    
    
    
    [super awakeFromNib];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
    [title release];
    [activityIndicator release];
    [super dealloc];
}

@end
