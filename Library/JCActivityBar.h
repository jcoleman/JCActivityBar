#import <UIKit/UIKit.h>

@interface JCActivityBar : UIView

@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat maxHeight;

- (void) positionInBottomOfView:(UIView*)view withBottomOffset:(CGFloat)offset;
- (void) displayActivityWithMessage:(NSString*)message;
- (void) finishWithSuccess:(NSString*)message;
- (void) finishWithError:(NSString*)message;

@end
