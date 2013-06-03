#import "JCActivityBar.h"
#import "JCActivityBarItemView.h"

static CGFloat const kJCActivityBarItemAnimationDuration = 0.3;

CGFloat JCActivityBarDefaultMaxWidth() {
  if (([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)) {
    return 600.0;
  } else {
    return 300.0;
  }
}

CGFloat JCActivityBarDefaultMaxHeight() {
  if (([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)) {
    return 300.0;
  } else {
    return 220.0;
  }
}

@interface JCActivityBar ()

@property (nonatomic) CGFloat offset;

@property (strong, nonatomic) JCActivityBarItemView* currentItemView;

@end

@implementation JCActivityBar

- (id) init {
  self = [super init];
  if (self) {
    self.maxWidth = JCActivityBarDefaultMaxWidth();
    self.maxHeight = JCActivityBarDefaultMaxHeight();
    self.clipsToBounds = NO;
  }
  return self;
}

- (void) displayActivityWithMessage:(NSString*)message {
  if (self.currentItemView) {
    [self animateOut:self.currentItemView];
  }

  JCActivityBarItemView* itemView = [[JCActivityBarItemView alloc] init];
  [self positionItemView:itemView forMessage:message];
  itemView.messageLabel.text = message;
  [itemView.activityIndicator startAnimating];
  [self animateIn:itemView];
  self.currentItemView = itemView;
  [self addSubview:itemView];
}

- (void) finishWithSuccess:(NSString*)message {
  [self positionItemView:self.currentItemView forMessage:message];
  self.currentItemView.iconView.image = [UIImage imageNamed:@"258-checkmark-white"];
  self.currentItemView.messageLabel.text = message;
  [self finish];
}

- (void) finishWithError:(NSString*)message {
  [self positionItemView:self.currentItemView forMessage:message];
  self.currentItemView.iconView.image = [UIImage imageNamed:@"184-warning-white"];
  self.currentItemView.messageLabel.text = message;
  [self finish];
}

- (void) finish {
  JCActivityBarItemView* itemView = self.currentItemView;
  [itemView.activityIndicator stopAnimating];

  float delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    if (self.currentItemView == itemView) {
      [UIView animateWithDuration:kJCActivityBarItemAnimationDuration animations:^{
        [self animateOut:itemView];
      }];
      self.currentItemView = nil;
    }
  });
}

- (void) positionInBottomOfView:(UIView*)view withBottomOffset:(CGFloat)offset {
  NSParameterAssert(view);

  self.offset = offset;
  self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
                          | UIViewAutoresizingFlexibleLeftMargin
                          | UIViewAutoresizingFlexibleRightMargin;
  self.frame = CGRectMake(0.0, view.bounds.size.height - offset, view.bounds.size.width, 0.0);
  self.maxWidth = fminf(JCActivityBarDefaultMaxWidth(), view.bounds.size.width);
  self.maxHeight = fminf(JCActivityBarDefaultMaxHeight(), (view.bounds.size.height / 2.0));
}

- (void) animateIn:(JCActivityBarItemView*)itemView {
  itemView.alpha = 0;
  [UIView animateWithDuration:kJCActivityBarItemAnimationDuration animations:^{
    itemView.alpha = 1.0;
  }];
}

- (void) animateOut:(JCActivityBarItemView*)itemView {
  [UIView animateWithDuration:kJCActivityBarItemAnimationDuration animations:^{
    CGRect frame = itemView.frame;
    frame.origin.y = (frame.origin.y + frame.size.height + self.offset);
    itemView.frame = frame;
    itemView.alpha = 0.0;
  }];
}

- (void) positionItemView:(JCActivityBarItemView*)itemView forMessage:(NSString*)message {
  NSParameterAssert(itemView);

  CGSize itemSize = [itemView sizeForMessage:message
                                maxWidth:self.maxWidth
                               maxHeight:self.maxHeight];
  CGSize selfSize = self.bounds.size;
  itemView.frame = CGRectMake((selfSize.width - itemSize.width) / 2.0,
                              -itemSize.height,
                              itemSize.width,
                              itemSize.height);
  itemView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (void) resizeItemView:(JCActivityBarItemView*)itemView forMessage:(NSString*)message {
  NSParameterAssert(itemView);

  CGRect frame = itemView.frame;
  frame.size = [itemView sizeForMessage:message
                               maxWidth:self.maxWidth
                              maxHeight:self.maxHeight];
  itemView.frame = frame;
}

@end
