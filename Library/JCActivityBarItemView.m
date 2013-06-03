#import "JCActivityBarItemView.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kJCActivityBarItemViewImageSize = 24.0;
static CGFloat const kJCActivityBarItemViewPadding = 10.0;

@implementation JCActivityBarItemView

- (id) init {
  self = [super init];
  if (self) {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.layer.cornerRadius = 6;

    self.messageLabel = [UILabel new];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.adjustsFontSizeToFitWidth = YES;
    self.messageLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.messageLabel.font = [UIFont boldSystemFontOfSize:14];
		self.messageLabel.shadowColor = [UIColor blackColor];
		self.messageLabel.shadowOffset = CGSizeMake(0, -1);
    self.messageLabel.numberOfLines = 0;
    [self addSubview:self.messageLabel];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:self.activityIndicator];

    self.iconView = [UIImageView new];
    self.iconView.contentMode = UIViewContentModeCenter;
    self.iconView.bounds = CGRectMake(0, 0, kJCActivityBarItemViewImageSize, kJCActivityBarItemViewImageSize);
    [self addSubview:self.iconView];
  }
  return self;
}

- (void) layoutSubviews {
  CGPoint iconCenter = CGPointMake(kJCActivityBarItemViewPadding + (kJCActivityBarItemViewImageSize / 2.0),
                                   self.bounds.size.height / 2.0);
  self.activityIndicator.center = iconCenter;
  self.iconView.center = iconCenter;

  CGFloat messageLabelX = kJCActivityBarItemViewImageSize + (kJCActivityBarItemViewPadding * 2.0);
  self.messageLabel.frame = CGRectMake(messageLabelX,
                                       kJCActivityBarItemViewPadding,
                                       self.bounds.size.width - messageLabelX - kJCActivityBarItemViewPadding,
                                       self.bounds.size.height - (kJCActivityBarItemViewPadding * 2.0));
}

- (CGSize) sizeForMessage:(NSString*)message maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight {
  CGFloat maxMessageWidth = maxWidth - (kJCActivityBarItemViewPadding * 3) - kJCActivityBarItemViewImageSize;
  CGFloat maxMessageHeight = maxHeight - (kJCActivityBarItemViewPadding * 2);
  CGSize messageSize = [message sizeWithFont:self.messageLabel.font
                           constrainedToSize:CGSizeMake(maxMessageWidth, maxMessageHeight)];

  CGFloat width = fmaxf(messageSize.width, kJCActivityBarItemViewImageSize)
    + (kJCActivityBarItemViewPadding * 3)
    + kJCActivityBarItemViewImageSize;
  CGFloat height = fmaxf(messageSize.height, kJCActivityBarItemViewImageSize)
    + (kJCActivityBarItemViewPadding * 2);

  return CGSizeMake(width, height);
}

@end
