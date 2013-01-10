Why?
----

I needed to display status/activity views that still allow user interaction in the rest of the view. Unlike what many other projects do, I needed to display the status view per view (or view controller), rather than globally throughout the app. I didn't find any projects that fulfilled my needs, so I authored this project.

What?
-----

JCActivityBar allows to add a view to any view controller that handles displaying status/activity messages.

![Sample application screenshot with activity in progress](https://github.com/jcoleman/JCActivityBar/raw/master/screenshot-activity-message.png "Sample application screenshot with activity in progress")

![Sample application screenshot with activity successfully finished](https://github.com/jcoleman/JCActivityBar/raw/master/screenshot-success-message.png "Sample application screenshot with activity successfully finished")

![Sample application screenshot with activity finished with error](https://github.com/jcoleman/JCActivityBar/raw/master/screenshot-error-message.png "Sample application screenshot with activity finished with error")

Example Code?
-------------

A working sample iOS Xcode project is available in the `Demo` directory.

Usage?
----

    #import "JCActivityBar.h"
    
    - (void) viewDidLoad {
      if (!self.activityBar) {
        self.activityBar = [[JCActivityBar alloc] init];
        [self.activityBar positionInBottomOfView:self.view withBottomOffset:20.0];
      }
      [self.view addSubview:self.activityBar];
    }
    
    - (IBAction) displayMessageButtonTapped:(UIButton*)sender {
      [self.activityBar displayActivityWithMessage:@"Activity description."];
      float delayInSeconds = self.secondsDelayStepper.value;
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.activityBar finishWithSuccess:@"Finished!"];
        // Or the following for an error:
        // [self.activityBar finishWithError:@"Error."];
      });
    }

Installation?
-------------

This project includes a `podspec` for usage with [CocoaPods](http://http://cocoapods.org/). Simply add

    pod 'JCActivityBar'

to your `Podfile` and run `pod install`.

Alternately, you can add all of the files contained in this project's `Library` directory to your Xcode project. If your project does not use ARC, you will need to enable ARC on these files. You can enable ARC per-file by adding the -fobjc-arc flag, as described on [a common StackOverflow question](http://stackoverflow.com/questions/6646052/how-can-i-disable-arc-for-a-single-file-in-a-project).

Credits
-------

The icons are from Glyphish Pro which can be licensed for unlimited projects at the small cost of $25 at http://www.glyphish.com (no, it's not my project!) If you use this project, you need to either replace the icons or license Glyphish Pro.

Acknowledgements
----------------

This project was inspired by Zac Altman's ZAActivityBar project which can be found at https://github.com/zacaltman/ZAActivityBar/. Unlike Zac's project, I needed my activity bar to be linked to specific views (for examnple, per view controller) rather than global for the app.

Licence
-------

This project is licensed under the MIT license. All copyright rights are retained by myself.

Copyright (c) 2013 James Coleman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.