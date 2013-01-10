#import <UIKit/UIKit.h>

@interface JCActivityBarItemView : UIView

@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;
@property (strong, nonatomic) UILabel* messageLabel;

- (CGSize) sizeForMessage:(NSString*)message maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

@end
