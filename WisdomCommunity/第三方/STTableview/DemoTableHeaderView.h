//
// DemoTableHeaderView.h
//
// @author Shiki
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface DemoTableHeaderView : UIView {
    
    UILabel *title;
    UILabel *time;
    CALayer *arrowImage;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) IBOutlet CALayer *arrowImage;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
