//
//  JCActivityBarDemoViewController.m
//  JCActivityBarDemo
//
//  Created by James Coleman on 1/9/13.
//  Copyright (c) 2013 James Coleman. All rights reserved.
//

#import "JCActivityBarDemoViewController.h"
#import "JCActivityBar.h"

@interface JCActivityBarDemoViewController ()

@property (weak, nonatomic) IBOutlet UILabel* secondsDelayLabel;
@property (weak, nonatomic) IBOutlet UIStepper* secondsDelayStepper;
@property (weak, nonatomic) IBOutlet UITextField* messageTextField;

@property (strong, nonatomic) JCActivityBar* activityBar;

@end

@implementation JCActivityBarDemoViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    
  }
  return self;
}

- (void) viewDidLoad {
  if (!self.activityBar) {
    self.activityBar = [[JCActivityBar alloc] init];
    [self.activityBar positionInBottomOfView:self.view withBottomOffset:20.0];
  }
  [self.view addSubview:self.activityBar];
}

- (IBAction) displayMessageButtonTapped:(UIButton*)sender {
  [self.messageTextField resignFirstResponder];

  sender.enabled = NO;
  [self.activityBar displayActivityWithMessage:self.messageTextField.text];
  float delayInSeconds = self.secondsDelayStepper.value;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    sender.enabled = YES;
    [self.activityBar finishWithSuccess:@"Finished! (With rather long explanatory message that will likely overflow onto multiple lines.)"];
  });
}

- (IBAction) secondsDelayStepperValueChanged:(UIStepper*)sender {
  self.secondsDelayLabel.text = [NSString stringWithFormat:@"Seconds: %i", (NSInteger)self.secondsDelayStepper.value];
}

@end
